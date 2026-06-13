import 'package:data/data_sources/remote/manager/remote_data_manager.dart';
import 'package:data/mappers/tester_access_request_mapper.dart';
import 'package:domain/domain.dart';

class TesterAccessRepositoryImpl implements TesterAccessRepository {
  TesterAccessRepositoryImpl(this._remoteDataManager);

  final RemoteDataManager _remoteDataManager;

  @override
  Future<DataResult<void>> submitAccessRequest() => safeDataCall(
    dataCall: () => _remoteDataManager.submitTesterAccessRequest(),
    processResult: (_) => SuccessResult(null),
  );

  @override
  Future<DataResult<TesterAccessRequest?>> fetchMyRequest() async {
    final user = _remoteDataManager.currentUser;
    if (user == null) {
      return ErrorResult(message: 'User not authenticated');
    }

    return safeDataCall(
      dataCall: () =>
          _remoteDataManager.fetchTesterAccessRequestForUser(user.id),
      processResult: (remote) => SuccessResult(remote?.toDomain()),
    );
  }

  @override
  Future<DataResult<List<TesterAccessRequest>>> fetchPendingRequests() =>
      safeDataCall(
        dataCall: () async {
          final remotes = await _remoteDataManager
              .fetchPendingTesterAccessRequests();
          return remotes.map((r) => r.toDomain()).toList();
        },
        processResult: SuccessResult.new,
      );

  @override
  Future<DataResult<void>> approveRequest({
    required String requestId,
    required String userId,
  }) => safeDataCall(
    dataCall: () => _remoteDataManager.approveTesterAccessRequest(
      requestId: requestId,
      userId: userId,
    ),
    processResult: (_) => SuccessResult(null),
  );

  @override
  Future<DataResult<void>> rejectRequest({required String requestId}) =>
      safeDataCall(
        dataCall: () =>
            _remoteDataManager.rejectTesterAccessRequest(requestId: requestId),
        processResult: (_) => SuccessResult(null),
      );
}
