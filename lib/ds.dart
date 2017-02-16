// Generated by fbsgen from p/ds

import 'package:dobx/dobx.dart' show PubSub;
import './mc.dart' show MultiCAS;
export './mc.dart' show MultiCAS;


/// message ParamId {
///   required uint32 id = 1;
/// }
class ParamId {
  static ParamId fromMap(Map<String,dynamic> map, [ ParamId item ]) {
    if (map == null) return item;

    item ??= new ParamId();
    item._id = map["1"];
    return item;
  }
  static ParamId $(dynamic data) {
      if (data is Map)
        return fromMap(data as Map<String,dynamic>);

      throw data;
  }
  static Map<String,dynamic> toMap(ParamId item) => {
    "1": item._id,
  };
  static ParamId $create(
    int id, 
  ) {
    assert (id != null);
    return new ParamId()
      .._id = id;
  }
  static ParamId $createObservable({
    int id = 0,
  }) {
    return new _ParamId()
      .._id = id;
  }

  static const int FN_ID = 1;

  int _id;

  /// required: 1
  int get id => _id;
  void set id(int id) { _id = id; }
}
class _ParamId extends ParamId with PubSub {
  int get id { $sub(1); return _id; }
  void set id(int id) { if (id != null && id == _id) return; _id = id ?? 0; $pub(1); }
}




/// message ParamKey {
///   required bytes key = 1;
///   optional bytes parent_key = 2;
/// }
class ParamKey {
  static ParamKey fromMap(Map<String,dynamic> map, [ ParamKey item ]) {
    if (map == null) return item;

    item ??= new ParamKey();
    item._key = map["1"];
    item._parentKey = map["2"];
    return item;
  }
  static ParamKey $(dynamic data) {
      if (data is Map)
        return fromMap(data as Map<String,dynamic>);

      throw data;
  }
  static Map<String,dynamic> toMap(ParamKey item) => {
    "1": item._key,
    "2": item._parentKey,
  };
  static ParamKey $create(
    String key, {
    String parentKey,
  }) {
    assert (key != null);
    return new ParamKey()
      .._key = key
      .._parentKey = parentKey;
  }
  static ParamKey $createObservable({
    String key = "",
    String parentKey = "",
  }) {
    return new _ParamKey()
      .._key = key
      .._parentKey = parentKey;
  }

  static const int FN_KEY = 1;
  static const int FN_PARENT_KEY = 2;

  String _key;
  String _parentKey;

  /// required: 1
  String get key => _key;
  void set key(String key) { _key = key; }

  /// optional: 2
  String get parentKey => _parentKey;
  void set parentKey(String parentKey) { _parentKey = parentKey; }
}
class _ParamKey extends ParamKey with PubSub {
  String get key { $sub(1); return _key; }
  void set key(String key) { if (key != null && key == _key) return; _key = key ?? ""; $pub(1); }

  String get parentKey { $sub(2); return _parentKey; }
  void set parentKey(String parentKey) { if (parentKey != null && parentKey == _parentKey) return; _parentKey = parentKey ?? ""; $pub(2); }
}




/// message ParamUpdate {
///   required bytes key = 1;
///   required MultiCAS mc = 2;
///   optional uint32 id = 3;
/// }
class ParamUpdate {
  static ParamUpdate fromMap(Map<String,dynamic> map, [ ParamUpdate item ]) {
    if (map == null) return item;

    item ??= new ParamUpdate();
    item._key = map["1"];
    item._mc = MultiCAS.fromMap(map["2"] as Map<String,dynamic>, item._mc);
    item._id = map["3"];
    return item;
  }
  static ParamUpdate $(dynamic data) {
      if (data is Map)
        return fromMap(data as Map<String,dynamic>);

      throw data;
  }
  static Map<String,dynamic> toMap(ParamUpdate item) => {
    "1": item._key,
    "2": item._mc == null ? null : MultiCAS.toMap(item._mc),
    "3": item._id,
  };
  static ParamUpdate $create(
    String key, MultiCAS mc, {
    int id,
  }) {
    assert (key != null);
    assert (mc != null);
    return new ParamUpdate()
      .._key = key
      .._mc = mc
      .._id = id;
  }
  static ParamUpdate $createObservable({
    String key = "",
    MultiCAS mc,
    int id = 0,
  }) {
    return new _ParamUpdate()
      .._key = key
      .._mc = mc ?? MultiCAS.$createObservable()
      .._id = id;
  }

