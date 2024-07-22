import '../../models/api_response_model.dart';

abstract class IApiRepository {
  Future<(String?, ApiResponseModel<T>?)> get<T>(String endPoint);
}
