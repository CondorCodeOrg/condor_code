import 'package:domain/models/tester_access_request.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tester_requests_state.freezed.dart';

@freezed
sealed class TesterRequestsState with _$TesterRequestsState {
  const factory TesterRequestsState({
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    @Default(<TesterAccessRequest>[]) List<TesterAccessRequest> requests,
    String? errorMessage,
  }) = _TesterRequestsState;
}