  static const int FN_KEY = 1;
  static const int FN_MC = 2;
  static const int FN_ID = 3;

  String _key;
  MultiCAS _mc;
  int _id;

  /// required: 1
  String get key => _key;
  void set key(String key) { _key = key; }

  /// required: 2
  MultiCAS get mc => _mc;
  void set mc(MultiCAS mc) { _mc = mc; }

  /// optional: 3
  int get id => _id;
  void set id(int id) { _id = id; }
}
class _ParamUpdate extends ParamUpdate with PubSub {
  String get key { $sub(1); return _key; }
  void set key(String key) { if (key != null && key == _key) return; _key = key ?? ""; $pub(1); }

  MultiCAS get mc { $sub(2); return _mc; }
  void set mc(MultiCAS mc) { if (mc != null && mc == _mc) return; _mc = mc; $pub(2); }

  int get id { $sub(3); return _id; }
  void set id(int id) { if (id != null && id == _id) return; _id = id ?? 0; $pub(3); }
}




/// message ParamRangeKey {
///   required bool desc = 1;
///   optional uint32 limit = 2;
///   optional bytes start_key = 3;
///   optional bytes parent_key = 4;
/// }
class ParamRangeKey {
  static ParamRangeKey fromMap(Map<String,dynamic> map, [ ParamRangeKey item ]) {
    if (map == null) return item;

    item ??= new ParamRangeKey();
    item._desc = map["1"];
    item._limit = map["2"];
    item._startKey = map["3"];
    item._parentKey = map["4"];
    return item;
  }
  static ParamRangeKey $(dynamic data) {
      if (data is Map)
        return fromMap(data as Map<String,dynamic>);

      throw data;
  }
  static Map<String,dynamic> toMap(ParamRangeKey item) => {
    "1": item._desc,
    "2": item._limit,
    "3": item._startKey,
    "4": item._parentKey,
  };
  static ParamRangeKey $create(
    bool desc, {
    int limit,
    String startKey,
    String parentKey,
  }) {
    assert (desc != null);
    return new ParamRangeKey()
      .._desc = desc
      .._limit = limit
      .._startKey = startKey
      .._parentKey = parentKey;
  }
  static ParamRangeKey $createObservable({
    bool desc = false,
    int limit = 10,
    String startKey = "",
    String parentKey = "",
  }) {
    return new _ParamRangeKey()
      .._desc = desc
      .._limit = limit
      .._startKey = startKey
      .._parentKey = parentKey;
  }

  static const int FN_DESC = 1;
  static const int FN_LIMIT = 2;
  static const int FN_START_KEY = 3;
  static const int FN_PARENT_KEY = 4;

  bool _desc;
  int _limit;
  String _startKey;
  String _parentKey;

  /// required: 1
  bool get desc => _desc;
  void set desc(bool desc) { _desc = desc; }

  /// optional: 2
  int get limit => _limit;
  void set limit(int limit) { _limit = limit; }

  /// optional: 3
  String get startKey => _startKey;
  void set startKey(String startKey) { _startKey = startKey; }

  /// optional: 4
  String get parentKey => _parentKey;
  void set parentKey(String parentKey) { _parentKey = parentKey; }
}
class _ParamRangeKey extends ParamRangeKey with PubSub {
  bool get desc { $sub(1); return _desc; }
  void set desc(bool desc) { if (desc != null && desc == _desc) return; _desc = desc ?? false; $pub(1); }

