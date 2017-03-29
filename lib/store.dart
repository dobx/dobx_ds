// ========================================================================
// Copyright 2017 David Yu
// ------------------------------------------------------------------------
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// ========================================================================
// @author dyu
// @created 2017/03/29

import 'dart:math' as math;

import './ds.dart' as ds;
import './rpc.dart' as rpc;
import './util.dart' as util;

import './observables.dart' show StoreState;

abstract class Entity {
  String key;
  int ts;
}

abstract class SelectableItem {
  int get index;
  void reset();
}

abstract class Pair<T> {
  T orig;
  T copy;
}

typedef Pair<T> CreateFn<T>(T value);

typedef void MergeFn<T>(T src, Pair<T> target);

typedef void FetchFn(ds.ParamRangeKey req);

enum FetchType {
  NEWER,
  OLDER,
  UPDATE
}

class Store<T extends Entity> {
  final int pageSize;
  final CreateFn<T> createFn;
  final MergeFn<T> mergeFn;
  final FetchFn fetchFn;
  final StoreState $state = new StoreState();

  bool desc;
  List<Pair<T>> list, mainList;
  SelectableItem _selected;

  FetchType _fetchType;
  int _fetchTs = 0;
  int page = -1;
  String errmsg = '';

  Store(this.pageSize, this.createFn, this.mergeFn, this.fetchFn, {
    bool desc = true,
    List<Pair<T>> list,
  }) : this.desc = desc, this.list = list ?? [] {
    this.mainList = this.list;
  }

  FetchType get fetchType => _fetchType;

  T get latest => desc ? list.first.orig : list.last.orig;

  void cbFetchFailed(dynamic e) {
    errmsg = rpc.getErrMsg(e);
    $state.loading = false;
  }

  void cbFetchSuccess(List<T> p) {
    if (_fetchType == null)
      return;

    switch (_fetchType) {
      case FetchType.NEWER:
        if (p == null || p.isEmpty)
          break;

        if (!list.isEmpty && desc)
          list.insertAll(0, p.reversed.map(createFn));
        else
          list.addAll(p.map(createFn));
        break;
      case FetchType.OLDER:
        if (p == null || p.isEmpty)
          break;
        if (desc)
          list.addAll(p.map(createFn));
        else
          list.insertAll(0, p.reversed.map(createFn));
        break;
      case FetchType.UPDATE:
        _update(p);
        break;
      default:
    }

    _fetchType = null;
    $state.loading = false;
  }

  bool _update(List<T> updateList) {
    var size = list.length;

    if (updateList == null || updateList.isEmpty) {
      if (size <= pageSize) {
        list.clear();
        return true;
      }

      final populatePages = page * pageSize;
      if (desc) {
        list.removeRange(populatePages, size - populatePages);
      } else {
        list.removeRange(0, size - populatePages);
      }
      return true;
    }

    var updateLen = updateList.length,
        populateLen = pageSize,
        populatePages = page * populateLen,
        i = 0,
        removed = 0,
        idx = desc ? populatePages + i : size - populatePages - i - 1;

    Pair<T> pair;
    T update;
    for (;;) {
      update = updateList[i];
      pair = list[idx];
      if (update.key == pair.orig.key) {
        i++;

        mergeFn(update, pair);

        if (desc) {
          idx = populatePages + i;

          if (idx == size) break;
        } else {
          idx = size - populatePages - i - 1;

          if (idx == -1) break;
        }

        if (i != updateLen)
          continue;

        if (updateLen == populateLen)
          break;

        list.removeAt(idx);
        removed++;
        size--;

        break;
      }

      list.removeAt(idx);
      removed++;
      size--;

      if (!desc) {
        idx = size - populatePages - i - 1;

        if (idx == -1) break;
      } else if (idx == size) {
        break;
      }
    }

    if (i < updateLen) {
      final subList = i == 0 ? updateList : updateList.sublist(i);
      if (desc) {
        list.addAll(subList.map(createFn));
      } else {
        list.insertAll(0, subList.reversed.map(createFn));
      }
    }

    return removed != 0;
  }

  bool fetchNewer({
    bool debounce = false,
  }) {
    if ($state.loading)
      return false;

    final empty = list.isEmpty;
    if (empty)
      desc = true;

    // debounce
    var now = new DateTime.now().millisecondsSinceEpoch;
    if (debounce && (now - _fetchTs) < 500) {
      return false;
    }

    var req = ds.ParamRangeKey.$create(empty,
        limit: empty ? pageSize + 1 : pageSize,
        startKey: empty ? null : (desc ? list.first.orig.key : list.last.orig.key));

    _fetchTs = now;
    _fetchType = FetchType.NEWER;
    fetchFn(req);

    errmsg = '';
    $state.loading = true;
    return true;
  }

  bool fetchOlder({
    bool debounce = false,
  }) {
    if (list.isEmpty || $state.loading)
      return false;

    // debounce
    var now = new DateTime.now().millisecondsSinceEpoch;
    if (debounce && (now - _fetchTs) < 500) {
      return false;
    }

    var req = ds.ParamRangeKey.$create(true,
        limit: pageSize,
        startKey: desc ? list.last.orig.key : list.first.orig.key);

    _fetchTs = now;
    _fetchType = FetchType.OLDER;
    fetchFn(req);

    errmsg = '';
    $state.loading = true;
    return true;
  }


  bool fetchUpdate({
    bool debounce = false,
  }) {
    if (list.isEmpty)
      return fetchNewer(debounce: debounce);

    if ($state.loading)
      return false;

    // debounce
    var now = new DateTime.now().millisecondsSinceEpoch;
    if (debounce && (now - _fetchTs) < 500) {
      return false;
    }

    // the first item in the visible list
    var pair = list[page * pageSize];

    var req = ds.ParamRangeKey.$create(desc,
      limit: math.min(pageSize, list.length),
      startKey: desc ? util.incrementKey(pair.orig.key) : util.decrementKey(pair.orig.key),
    );

    _fetchTs = now;
    _fetchType = FetchType.UPDATE;
    fetchFn(req);

    errmsg = '';
    $state.loading = true;
    return true;
  }

  bool isVisible(int idx) {
    final pageStart = page * pageSize;
    return pageStart == idx || (idx > pageStart && idx < (pageStart + pageSize));
  }

  void select(SelectableItem item) {
    int idx;
    if (_selected != null && (idx=_selected.index) != item.index && isVisible(idx)) {
      _selected.reset();
    }
    _selected = item;
  }

}

