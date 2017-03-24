enum FieldType {
  MESSAGE,
  BOOL,
  BYTES,
  STRING,
  FLOAT,
  DOUBLE,
  UINT32,
  UINT64,
  INT32,
  INT64,
  FIXED32,
  FIXED64,
  SINT32,
  SINT64,
  SFIXED32,
  SFIXED64,
  // equivalent to int32
  //ENUM
}

final List<String> _keys = <String>[
  '${FieldType.MESSAGE.index}',
  '${FieldType.BOOL.index}',
  '${FieldType.BYTES.index}',
  '${FieldType.STRING.index}',
  '${FieldType.FLOAT.index}',
  '${FieldType.DOUBLE.index}',
  '${FieldType.UINT32.index}',
  '${FieldType.UINT64.index}',
  '${FieldType.INT32.index}',
  '${FieldType.INT64.index}',
  '${FieldType.FIXED32.index}',
  '${FieldType.FIXED64.index}',
  '${FieldType.SINT32.index}',
  '${FieldType.SINT64.index}',
  '${FieldType.SFIXED32.index}',
  '${FieldType.SFIXED64.index}',
];

String numericKey(FieldType ft) {
  return _keys[ft.index];
}