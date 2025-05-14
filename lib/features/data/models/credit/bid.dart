import 'package:dinar/features/domain/entities/credit/bid.dart';
import 'package:dinar/features/domain/entities/credit/post.dart';
import 'package:dinar/features/domain/entities/credit/user.dart';
import 'package:dinar/features/domain/enums/bid_status.dart';
import 'package:dinar/features/domain/enums/post_type.dart';

class BidModel extends BidEntity {
  const BidModel({
    super.id,
    super.bidder,
    super.post,
    super.type,
    super.amount,
    super.status,
    super.tenureMonths,
    super.images,
    super.interestRate,
    super.createdAt,
    super.updatedAt,
  });

  factory BidModel.fromJson(Map<String, dynamic> json) {
    return BidModel(
      id: json['_id'] as String?,
      bidder: UserEntity.fromJson(json['bidder']),
      post: PostEntity.fromJson(json['post']),
      type: json['type'] != null ? PostTypes.parse(json['type']) : null,
      amount: json['amount'] != null
          ? double.parse((json['amount'] as Map).values.first)
          : null,
      status: json['status'] != null
          ? BidStatus.values
              .firstWhere((element) => element.toString() == json['status'])
          : null,
      tenureMonths: json['tenure'] as int?,
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      interestRate: json['interestRate'] != null
          ? InterestRate.fromJson(json['interestRate'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      '_id': id,
      'type': type.toString(),
      'amount': amount,
      'status': status.toString(),
      'tenureMonths': tenureMonths,
      'images': images,
      'interestRate': interestRate?.toMap(),
      'createdAt': createdAt!.toIso8601String(),
      'updatedAt': updatedAt!.toIso8601String(),
    };
    data.removeWhere((key, value) => value == null);
    return data;
  }

  factory BidModel.fromEntity(BidEntity entity) {
    return BidModel(
      id: entity.id,
      bidder: entity.bidder,
      post: entity.post,
      type: entity.type,
      amount: entity.amount,
      status: entity.status,
      tenureMonths: entity.tenureMonths,
      images: entity.images,
      interestRate: entity.interestRate,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
