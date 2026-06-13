import 'package:domain/data_result/data_result.dart';

Future<DataResult<T>> safeDataCall<T, U>({
  required Future<U> Function() dataCall,
  required DataResult<T> Function(U) processResult,
}) async {
  try {
    return processResult(await dataCall());
  } catch (e) {
    return ErrorResult(message: e.toString());
  }
}