  int get limit { $sub(2); return _limit; }
  void set limit(int limit) { if (limit != null && limit == _limit) return; _limit = limit ?? 10; $pub(2); }

  String get startKey { $sub(3); return _startKey; }
  void set startKey(String startKey) { if (startKey != null && startKey == _startKey) return; _startKey = startKey ?? ""; $pub(3); }

  String get parentKey { $sub(4); return _parentKey; }
  void set parentKey(String parentKey) { if (parentKey != null && parentKey == _parentKey) return; _parentKey = parentKey ?? ""; $pub(4); }
}




/// message ACResult {
///   required string name = 1;
///   required bytes value = 2;
///   optional uint32 id = 3;
/// }
class ACResult {
  static ACResult fromMap(Map<String,dynamic> map, [ ACResult item ]) {
    if (map == null) return item;

    item ??= new ACResult();
    item._name = map["1"];
    item._value = map["2"];
    item._id = map["3"];
    return item;
  }
  static ACResult $(dynamic data) {
      if (data is Map)
        return fromMap(data as Map<String,dynamic>);

      throw data;
  }
  static Map<String,dynamic> toMap(ACResult item) => {
    "1": item._name,
    "2": item._value,
    "3": item._id,
  };
  static ACResult $create(
    String name, String value, {
    int id,
  }) {
    assert (name != null);
    assert (value != null);
    return new ACResult()
      .._name = name
      .._value = value
      .._id = id;
  }
  static ACResult $createObservable({
    String name = "",
    String value = "",
    int id = 0,
  }) {
    return new _ACResult()
      .._name = name
      .._value = value
      .._id = id;
  }

  static const int FN_NAME = 1;
  static const int FN_VALUE = 2;
  static const int FN_ID = 3;

  String _name;
  String _value;
  int _id;

  /// required: 1
  String get name => _name;
  void set name(String name) { _name = name; }

  /// required: 2
  String get value => _value;
  void set value(String value) { _value = value; }

  /// optional: 3
  int get id => _id;
  void set id(int id) { _id = id; }
}
class _ACResult extends ACResult with PubSub {
  String get name { $sub(1); return _name; }
  void set name(String name) { if (name != null && name == _name) return; _name = name ?? ""; $pub(1); }

  String get value { $sub(2); return _value; }
  void set value(String value) { if (value != null && value == _value) return; _value = value ?? ""; $pub(2); }

  int get id { $sub(3); return _id; }
  void set id(int id) { if (id != null && id == _id) return; _id = id ?? 0; $pub(3); }
}

/// message ACResult_PList {
///   repeated ACResult p = 1;
/// }
class ACResult_PList {
  static ACResult_PList fromMap(Map<String,dynamic> map, [ ACResult_PList item ]) {
    if (map == null) return item;

    item ??= new ACResult_PList();
    item._p = (map["1"] as List<Map<String,dynamic>>)?.map(ACResult.fromMap).toList(growable: false);
    return item;
  }
  static ACResult_PList $(dynamic data) {
      if (data is Map)
        return fromMap(data as Map<String,dynamic>);

      throw data;
  }
  static Map<String,dynamic> toMap(ACResult_PList item) => {
    "1": item._p?.map(ACResult.toMap).toList(growable: false),
  };
  static ACResult_PList $create({
    List<ACResult> p,
  }) {
    return new ACResult_PList()
      .._p = p;
  }
  static const int FN_P = 1;

  List<ACResult> _p;

  /// repeated: 1
  List<ACResult> get p => _p;
  void set p(List<ACResult> p) { _p = p; }
}




