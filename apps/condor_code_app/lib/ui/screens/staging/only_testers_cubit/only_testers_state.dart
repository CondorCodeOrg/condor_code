import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'only_testers_state.freezed.dart';

@freezed
abstract class OnlyTestersState with _$OnlyTestersState {
  const factory OnlyTestersState({
    @Default(false) bool isLoading,
    @Default(false) bool isSubmitting,
    TesterAccessRequest? myRequest,
  }) = _OnlyTestersState;

  const OnlyTestersState._();

  bool get hasPendingRequest =>
      myRequest?.status == TesterAccessRequestStatus.pending;
}
