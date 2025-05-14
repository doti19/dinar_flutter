import 'package:dinar/features/domain/entities/credit/post.dart';
import 'package:dinar/features/domain/entities/credit/user.dart';
import 'package:dinar/features/domain/enums/bid_status.dart';
import 'package:dinar/features/domain/enums/post_type.dart';
import 'package:equatable/equatable.dart';

class BidEntity extends Equatable {
  final String? id;
  final UserEntity? bidder;
  final PostEntity? post;
  final PostTypes? type;
  final double? amount;
  final BidStatus? status;
  final int? tenureMonths;
  final List<String>? images;
  final InterestRate? interestRate;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const BidEntity({
    this.id,
    this.bidder,
    this.post,
    this.type,
    this.amount,
    this.status,
    this.tenureMonths,
    this.images,
    this.interestRate,
    this.createdAt,
    this.updatedAt,
  });

  factory BidEntity.fromJson(Map<String, dynamic> json) {
    return BidEntity(
      id: json['_id'] as String?,
      bidder: UserEntity.fromJson(json['bidder']),
      post: PostEntity.fromJson(json['post']),
      type: json['type'] != null ? PostTypes.parse(json['type']) : null,
      amount: json['amount'],
      status: json['status'] != null
          ? BidStatus.values
              .firstWhere((element) => element.toString() == json['status'])
          : null,
      tenureMonths: json['tenureMonths'] as int?,
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      interestRate: json['interestRate'] != null
          ? InterestRate.fromJson(json['interestRate'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  toJson() {
    return {
      'bidder': bidder!.id,
      'post': post!.id,
      'type': type.toString(),
      'amount': amount,
      'status': status.toString(),
      'tenureMonths': tenureMonths,
      'images': images,
      'interestRate': {
        'interest': interestRate!.interest,
        'unit': interestRate!.unit.toString(),
      },
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        bidder,
        post,
        type,
        amount,
        status,
        tenureMonths,
        images,
        interestRate,
        createdAt,
        updatedAt,
      ];

  BidEntity copyWith({
    String? id,
    UserEntity? bidder,
    PostEntity? post,
    PostTypes? type,
    double? amount,
    BidStatus? status,
    int? tenureMonths,
    List<String>? images,
    InterestRate? interestRate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BidEntity(
      id: id ?? this.id,
      bidder: bidder ?? this.bidder,
      post: post ?? this.post,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      tenureMonths: tenureMonths ?? this.tenureMonths,
      images: images ?? this.images,
      interestRate: interestRate ?? this.interestRate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
