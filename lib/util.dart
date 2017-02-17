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

import 'dart:convert' show BASE64;

List<T> $map<T,E>(List<E> list, T f(E e)) {
  return list == null ? null : list.map(f).toList(growable: false);
}

// same api signature as vueds

String extractMsg(dynamic data) {
  return data is List ? data[1]['1'] : '$data';
}

int bit_unset(int state, int value) {
  return state & (~value & 2147483647);
}

int bit_clear_and_set(int state, int clear, int set) {
  return set | (state & (~clear & 2147483647));
}

int to_flag(int field) {
  return 1 << (field - 1);
}

int to_int32(List<int> bytes, int i) {
  return ((bytes[i]&0xFF) << 24) |
      ((bytes[i+1]&0xFF) << 16) |
      ((bytes[i+2]&0xFF) << 8) |
      (bytes[i+3]&0xFF);
}

int to_int32LE(List<int> bytes, int i) {
  return ((bytes[i + 3] & 0xFF) << 24) |
      ((bytes[i + 2] & 0xFF) << 16) |
      ((bytes[i + 1] & 0xFF) << 8) |
      (bytes[i] & 0xFF);
}

String bytesToBase64(List<int> bytes) => BASE64.encode(bytes);
List<int> base64ToBytes(String base64) => BASE64.decode(base64);

const String ZERO_KEY = 'AAAAAAAAAAAA';

final RegExp
    regexKey = new RegExp(r'^[A-Za-z0-9+/]+$'),
    regexInt = new RegExp(r'^-?[0-9]+$'),
    regexDouble = new RegExp(r'^-?[0-9]+(\.[0-9]+)?$'),
    regexTime = new RegExp(r'^[0-2]?[0-9]\:[0-5][0-9](\:[0-5][0-9])?$'),
    regexDate = new RegExp(r'^[1-9][0-9][0-9][0-9]\/[0-9][0-9]\/[0-9][0-9]$'),
    regexDateTime = new RegExp(r'^[1-9][0-9][0-9][0-9]\/[0-9][0-9]\/[0-9][0-9] [0-2]?[0-9]\:[0-5][0-9]\:[0-5][0-9]$');

String getDateUTCOffset(DateTime date) {
  int n = (date.timeZoneOffset.inMinutes * -10 / 6).floor();
  String r;
  if (n < 0) {
    r = (n - 10000).toString();
    return r[0] + r.substring(2);
  } else {
    r = (n + 10000).toString();
    return '+' + r.substring(1);
  }
}

int _getUTCOffset() {
  DateTime now = new DateTime.now(),
      date = new DateTime(now.year, now.month, now.day);

  String offset = getDateUTCOffset(date);
  if (offset.indexOf('+') == 0) {
    return int.parse(offset.substring(1, offset.length - 2), radix: 10);
  } else if (offset.indexOf('-') == 0) {
    return -int.parse(offset.substring(1, offset.length - 2), radix: 10);
  } else {
    return -int.parse(offset.substring(10, offset.length - 2), radix: 10);
  }
}

const int
    MILLIS_PER_DAY = 1000 * 60 * 60 * 24,
    MAX_TIME_IN_MILLIS_PER_DAY = (1000 * 60 * 60 * 24) - 1,
    MILLIS_PER_HOUR = 1000 * 60 * 60,
    SECONDS_PER_HOUR = 60 * 60,
    // 23:59:59
    MAX_TIME = (23 * SECONDS_PER_HOUR) + (59 * 60) + 59;

final int
    UTC_OFFSET = _getUTCOffset(),
    HOST_RAW_OFFSET = UTC_OFFSET * 60 * 60 * 1000,
    HOST_RAW_OFFSET_SECONDS = UTC_OFFSET * 60 * 60;

int localToUtc(int ts) {
  return ts + HOST_RAW_OFFSET;
}

int localToUtcSeconds(int s) {
  return s + HOST_RAW_OFFSET_SECONDS;
}

int utcToLocal(int ts) {
  return ts - HOST_RAW_OFFSET;
}

int utcToLocalSeconds(int s) {
  return s - HOST_RAW_OFFSET_SECONDS;
}

int extractTime(int ts, int date) {
  return ((localToUtc(ts) - date) / 1000).floor();
}

int now() {
  return new DateTime.now().millisecondsSinceEpoch;
}

bool isExpired(int value, int duration) {
  return now() > (value + duration);
}

bool isExpired24Hrs(int value) {
  return isExpired(value, MILLIS_PER_DAY);
}

int startOfDayMS(int ts) {
  ts += HOST_RAW_OFFSET;
  return ts - (ts % MILLIS_PER_DAY);
}

bool isSameDay(int ts1, int ts2) {
  return startOfDayMS(ts1) == startOfDayMS(ts2);
}

int addDaysTo(int ts, int days) {
  return ts + (MILLIS_PER_DAY * days);
}

int startOfTodayMS() {
  return startOfDayMS(now());
}

int utcNow() {
  return now() + HOST_RAW_OFFSET;
}

// =====================================

int getKind(String key) {
  var bytes = base64ToBytes(key);
  return bytes[bytes.length - 9] & 0xFF;
}

bool isZeroKey(String key) {
  return ZERO_KEY == key;
}

