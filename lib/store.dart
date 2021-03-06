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
export './observables.dart' show StoreState;

abstract class Entity {
  String key;
  int ts;
}

abstract class SelectableItem {
  int get index;
  void reset();
}

abstract class Pair<T> {
  T get orig;
  T get copy;
}

typedef void ValueChanged<T>(T value);

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
  final int multiplier;

  bool _desc;
  List<Pair<T>> list;
  SelectableItem _selected;

  FetchType _fetchType;
  int _fetchTs = 0;
  int page = -1;
  String errmsg = '';

  Store(this.pageSize, this.createFn, this.mergeFn, this.fetchFn, {
    int multiplier = 1,
    bool desc = true,
    List<Pair<T>> list,
  })
      : this.multiplier = multiplier,
        this._desc = desc,
        this.list = list ?? [];

  bool get desc => _desc;
  bool get $desc { $state.$sub(StoreState.DESC); return _desc; }

  FetchType get fetchType => _fetchType;

  T get latest => _desc ? list.first.orig : list.last.orig;

  void prepend(T message) {
    list.insert(0, createFn(message));
  }

  void prependAll(List<T> l, [ bool reversed = false ]) {
    if (reversed) {
      for (var i = l.length; i-- > 0;)
        list.insert(0, createFn(l[i]));
    } else {
      for (var i = 0, len = l.length; i < len; i++)
        list.insert(0, createFn(l[i]));
    }
  }

  void append(T message) {
    list.add(createFn(message));
  }

  void appendAll(List<T> l, [ bool reversed = false ]) {
    if (reversed) {
      for (var i = l.length; i-- > 0;)
        list.add(createFn(l[i]));
    } else {
      for (var i = 0, len = l.length; i < len; i++)
        list.add(createFn(l[i]));
    }
  }

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

        if (!list.isEmpty && _desc)
          prependAll(p, true);
        else
          appendAll(p);
        break;
      case FetchType.OLDER:
        if (p == null || p.isEmpty)
          break;

        if (_desc)
          appendAll(p);
        else
          prependAll(p, true);
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
      list.removeRange(populatePages, size - populatePages);
      return true;
    }

    var updateLen = updateList.length,
        populateLen = pageSize,
        populatePages = page * populateLen,
        i = 0,
        removed = 0,
        idx = populatePages;

    Pair<T> pair;
    T update;
    for (;;) {
      update = updateList[i];
      pair = list[idx];
      if (update.key == pair.orig.key) {
        i++;

        mergeFn(update, pair);

        if (++idx == size)
          break;

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

      if (idx == size)
        break;
    }

    if (i < updateLen) {
      list.addAll(i == 0 ? updateList.map(createFn) : updateList.getRange(i, updateLen).map(createFn));
    }

    return removed != 0;
  }

  bool fetchNewer({
    bool debounce = false,
  }) {
    if ($state.loading)
      return false;

    // debounce
    var now = new DateTime.now().millisecondsSinceEpoch;
    if (debounce && (now - _fetchTs) < 500) {
      return false;
    }

    final empty = list.isEmpty;
    if (empty && !_desc) {
      _desc = true;
      $state.$pub(StoreState.DESC);
    }

    var req = ds.ParamRangeKey.$create(empty,
        limit: empty ? pageSize * multiplier + 1 : (_desc ? pageSize : pageSize * multiplier),
        startKey: empty ? null : (_desc ? list.first.orig.key : list.last.orig.key));

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
        limit: _desc ? pageSize * multiplier : pageSize,
        startKey: _desc ? list.last.orig.key : list.first.orig.key);

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

    var req = ds.ParamRangeKey.$create(_desc,
      limit: math.min(pageSize, list.length),
      startKey: _desc ? util.incrementKey(pair.orig.key) : util.decrementKey(pair.orig.key),
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

  bool toggleDesc<T>([ ValueChanged<T> cb, T arg]) {
    if ($state.loading)
      return _desc;

    final val = !_desc;
    _desc = val;

    if (list.length > 1)
      list = list.reversed.toList(growable: true);

    if (cb != null)
      cb(arg);

    $state.$pub(StoreState.DESC);
    return val;
  }

  String page_info(int page) {
    final size = list.length;
    if (size == 0)
      return '';

    final start = (page * pageSize) + 1,
        end = start + pageSize - 1;

    if (start == size)
      return '$start of $size';

    return '$start - ${math.min(end, size)} of $size';
  }
}

