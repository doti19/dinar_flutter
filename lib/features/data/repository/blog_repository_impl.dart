import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:dinar/core/resources/data_state.dart';
import 'package:dinar/features/data/data_sources/remote/blog_data_source.dart';
import 'package:dinar/features/domain/repository/blog_repository.dart';
import '../../domain/entities/nhagiare/blog/blog.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSrc blogRemoteDataSrc;

  BlogRepositoryImpl(this.blogRemoteDataSrc);

  @override
  Future<DataState<List<BlogEntity>>> getAllBlogs() async {
    try {
      final httpResponse = await blogRemoteDataSrc.getAllBlogs();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
  // @override
  // Future<DataState<void>> createBlog(String title, String shortDescription, String content, String thumbnail){
   
  // } 
