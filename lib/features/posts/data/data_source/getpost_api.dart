import 'package:counterapp/features/posts/data/models/posts_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/constants/constants.dart';
part 'getpost_api.g.dart';

@RestApi(baseUrl: postAPIBaseURL)
abstract class ApiService1 {
  factory ApiService1(Dio dio, {String baseUrl}) = _ApiService1;

  //--> Get Request
  @GET('/posts')
  Future<Posta> getPostData(
    @Query('limit') int limit,
    @Query('skip') int skip,
  );
}
