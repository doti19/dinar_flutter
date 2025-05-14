// import 'package:dinar/core/resources/data_state.dart';
// import 'package:dinar/core/resources/pair.dart';
// import 'package:dinar/core/usecases/usecase.dart';
// import 'package:dinar/features/domain/entities/credit/bid.dart';
// import 'package:dinar/features/domain/repository/bid_repository.dart';
// import 'package:dinar/features/domain/repository/post_repository.dart';
// import '../../../entities/credit/post.dart';

// class GetBidsRejectedUseCase
//     implements UseCase<DataState<Pair<int, List<BidEntity>>>, int?> {
//   final BidRepository _bidRepository;

//   GetBidsRejectedUseCase(this._bidRepository);

//   @override
//   Future<DataState<Pair<int, List<BidEntity>>>> call({int? params}) {
//     return _bidRepository.getBidsRejected(params);
//   }
// }
