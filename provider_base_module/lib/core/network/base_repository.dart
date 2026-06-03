import 'result.dart';

class BaseRepository {
  Future<Result<T>> safeApiCall<T>(Future<T> Function() apiCall) async {
    try {
      final response = await apiCall();
      return Result.success(response);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}