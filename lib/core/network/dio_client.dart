import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'dio_client.g.dart';

@RestApi(baseUrl: '')
abstract class DioClient {
  factory DioClient(Dio dio, {String baseUrl}) = _DioClient;

  @GET('search')
  Future<Response<Map<String, dynamic>>> searchData({
    @Path() String? searchType = '',
    @Query('q') String? searchKey = '',
    @Query('page') int? page = 1,
    @Query('per_page') int? resultCount = 10,
  });
}
