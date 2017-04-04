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
// @created 2017/02/15

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/src/services/http_client.dart';

final client = createHttpClient();

typedef Future<dynamic> GetTransport(String location);
typedef Future<dynamic> PostTransport(String location, String data);

class RpcError extends Error {
  final String msg;

  RpcError(this.msg);

  String toString() => msg;
}

String getErrMsg(dynamic e) {
  return e is List ? e[1]['1'] : e.toString();
}

dynamic parseResponse(http.Response res) {
  String raw = res.body;
  List<dynamic> data;
  int first = raw.codeUnitAt(0),
      len = raw.length,
      // optional trailing CRLF       '\n'
      end = raw.codeUnitAt(len - 1) == 10 ? len - 2 : len;

  // '+'
  if (first == 43) {
    data = JSON.decode(raw.substring(1, end));
    if (data[0] != 0)
      throw data;

    return data.length == 2 ? data[1] : data;
  }

  // '-'
  if (first != 45)
    throw new RpcError('Malformed response.');

  // '['
  if (raw.codeUnitAt(1) != 91)
    throw new RpcError(raw.substring(1, end));

  throw JSON.decode(raw.substring(1, end));
}

String _prefix = '';
void setPrefix(String prefix) {
  _prefix = prefix;
}

Future<dynamic> _getHTTP(String location) {
  return client.get(_prefix + location).then(parseResponse);
}

Future<dynamic> _postHTTP(String location, String data) {
  return client.post(_prefix + location, body: data).then(parseResponse);
}

GetTransport _gt = _getHTTP;
PostTransport _pt = _postHTTP;

void init(GetTransport gt, PostTransport pt) {
  _gt = gt;
  _pt = pt;
}

Future<dynamic> get(String location) {
  return _gt(location);
}

Future<dynamic> post(String location, String data) {
  return _pt(location, data);
}