bool isKey(String key, [ int kind ]) {
  return regexKey.hasMatch(key) && (kind == null || kind == getKind(key));
}

int bytesTo6ByteTS(List<int> bytes, int o) {
  var left = (((bytes[o++] & 0xFF) << 24) | ((bytes[o++] & 0xFF) << 16)),
      right = (((bytes[o++] & 0xFF) << 24) | ((bytes[o++] & 0xFF) << 16) | ((bytes[o++] & 0xFF) << 8) | (bytes[o] & 0xFF));

  left = (left & 0xFFFFFFFF) >> 0;
  right = (right & 0xFFFFFFFF) >> 0;
  //left = left >> 0;
  //right = right >> 0;

  // 24 is the max left shift, hence this slow operation.
  for (var i = 0; i < 16; i++)
    left = left * 2;

  return left + right;
}

int getTs(String key) {
  var bytes = base64ToBytes(key);
  switch(bytes.length) {
    case 9: return bytesTo6ByteTS(bytes, 1);
    case 18: return bytesTo6ByteTS(bytes, 10);
    default: return 0;
  }
}

String incrementKey(String key) {
  var decoded = base64ToBytes(key);
  decoded[decoded.length-1] |= 0x02;
  return bytesToBase64(decoded);
}

String decrementKey(String key) {
  var decoded = base64ToBytes(key);
  decoded[decoded.length-1] &= 0xFE;
  return bytesToBase64(decoded);
}

// from gwt JsonUtils
final List<String> _out = _init(<String>[
  "\\u0000", "\\u0001", "\\u0002", "\\u0003", "\\u0004", "\\u0005",
  "\\u0006", "\\u0007", "\\b", "\\t", "\\n", "\\u000B",
  "\\f", "\\r", "\\u000E", "\\u000F", "\\u0010", "\\u0011",
  "\\u0012", "\\u0013", "\\u0014", "\\u0015", "\\u0016", "\\u0017",
  "\\u0018", "\\u0019", "\\u001A", "\\u001B", "\\u001C", "\\u001D",
  "\\u001E", "\\u001F"
]);

List<String> _init(List<String> out) {
  out[34] = '\\"';
  out[92] = '\\\\';
  out[0xad] = '\\u00ad'; // Soft hyphen
  out[0x600] = '\\u0600'; // Arabic number sign
  out[0x601] = '\\u0601'; // Arabic sign sanah
  out[0x602] = '\\u0602'; // Arabic footnote marker
  out[0x603] = '\\u0603'; // Arabic sign safha
  out[0x6dd] = '\\u06dd'; // Arabic and of ayah
  out[0x70f] = '\\u070f'; // Syriac abbreviation mark
  out[0x17b4] = '\\u17b4'; // Khmer vowel inherent aq
  out[0x17b5] = '\\u17b5'; // Khmer vowel inherent aa
  out[0x200b] = '\\u200b'; // Zero width space
  out[0x200c] = '\\u200c'; // Zero width non-joiner
  out[0x200d] = '\\u200d'; // Zero width joiner
  out[0x200e] = '\\u200e'; // Left-to-right mark
  out[0x200f] = '\\u200f'; // Right-to-left mark
  out[0x2028] = '\\u2028'; // Line separator
  out[0x2029] = '\\u2029'; // Paragraph separator
  out[0x202a] = '\\u202a'; // Left-to-right embedding
  out[0x202b] = '\\u202b'; // Right-to-left embedding
  out[0x202c] = '\\u202c'; // Pop directional formatting
  out[0x202d] = '\\u202d'; // Left-to-right override
  out[0x202e] = '\\u202e'; // Right-to-left override
  out[0x2060] = '\\u2060'; // Word joiner
  out[0x2061] = '\\u2061'; // Function application
  out[0x2062] = '\\u2062'; // Invisible times
  out[0x2063] = '\\u2063'; // Invisible separator
  out[0x2064] = '\\u2064'; // Invisible plus
  out[0x206a] = '\\u206a'; // Inhibit symmetric swapping
  out[0x206b] = '\\u206b'; // Activate symmetric swapping
  out[0x206c] = '\\u206c'; // Inherent Arabic form shaping
  out[0x206d] = '\\u206d'; // Activate Arabic form shaping
  out[0x206e] = '\\u206e'; // National digit shapes
  out[0x206f] = '\\u206f'; // Nominal digit shapes
  out[0xfeff] = '\\ufeff'; // Zero width no-break space
  out[0xfff9] = '\\ufff9'; // Intralinear annotation anchor
  out[0xfffa] = '\\ufffa'; // Intralinear annotation separator
  out[0xfffb] = '\\ufffb'; // Intralinear annotation terminator
  return out;
}

final _regexEscape = new RegExp(
    r'[\x00-\x1f\xad\u0600-\u0603\u06dd\u070f\u17b4\u17b5\u200b-\u200f\u2028-\u202e\u2060-\u2064\u206a-\u206f\ufeff\ufff9-\ufffb"\\]');

String _escapeChar(Match m) {
  String c = m.group(0);
  return _out[c.codeUnitAt(0)] ?? c;
}

String $escape(String str) {
  return str.replaceAllMapped(_regexEscape, _escapeChar);
}

/// Returns a double-quoted string for json.
String escapeValue(String v) {
  return '"${$escape(v)}"';
}



