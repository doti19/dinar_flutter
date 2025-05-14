import 'package:dinar/core/resources/data_state.dart';
import 'package:dinar/core/usecases/usecase.dart';
import 'package:dinar/features/domain/entities/credit/bid.dart';
import 'package:dinar/features/domain/enums/interest_unit_types.dart';
import 'package:dinar/features/domain/enums/post_type.dart';
import 'package:dinar/features/domain/repository/bid_repository.dart';
import 'package:equatable/equatable.dart';

class CreateBidUseCase implements UseCase<DataState<void>, BidParams> {
  final BidRepository _bidRepository;

  CreateBidUseCase(this._bidRepository);

  @override
  Future<DataState<void>> call({BidParams? params}) {
    return _bidRepository.createBid(params!);
  }
}

class BidParams extends Equatable {
  final double? amount;
  final double? interestRate;
  final int? tenure;
  final String? postId;
  final InterestUnitTypes? unit;
  final PostTypes type;

  BidParams(
      {this.amount,
      this.interestRate,
      this.unit,
      this.tenure,
      required this.type,
      this.postId});

  toJson() {
    return {
      'amount': amount,
      'interestRate': {
        'interest': interestRate,
        'unit': unit.toString(),
      },
      'tenure': tenure,
      'type': type.toString(),
    };
  }

  @override
  List<Object?> get props => [amount, interestRate, tenure];
}
