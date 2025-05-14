// import 'package:dinar/core/resources/data_state.dart';
// import 'package:dinar/core/usecases/usecase.dart';
// import 'package:dinar/features/domain/entities/credit/bid.dart';
// import 'package:dinar/features/domain/repository/bid_repository.dart';

// class GetBidUseCase implements UseCase<BidEntity?, String?> {
//   final BidRepository _repository;
//   GetBidUseCase(this._repository);

//   @override
//   Future<BidEntity?> call({String? params}) async {
//     return await _repository.getSingleBid(params!).then((value) {
//       if (value is DataSuccess) {
//         return value.data!;
//       } else {
//         return null;
//       }
//     });
//   }
// }
