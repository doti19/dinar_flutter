import 'package:dinar/core/resources/data_state.dart';
import 'package:dinar/core/usecases/usecase.dart';
import 'package:dinar/features/domain/repository/post_repository.dart';
import '../../../../../core/resources/pair.dart';
import '../../../entities/credit/post.dart';

class GetPostsUseCase
    implements
        UseCase<DataState<Pair<int, List<PostEntity>>>, Pair<String?, int?>?> {
  final PostRepository _postRepository;

  GetPostsUseCase(this._postRepository);

  @override
  Future<DataState<Pair<int, List<PostEntity>>>> call(
      {Pair<String?, int?>? params}) {
    if (params == null) {
      return _postRepository.getPosts(null, null, null);
    }
    return _postRepository.getPosts(params.first, null, params.second);
  }
}
