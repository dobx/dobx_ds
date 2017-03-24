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
// @created 2017/02/14

import 'package:collection/collection.dart';

import './types.dart';

class MultiCAS extends DelegatingMap<String,List<dynamic>> {
  static Map<String,dynamic> $toMap(MultiCAS item) => item._store;
  static MultiCAS $fromMap(Map<String,dynamic> map, [ MultiCAS item ]) {
    // noop
    return item;
  }
  static MultiCAS $create() {
    return new MultiCAS({});
  }
  static MultiCAS $createObservable() {
    return new MultiCAS({});
  }

  final Map<String,List<dynamic>> _store;

  MultiCAS(Map<String,List<dynamic>> store) : _store = store, super(store);

  List<dynamic> _newValue() {
    return [];
  }

  void addBool(int fieldNumber, bool cmp) {
    _store.putIfAbsent(numericKey(FieldType.BOOL), _newValue)
        .add({ '1': fieldNumber, '2': cmp, '3': !cmp });
  }

  void addBytes(int fieldNumber, String cmp, String val) {
    _store.putIfAbsent(numericKey(FieldType.BYTES), _newValue)
        .add({ '1': fieldNumber, '2': cmp, '3': val });
  }

  void addString(int fieldNumber, String cmp, String val) {
    _store.putIfAbsent(numericKey(FieldType.STRING), _newValue)
        .add({ '1': fieldNumber, '2': cmp, '3': val });
  }

  void addFloat(int fieldNumber, num cmp, num val) {
    _store.putIfAbsent(numericKey(FieldType.FLOAT), _newValue)
        .add({ '1': fieldNumber, '2': cmp, '3': val });
  }

  void addDouble(int fieldNumber, num cmp, num val) {
    _store.putIfAbsent(numericKey(FieldType.DOUBLE), _newValue)
        .add({ '1': fieldNumber, '2': cmp, '3': val });
  }

  void add32(int fieldNumber, int cmp, int val) {
    _store.putIfAbsent(numericKey(FieldType.FIXED32), _newValue)
        .add({ '1': fieldNumber, '2': cmp, '3': val });
  }

  void add64(int fieldNumber, int cmp, int val) {
    _store.putIfAbsent(numericKey(FieldType.FIXED64), _newValue)
        .add({ '1': fieldNumber, '2': cmp, '3': val });
  }

  void addEnum(int fieldNumber, int cmp, int val) {
    _store.putIfAbsent(numericKey(FieldType.INT32), _newValue)
        .add({ '1': fieldNumber, '2': cmp, '3': val });
  }
}
