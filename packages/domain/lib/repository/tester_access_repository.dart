import 'package:domain/data_result/data_result.dart';
import 'package:domain/models/tester_access_request.dart';

abstract class TesterAccessRepository {
  Future<DataResult<void>> submitAccessRequest();

  Future<DataResult<TesterAccessRequest?>> fetchMyRequest();

  Future<DataResult<List<TesterAccessRequest>>> fetchPendingRequests();

  Future<DataResult<void>> approveRequest({
    required String requestId,
    required String userId,
  });

  Future<DataResult<void>> rejectRequest({required String requestId});
}