/// message P1 {
///   required int8 value = 1;
///   optional int8 end = 2;
///   optional int8 pgstart = 3;
///   required ParamRangeKey prk = 4;
/// }
class P1 {
  static P1 fromMap(Map<String,dynamic> map, [ P1 item ]) {
    if (map == null) return item;

    item ??= new P1();
    item._value = map["1"];
    item._end = map["2"];
    item._pgstart = map["3"];
    item._prk = ParamRangeKey.fromMap(map["4"] as Map<String,dynamic>, item._prk);
    return item;
  }
  static P1 $(dynamic data) {
      if (data is Map)
        return fromMap(data as Map<String,dynamic>);

      throw data;
  }
  static Map<String,dynamic> toMap(P1 item) => {
    "1": item._value,
    "2": item._end,
    "3": item._pgstart,
    "4": item._prk == null ? null : ParamRangeKey.toMap(item._prk),
  };
  static P1 $create(
    int value, ParamRangeKey prk, {
    int end,
    int pgstart,
  }) {
    assert (value != null);
    assert (prk != null);
    return new P1()
      .._value = value
      .._end = end
      .._pgstart = pgstart
      .._prk = prk;
  }
  static P1 $createObservable({
    int value = 0,
    int end = -1,
    int pgstart = -1,
    ParamRangeKey prk,
  }) {
    return new _P1()
      .._value = value
      .._end = end
      .._pgstart = pgstart
      .._prk = prk ?? ParamRangeKey.$createObservable();
  }

  static const int FN_VALUE = 1;
  static const int FN_END = 2;
  static const int FN_PGSTART = 3;
  static const int FN_PRK = 4;

  int _value;
  int _end;
  int _pgstart;
  ParamRangeKey _prk;

  /// required: 1
  int get value => _value;
  void set value(int value) { _value = value; }

  /// optional: 2
  int get end => _end;
  void set end(int end) { _end = end; }

  /// optional: 3
  int get pgstart => _pgstart;
  void set pgstart(int pgstart) { _pgstart = pgstart; }

  /// required: 4
  ParamRangeKey get prk => _prk;
  void set prk(ParamRangeKey prk) { _prk = prk; }
}
class _P1 extends P1 with PubSub {
  int get value { $sub(1); return _value; }
  void set value(int value) { if (value != null && value == _value) return; _value = value ?? 0; $pub(1); }

  int get end { $sub(2); return _end; }
  void set end(int end) { if (end != null && end == _end) return; _end = end ?? -1; $pub(2); }

  int get pgstart { $sub(3); return _pgstart; }
  void set pgstart(int pgstart) { if (pgstart != null && pgstart == _pgstart) return; _pgstart = pgstart ?? -1; $pub(3); }

  ParamRangeKey get prk { $sub(4); return _prk; }
  void set prk(ParamRangeKey prk) { if (prk != null && prk == _prk) return; _prk = prk; $pub(4); }
}




/// message P4 {
///   required uint32 value = 1;
///   optional uint32 end = 2;
///   optional uint32 pgstart = 3;
///   required ParamRangeKey prk = 4;
/// }
class P4 {
  static P4 fromMap(Map<String,dynamic> map, [ P4 item ]) {
    if (map == null) return item;

    item ??= new P4();
    item._value = map["1"];
    item._end = map["2"];
    item._pgstart = map["3"];
    item._prk = ParamRangeKey.fromMap(map["4"] as Map<String,dynamic>, item._prk);
    return item;
  }
  static P4 $(dynamic data) {
      if (data is Map)
        return fromMap(data as Map<String,dynamic>);

      throw data;
  }
  static Map<String,dynamic> toMap(P4 item) => {
    "1": item._value,
    "2": item._end,
    "3": item._pgstart,
    "4": item._prk == null ? null : ParamRangeKey.toMap(item._prk),
  };
  static P4 $create(
    int value, ParamRangeKey prk, {
    int end,
    int pgstart,
  }) {
    assert (value != null);
    assert (prk != null);
    return new P4()
      .._value = value
      .._end = end
      .._pgstart = pgstart
      .._prk = prk;
  }
  static P4 $createObservable({
    int value = 0,
    int end = -1,
    int pgstart = -1,
    ParamRangeKey prk,
  }) {
    return new _P4()
      .._value = value
      .._end = end
      .._pgstart = pgstart
      .._prk = prk ?? ParamRangeKey.$createObservable();
  }

