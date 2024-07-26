import 'package:dinar/core/resources/data_state.dart';
import '../entities/nhagiare/blog/blog.dart';

abstract class BlogRepository {
  Future<DataState<List<BlogEntity>>> getAllBlogs();
  // Future<DataState<BlogEntity>> getBlogById(String id);
  // Future<DataState<void>> createBlog(
  //     {required String title,
  //     required String shortDescription,
  //     required String content,
  //     required String thumbnail}
  // );
}
