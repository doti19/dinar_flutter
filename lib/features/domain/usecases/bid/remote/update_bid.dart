import 'dart:io';

import 'package:dinar/core/usecases/usecase.dart';
import 'package:dinar/features/domain/entities/credit/bid.dart';
import 'package:dinar/features/domain/repository/bid_repository.dart';

class UpdateBidUseCase implements UseCase<void, BidEntity> {
  final BidRepository _repository;

  UpdateBidUseCase(this._repository);

  @override
  Future<void> call({BidEntity? params}) async {
    await _repository.updateBid(params!);
  }
}
