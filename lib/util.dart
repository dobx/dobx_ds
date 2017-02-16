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

final List<String> _out = <String>[
  "\\u0000", "\\u0001", "\\u0002", "\\u0003", "\\u0004", "\\u0005",
  "\\u0006", "\\u0007", "\\b", "\\t", "\\n", "\\u000B",
  "\\f", "\\r", "\\u000E", "\\u000F", "\\u0010", "\\u0011",
  "\\u0012", "\\u0013", "\\u0014", "\\u0015", "\\u0016", "\\u0017",
  "\\u0018", "\\u0019", "\\u001A", "\\u001B", "\\u001C", "\\u001D",
  "\\u001E", "\\u001F"
];

void _init() {
  _out[34] = '\\"';
  _out[92] = '\\\\';
  _out[0xad] = '\\u00ad'; // Soft hyphen
  _out[0x600] = '\\u0600'; // Arabic number sign
  _out[0x601] = '\\u0601'; // Arabic sign sanah
  _out[0x602] = '\\u0602'; // Arabic footnote marker
  _out[0x603] = '\\u0603'; // Arabic sign safha
  _out[0x6dd] = '\\u06dd'; // Arabic and of ayah
  _out[0x70f] = '\\u070f'; // Syriac abbreviation mark
  _out[0x17b4] = '\\u17b4'; // Khmer vowel inherent aq
  _out[0x17b5] = '\\u17b5'; // Khmer vowel inherent aa
  _out[0x200b] = '\\u200b'; // Zero width space
  _out[0x200c] = '\\u200c'; // Zero width non-joiner
  _out[0x200d] = '\\u200d'; // Zero width joiner
  _out[0x200e] = '\\u200e'; // Left-to-right mark
  _out[0x200f] = '\\u200f'; // Right-to-left mark
  _out[0x2028] = '\\u2028'; // Line separator
  _out[0x2029] = '\\u2029'; // Paragraph separator
  _out[0x202a] = '\\u202a'; // Left-to-right embedding
  _out[0x202b] = '\\u202b'; // Right-to-left embedding
  _out[0x202c] = '\\u202c'; // Pop directional formatting
  _out[0x202d] = '\\u202d'; // Left-to-right override
  _out[0x202e] = '\\u202e'; // Right-to-left override
  _out[0x2060] = '\\u2060'; // Word joiner
  _out[0x2061] = '\\u2061'; // Function application
  _out[0x2062] = '\\u2062'; // Invisible times
  _out[0x2063] = '\\u2063'; // Invisible separator
  _out[0x2064] = '\\u2064'; // Invisible plus
  _out[0x206a] = '\\u206a'; // Inhibit symmetric swapping
  _out[0x206b] = '\\u206b'; // Activate symmetric swapping
  _out[0x206c] = '\\u206c'; // Inherent Arabic form shaping
  _out[0x206d] = '\\u206d'; // Activate Arabic form shaping
  _out[0x206e] = '\\u206e'; // National digit shapes
  _out[0x206f] = '\\u206f'; // Nominal digit shapes
  _out[0xfeff] = '\\ufeff'; // Zero width no-break space
  _out[0xfff9] = '\\ufff9'; // Intralinear annotation anchor
  _out[0xfffa] = '\\ufffa'; // Intralinear annotation separator
  _out[0xfffb] = '\\ufffb'; // Intralinear annotation terminator
}
final _regexEscape = new RegExp('[\x00-\x1f\xad\u0600-\u0603\u06dd\u070f\u17b4\u17b5\u200b-\u200f\u2028-\u202e\u2060-\u2064\u206a-\u206f\ufeff\ufff9-\ufffb"\\]');

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