  static const int FN_VALUE = 1;
  static const int FN_END = 2;
  static const int FN_PGSTART = 3;
  static const int FN_PRK = 4;

  int _value;
  int _end;
  int _pgstart;
  ParamRangeKey _prk;

  /// required: 1
  int get value => _value;
  void set value(int value) { _value = value; }

  /// optional: 2
  int get end => _end;
  void set end(int end) { _end = end; }

  /// optional: 3
  int get pgstart => _pgstart;
  void set pgstart(int pgstart) { _pgstart = pgstart; }

  /// required: 4
  ParamRangeKey get prk => _prk;
  void set prk(ParamRangeKey prk) { _prk = prk; }
}
class _P4 extends P4 with PubSub {
  int get value { $sub(1); return _value; }
  void set value(int value) { if (value != null && value == _value) return; _value = value ?? 0; $pub(1); }

  int get end { $sub(2); return _end; }
  void set end(int end) { if (end != null && end == _end) return; _end = end ?? -1; $pub(2); }

  int get pgstart { $sub(3); return _pgstart; }
  void set pgstart(int pgstart) { if (pgstart != null && pgstart == _pgstart) return; _pgstart = pgstart ?? -1; $pub(3); }

  ParamRangeKey get prk { $sub(4); return _prk; }
  void set prk(ParamRangeKey prk) { if (prk != null && prk == _prk) return; _prk = prk; $pub(4); }
}




/// message P8 {
///   required uint64 value = 1;
///   optional uint64 end = 2;
///   optional uint64 pgstart = 3;
///   required ParamRangeKey prk = 4;
/// }
class P8 {
  static P8 fromMap(Map<String,dynamic> map, [ P8 item ]) {
    if (map == null) return item;

    item ??= new P8();
    item._value = map["1"];
    item._end = map["2"];
    item._pgstart = map["3"];
    item._prk = ParamRangeKey.fromMap(map["4"] as Map<String,dynamic>, item._prk);
    return item;
  }
  static P8 $(dynamic data) {
      if (data is Map)
        return fromMap(data as Map<String,dynamic>);

      throw data;
  }
  static Map<String,dynamic> toMap(P8 item) => {
    "1": item._value,
    "2": item._end,
    "3": item._pgstart,
    "4": item._prk == null ? null : ParamRangeKey.toMap(item._prk),
  };
  static P8 $create(
    int value, ParamRangeKey prk, {
    int end,
    int pgstart,
  }) {
    assert (value != null);
    assert (prk != null);
    return new P8()
      .._value = value
      .._end = end
      .._pgstart = pgstart
      .._prk = prk;
  }
  static P8 $createObservable({
    int value = 0,
    int end = -1,
    int pgstart = -1,
    ParamRangeKey prk,
  }) {
    return new _P8()
      .._value = value
      .._end = end
      .._pgstart = pgstart
      .._prk = prk ?? ParamRangeKey.$createObservable();
  }

  static const int FN_VALUE = 1;
  static const int FN_END = 2;
  static const int FN_PGSTART = 3;
  static const int FN_PRK = 4;

  int _value;
  int _end;
  int _pgstart;
  ParamRangeKey _prk;

  /// required: 1
  int get value => _value;
  void set value(int value) { _value = value; }

  /// optional: 2
  int get end => _end;
  void set end(int end) { _end = end; }

  /// optional: 3
  int get pgstart => _pgstart;
  void set pgstart(int pgstart) { _pgstart = pgstart; }

  /// required: 4
  ParamRangeKey get prk => _prk;
  void set prk(ParamRangeKey prk) { _prk = prk; }
}
class _P8 extends P8 with PubSub {
  int get value { $sub(1); return _value; }
  void set value(int value) { if (value != null && value == _value) return; _value = value ?? 0; $pub(1); }

  int get end { $sub(2); return _end; }
  void set end(int end) { if (end != null && end == _end) return; _end = end ?? -1; $pub(2); }

