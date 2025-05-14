import 'package:dinar/features/domain/entities/credit/user.dart';
import 'package:dinar/features/domain/enums/interest_unit_types.dart';
import 'package:dinar/features/domain/enums/post_type.dart';
import 'package:equatable/equatable.dart';
import '../../enums/loan_reason_types.dart';
import '../../enums/post_status.dart';

class PostEntity extends Equatable {
  final String? id;
  final UserEntity? user;
  final PostTypes? type;
  final LoanReasonTypes? loanReasonType;
  final String? loanReason;
  final PostStatus? status;
  final String? title;
  final String? description;
  final List<String>? images;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? postExpiresAt;
  final InterestRate? interestRate;
  final double? loanAmount;
  final int? tenureMonths;
  final InterestRate? overdueInterestRate;
  final InterestRate? maxInterestRate;
  final double? maxLoanAmount;
  final int? maxTenureMonths;
  final InterestRate? maxOverdueInterestRate;
  final String? rejectedReason;
  final DateTime? deletedAt;
  final int? postExpiresAfter;
  final List<String>? bids;

  const PostEntity({
    this.id,
    this.user,
    this.type,
    this.loanReasonType,
    this.loanReason,
    this.status,
    this.title,
    this.description,
    this.images,
    this.createdAt,
    this.updatedAt,
    this.postExpiresAt,
    this.interestRate,
    this.loanAmount,
    this.tenureMonths,
    this.overdueInterestRate,
    this.maxInterestRate,
    this.maxLoanAmount,
    this.maxTenureMonths,
    this.maxOverdueInterestRate,
    this.rejectedReason,
    this.deletedAt,
    this.postExpiresAfter,
    this.bids,
  });

  @override
  List<Object?> get props => [
        id,
        user,
        type,
        loanReasonType,
        loanReason,
        status,
        title,
        description,
        images,
        createdAt,
        updatedAt,
        postExpiresAt,
        interestRate,
        loanAmount,
        tenureMonths,
        overdueInterestRate,
        maxInterestRate,
        maxLoanAmount,
        maxTenureMonths,
        maxOverdueInterestRate,
        rejectedReason,
        deletedAt,
        postExpiresAfter,
        bids,
      ];

  PostEntity copyWith({
    String? id,
    UserEntity? user,
    PostTypes? type,
    LoanReasonTypes? loanReasonType,
    String? loanReason,
    PostStatus? status,
    String? title,
    String? description,
    List<String>? images,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? postExpiresAt,
    InterestRate? interestRate,
    double? loanAmount,
    int? tenureMonths,
    InterestRate? overdueInterestRate,
    InterestRate? maxInterestRate,
    double? maxLoanAmount,
    int? maxTenureMonths,
    InterestRate? maxOverdueInterestRate,
    String? rejectedReason,
    DateTime? deletedAt,
    int? postExpiresAfter,
    List<String>? bids,
  }) {
    return PostEntity(
      id: id ?? this.id,
      user: user ?? this.user,
      type: type ?? this.type,
      loanReasonType: loanReasonType ?? this.loanReasonType,
      loanReason: loanReason ?? this.loanReason,
      status: status ?? this.status,
      title: title ?? this.title,
      description: description ?? this.description,
      images: images ?? this.images,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      postExpiresAt: postExpiresAt ?? this.postExpiresAt,
      interestRate: interestRate ?? this.interestRate,
      loanAmount: loanAmount ?? this.loanAmount,
      tenureMonths: tenureMonths ?? this.tenureMonths,
      overdueInterestRate: overdueInterestRate ?? this.overdueInterestRate,
      maxInterestRate: maxInterestRate ?? this.maxInterestRate,
      maxLoanAmount: maxLoanAmount ?? this.maxLoanAmount,
      maxTenureMonths: maxTenureMonths ?? this.maxTenureMonths,
      maxOverdueInterestRate:
          maxOverdueInterestRate ?? this.maxOverdueInterestRate,
      rejectedReason: rejectedReason ?? this.rejectedReason,
      deletedAt: deletedAt ?? this.deletedAt,
      postExpiresAfter: postExpiresAfter ?? this.postExpiresAfter,
      bids: bids ?? this.bids,
    );
  }

  // from json
  factory PostEntity.fromJson(Map<String, dynamic> json) {
    return PostEntity(
        id: json['_id'] as String?,
        user: json['user'] != null ? UserEntity.fromJson(json['user']) : null,
        type: json['type'] != null ? PostTypes.parse(json['type']) : null,
        loanReasonType: json['loanReasonType'] != null
            ? LoanReasonTypes.values.firstWhere(
                (element) => element.toString() == json['loanReasonType'])
            : null,
        loanReason: json['loanReasonDescription'] as String?,
        status: json['status'] != null
            ? PostStatus.values
                .firstWhere((element) => element.toString() == json['status'])
            : null,
        title: json['title'] as String?,
        description: json['description'] as String?,
        images:
            json['images'] != null ? List<String>.from(json['images']) : null,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'] as String)
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'] as String)
            : null,
        postExpiresAt: json['postExpiresAt'] != null
            ? DateTime.parse(json['postExpiresAt'] as String)
            : null,
        interestRate: json['interestRate'] != null
            ? InterestRate.fromJson(json['interestRate'])
            : null,
        loanAmount: json['amount'] != null
            ? double.parse((json['amount'] as Map).values.first)
            : null,
        tenureMonths: json['tenureMonths'] as int?,
        overdueInterestRate: json['overdueInterestRate'] != null
            ? InterestRate.fromJson(json['overdueInterestRate'])
            : null,
        maxInterestRate: json['maxInterestRate'] != null
            ? InterestRate.fromJson(json['maxInterestRate'])
            : null,
        maxLoanAmount: json['maxAmount'] as double?,
        maxTenureMonths: json['maxTenureMonths'] as int?,
        maxOverdueInterestRate: json['maxOverdueInterestRate'] != null
            ? InterestRate.fromJson(json['maxOverdueInterestRate'])
            : null,
        rejectedReason: json['rejectionReason'] as String?,
        deletedAt: json['deletedAt'] != null
            ? DateTime.parse(json['post_deleted_at'] as String)
            : null,
        postExpiresAfter: json['postExpiresAfter'] as int?,
        bids: json['bids'] != null ? json['bids'].cast<String>() : []);
  }
}

class InterestRate extends Equatable {
  const InterestRate({required this.interest, required this.unit});
  final double interest;
  final InterestUnitTypes unit;

  InterestRate copyWith({
    double? interest,
    InterestUnitTypes? unit,
  }) {
    return InterestRate(
      interest: interest ?? this.interest,
      unit: unit ?? this.unit,
    );
  }

  static InterestRate fromJson(Map<String, dynamic> json) {
    return InterestRate(
      interest: double.parse((json['interest'] as Map).values.first),
      unit: InterestUnitTypes.values
          .firstWhere((element) => element.toString() == json['unit']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'interest': interest,
      'unit': unit.toString(),
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [interest, unit];
}
