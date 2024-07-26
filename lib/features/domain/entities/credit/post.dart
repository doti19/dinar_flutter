import 'package:dinar/features/domain/entities/credit/user.dart';
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
  final double? interestRate;
  final double? loanAmount;
  final int? tenureMonths;
  final double? overdueInterestRate;
  final double? maxInterestRate;
  final double? maxLoanAmount;
  final int? maxTenureMonths;
  final double? maxOverdueInterestRate;
  final String? rejectedReason;
  final DateTime? deletedAt;
  final int? postExpiresAfter;

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
    double? interestRate,
    double? loanAmount,
    int? tenureMonths,
    double? overdueInterestRate,
    double? maxInterestRate,
    double? maxLoanAmount,
    int? maxTenureMonths,
    double? maxOverdueInterestRate,
    String? rejectedReason,
    DateTime? deletedAt,
    int? postExpiresAfter,
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
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      interestRate: json['interestRate'] as double?,
      loanAmount: json['amount'] as double?,
      tenureMonths: json['tenureMonths'] as int?,
      overdueInterestRate: json['overdueInterestRate'] as double?,
      maxInterestRate: json['maxInterestRate'] as double?,
      maxLoanAmount: json['maxAmount'] as double?,
      maxTenureMonths: json['maxTenureMonths'] as int?,
      maxOverdueInterestRate: json['maxOverdueInterestRate'] as double?,
      rejectedReason: json['rejectionReason'] as String?,
      deletedAt: json['deletedAt'] != null
          ? DateTime.parse(json['post_deleted_at'] as String)
          : null,
      postExpiresAfter: json['postExpiresAfter'] as int?,
    );
  }
}