  int get pgstart { $sub(3); return _pgstart; }
  void set pgstart(int pgstart) { if (pgstart != null && pgstart == _pgstart) return; _pgstart = pgstart ?? -1; $pub(3); }

  ParamRangeKey get prk { $sub(4); return _prk; }
  void set prk(ParamRangeKey prk) { if (prk != null && prk == _prk) return; _prk = prk; $pub(4); }
}




/// message PD {
///   required uint64 value = 1;
///   optional uint64 end = 2;
///   optional uint64 pgstart = 3;
///   required ParamRangeKey prk = 4;
/// }
class PD {
  static PD fromMap(Map<String,dynamic> map, [ PD item ]) {
    if (map == null) return item;

    item ??= new PD();
    item._value = map["1"];
    item._end = map["2"];
    item._pgstart = map["3"];
    item._prk = ParamRangeKey.fromMap(map["4"] as Map<String,dynamic>, item._prk);
    return item;
  }
  static PD $(dynamic data) {
      if (data is Map)
        return fromMap(data as Map<String,dynamic>);

      throw data;
  }
  static Map<String,dynamic> toMap(PD item) => {
    "1": item._value,
    "2": item._end,
    "3": item._pgstart,
    "4": item._prk == null ? null : ParamRangeKey.toMap(item._prk),
  };
  static PD $create(
    int value, ParamRangeKey prk, {
    int end,
    int pgstart,
  }) {
    assert (value != null);
    assert (prk != null);
    return new PD()
      .._value = value
      .._end = end
      .._pgstart = pgstart
      .._prk = prk;
  }
  static PD $createObservable({
    int value = 0,
    int end = 0,
    int pgstart = 0,
    ParamRangeKey prk,
  }) {
    return new _PD()
      .._value = value
      .._end = end
      .._pgstart = pgstart
      .._prk = prk ?? ParamRangeKey.$createObservable();
  }

  static const int FN_VALUE = 1;
  static const int FN_END = 2;
  static const int FN_PGSTART = 3;
  static const int FN_PRK = 4;

  int _value;
  int _end;
  int _pgstart;
  ParamRangeKey _prk;

  /// required: 1
  int get value => _value;
  void set value(int value) { _value = value; }

  /// optional: 2
  int get end => _end;
  void set end(int end) { _end = end; }

  /// optional: 3
  int get pgstart => _pgstart;
  void set pgstart(int pgstart) { _pgstart = pgstart; }

  /// required: 4
  ParamRangeKey get prk => _prk;
  void set prk(ParamRangeKey prk) { _prk = prk; }
}
class _PD extends PD with PubSub {
  int get value { $sub(1); return _value; }
  void set value(int value) { if (value != null && value == _value) return; _value = value ?? 0; $pub(1); }

  int get end { $sub(2); return _end; }
  void set end(int end) { if (end != null && end == _end) return; _end = end ?? 0; $pub(2); }

  int get pgstart { $sub(3); return _pgstart; }
  void set pgstart(int pgstart) { if (pgstart != null && pgstart == _pgstart) return; _pgstart = pgstart ?? 0; $pub(3); }

  ParamRangeKey get prk { $sub(4); return _prk; }
  void set prk(ParamRangeKey prk) { if (prk != null && prk == _prk) return; _prk = prk; $pub(4); }
}




