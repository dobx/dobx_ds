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

library dobx_ds.observables;

import 'package:dobx/dobx.dart';
import 'package:dobx_gen/core.dart';

part 'observables.g.dart';

@dobx
abstract class StoreState {

  bool loading;

  static const int DESC = 5;
  void $pub(int id);
  void $sub(int id);

  factory StoreState() => _$StoreState();
}