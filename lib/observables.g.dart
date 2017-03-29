// GENERATED CODE - DO NOT MODIFY BY HAND

part of dobx_ds.observables;

// **************************************************************************
// Generator: DobxGenerator
// Target: abstract class StoreState
// **************************************************************************

class _StoreState extends PubSub implements StoreState {
  bool _loading;
  bool get loading {
    $sub(1);
    return _loading;
  }

  void set loading(bool loading) {
    if (loading != null && loading == _loading) return;
    _loading = loading ?? false;
    $pub(1);
  }
}

StoreState _$StoreState({
  bool loading: false,
}) {
  return new _StoreState().._loading = loading;
}