/// message PB {
///   required bytes value = 1;
///   optional bytes end = 2;
///   optional bytes pgstart = 3;
///   required ParamRangeKey prk = 4;
/// }
class PB {
  static PB fromMap(Map<String,dynamic> map, [ PB item ]) {
    if (map == null) return item;

    item ??= new PB();
    item._value = map["1"];
    item._end = map["2"];
    item._pgstart = map["3"];
    item._prk = ParamRangeKey.fromMap(map["4"] as Map<String,dynamic>, item._prk);
    return item;
  }
  static PB $(dynamic data) {
      if (data is Map)
        return fromMap(data as Map<String,dynamic>);

      throw data;
  }
  static Map<String,dynamic> toMap(PB item) => {
    "1": item._value,
    "2": item._end,
    "3": item._pgstart,
    "4": item._prk == null ? null : ParamRangeKey.toMap(item._prk),
  };
  static PB $create(
    String value, ParamRangeKey prk, {
    String end,
    String pgstart,
  }) {
    assert (value != null);
    assert (prk != null);
    return new PB()
      .._value = value
      .._end = end
      .._pgstart = pgstart
      .._prk = prk;
  }
  static PB $createObservable({
    String value = "",
    String end = "",
    String pgstart = "",
    ParamRangeKey prk,
  }) {
    return new _PB()
      .._value = value
      .._end = end
      .._pgstart = pgstart
      .._prk = prk ?? ParamRangeKey.$createObservable();
  }

  static const int FN_VALUE = 1;
  static const int FN_END = 2;
  static const int FN_PGSTART = 3;
  static const int FN_PRK = 4;

  String _value;
  String _end;
  String _pgstart;
  ParamRangeKey _prk;

  /// required: 1
  String get value => _value;
  void set value(String value) { _value = value; }

  /// optional: 2
  String get end => _end;
  void set end(String end) { _end = end; }

  /// optional: 3
  String get pgstart => _pgstart;
  void set pgstart(String pgstart) { _pgstart = pgstart; }

  /// required: 4
  ParamRangeKey get prk => _prk;
  void set prk(ParamRangeKey prk) { _prk = prk; }
}
class _PB extends PB with PubSub {
  String get value { $sub(1); return _value; }
  void set value(String value) { if (value != null && value == _value) return; _value = value ?? ""; $pub(1); }

  String get end { $sub(2); return _end; }
  void set end(String end) { if (end != null && end == _end) return; _end = end ?? ""; $pub(2); }

  String get pgstart { $sub(3); return _pgstart; }
  void set pgstart(String pgstart) { if (pgstart != null && pgstart == _pgstart) return; _pgstart = pgstart ?? ""; $pub(3); }

  ParamRangeKey get prk { $sub(4); return _prk; }
  void set prk(ParamRangeKey prk) { if (prk != null && prk == _prk) return; _prk = prk; $pub(4); }
}




/// message PK {
///   required bytes value = 1;
///   optional bytes end = 2;
///   optional bytes pgstart = 3;
///   required ParamRangeKey prk = 4;
/// }
class PK {
  static PK fromMap(Map<String,dynamic> map, [ PK item ]) {
    if (map == null) return item;

    item ??= new PK();
    item._value = map["1"];
    item._end = map["2"];
    item._pgstart = map["3"];
    item._prk = ParamRangeKey.fromMap(map["4"] as Map<String,dynamic>, item._prk);
    return item;
  }
  static PK $(dynamic data) {
      if (data is Map)
        return fromMap(data as Map<String,dynamic>);

      throw data;
  }
  static Map<String,dynamic> toMap(PK item) => {
    "1": item._value,
    "2": item._end,
    "3": item._pgstart,
    "4": item._prk == null ? null : ParamRangeKey.toMap(item._prk),
  };
  static PK $create(
    String value, ParamRangeKey prk, {
    String end,
    String pgstart,
  }) {
    assert (value != null);
    assert (prk != null);
    return new PK()
      .._value = value
      .._end = end
      .._pgstart = pgstart
      .._prk = prk;
  }
  static PK $createObservable({
    String value = "",
    String end = "",
    String pgstart = "",
    ParamRangeKey prk,
  }) {
    return new _PK()
      .._value = value
      .._end = end
      .._pgstart = pgstart
      .._prk = prk ?? ParamRangeKey.$createObservable();
  }

  static const int FN_VALUE = 1;
  static const int FN_END = 2;
  static const int FN_PGSTART = 3;
  static const int FN_PRK = 4;

  String _value;
  String _end;
  String _pgstart;
  ParamRangeKey _prk;

  /// required: 1
  String get value => _value;
  void set value(String value) { _value = value; }

