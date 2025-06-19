part of 'yachts_cubit.dart';

@freezed
sealed class YachtsState with _$YachtsState {
  const factory YachtsState.loading() = Loading;
  const factory YachtsState.loaded(List<Yacht> yachts) = Loaded;
}