  /// optional: 2
  String get end => _end;
  void set end(String end) { _end = end; }

  /// optional: 3
  String get pgstart => _pgstart;
  void set pgstart(String pgstart) { _pgstart = pgstart; }

  /// required: 4
  ParamRangeKey get prk => _prk;
  void set prk(ParamRangeKey prk) { _prk = prk; }
}
class _PK extends PK with PubSub {
  String get value { $sub(1); return _value; }
  void set value(String value) { if (value != null && value == _value) return; _value = value ?? ""; $pub(1); }

  String get end { $sub(2); return _end; }
  void set end(String end) { if (end != null && end == _end) return; _end = end ?? ""; $pub(2); }

  String get pgstart { $sub(3); return _pgstart; }
  void set pgstart(String pgstart) { if (pgstart != null && pgstart == _pgstart) return; _pgstart = pgstart ?? ""; $pub(3); }

  ParamRangeKey get prk { $sub(4); return _prk; }
  void set prk(ParamRangeKey prk) { if (prk != null && prk == _prk) return; _prk = prk; $pub(4); }
}




/// message PS {
///   required string value = 1;
///   optional string end = 2;
///   optional string pgstart = 3;
///   required ParamRangeKey prk = 4;
/// }
class PS {
  static PS fromMap(Map<String,dynamic> map, [ PS item ]) {
    if (map == null) return item;

    item ??= new PS();
    item._value = map["1"];
    item._end = map["2"];
    item._pgstart = map["3"];
    item._prk = ParamRangeKey.fromMap(map["4"] as Map<String,dynamic>, item._prk);
    return item;
  }
  static PS $(dynamic data) {
      if (data is Map)
        return fromMap(data as Map<String,dynamic>);

      throw data;
  }
  static Map<String,dynamic> toMap(PS item) => {
    "1": item._value,
    "2": item._end,
    "3": item._pgstart,
    "4": item._prk == null ? null : ParamRangeKey.toMap(item._prk),
  };
  static PS $create(
    String value, ParamRangeKey prk, {
    String end,
    String pgstart,
  }) {
    assert (value != null);
    assert (prk != null);
    return new PS()
      .._value = value
      .._end = end
      .._pgstart = pgstart
      .._prk = prk;
  }
  static PS $createObservable({
    String value = "",
    String end = "",
    String pgstart = "",
    ParamRangeKey prk,
  }) {
    return new _PS()
      .._value = value
      .._end = end
      .._pgstart = pgstart
      .._prk = prk ?? ParamRangeKey.$createObservable();
  }

  static const int FN_VALUE = 1;
  static const int FN_END = 2;
  static const int FN_PGSTART = 3;
  static const int FN_PRK = 4;

  String _value;
  String _end;
  String _pgstart;
  ParamRangeKey _prk;

  /// required: 1
  String get value => _value;
  void set value(String value) { _value = value; }

  /// optional: 2
  String get end => _end;
  void set end(String end) { _end = end; }

  /// optional: 3
  String get pgstart => _pgstart;
  void set pgstart(String pgstart) { _pgstart = pgstart; }

  /// required: 4
  ParamRangeKey get prk => _prk;
  void set prk(ParamRangeKey prk) { _prk = prk; }
}
class _PS extends PS with PubSub {
  String get value { $sub(1); return _value; }
  void set value(String value) { if (value != null && value == _value) return; _value = value ?? ""; $pub(1); }

  String get end { $sub(2); return _end; }
  void set end(String end) { if (end != null && end == _end) return; _end = end ?? ""; $pub(2); }

  String get pgstart { $sub(3); return _pgstart; }
  void set pgstart(String pgstart) { if (pgstart != null && pgstart == _pgstart) return; _pgstart = pgstart ?? ""; $pub(3); }

  ParamRangeKey get prk { $sub(4); return _prk; }
  void set prk(ParamRangeKey prk) { if (prk != null && prk == _prk) return; _prk = prk; $pub(4); }
}





