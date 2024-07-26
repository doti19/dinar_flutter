import 'package:dinar/core/extensions/string_ex.dart';
import 'package:dinar/features/domain/entities/credit/post.dart';
import 'package:dinar/features/domain/enums/loan_reason_types.dart';
import 'package:dinar/features/domain/enums/post_type.dart';

import '../../../domain/entities/credit/user.dart';
import '../../../domain/enums/post_status.dart';

class PostModel extends PostEntity {
  const PostModel({
    super.id,
    super.user,
    super.type,
    super.loanReasonType,
    super.loanReason,
    super.status,
    super.title,
    super.description,
    super.images,
    super.createdAt,
    super.updatedAt,
    super.interestRate,
    super.loanAmount,
    super.tenureMonths,
    super.overdueInterestRate,
    super.maxInterestRate,
    super.maxLoanAmount,
    super.maxTenureMonths,
    super.maxOverdueInterestRate,
    super.rejectedReason,
    super.deletedAt,
    super.postExpiresAfter,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    // print('zxcv ${(json['interestRate'] as Map).values.first}');
    return PostModel(
      id: json['id'],
      user: json['user'] != null ? UserEntity.fromJson(json['user']) : null,
      type: json['type'] != null ? PostTypes.parse(json['type']) : null,
      loanReasonType: json['loanReasonType'] != null
          ? LoanReasonTypes.parse(json['loanReasonType'])
          : null,
      loanReason: json['loanReasonDescription'],
      status: json['status'] != null ? PostStatus.parse(json['status']) : null,
      title: json['title'],
      description: json['description'],
      images: List<String>.from(json['images'] ?? []),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      interestRate: json['interestRate'] != null
          ? double.parse((json['interestRate'] as Map).values.first)
          : null,
      // interestRate: 0.0,
      loanAmount: json['amount'] != null
          ? double.parse((json['amount'] as Map).values.first)
          : null,
      // loanAmount: 0.0,
      tenureMonths:
          json['tenureMonths'] != null ? json['tenureMonths'] as int : null,
      // tenureMonths: 0,
      overdueInterestRate: json['overdueInterestRate'] != null
          ? double.parse((json['overdueInterestRate'] as Map).values.first)
          : null,
      // overdueInterestRate: 0.0,
      maxInterestRate: json['maxInterestRate'] != null
          ? double.parse((json['maxInterestRate'] as Map).values.first)
          : null,
      // maxInterestRate: 0.0,
      maxLoanAmount: json['maxAmount'] != null
          ? double.parse((json['maxAmount'] as Map).values.first)
          : null,
      // maxLoanAmount: 0.0,
      maxTenureMonths: json['maxTenureMonths'],
      // maxTenureMonths: 0,
      maxOverdueInterestRate: json['maxOverdueInterestRate'] != null
          ? double.parse((json['maxOverdueInterestRate'] as Map).values.first)
          : null,
      // maxOverdueInterestRate: 0.0,
      rejectedReason: json['rejectionReason'],
      deletedAt: json['deletedAt'],
      postExpiresAfter: json['postExpiresAfter'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.toString(),
      'loanReasonType':
          loanReasonType != null ? loanReasonType.toString() : null,
      'loanReasonDescription': loanReason,
      'title': title,
      'description': description,
      'images': images,
      'interestRate': interestRate,
      'amount': loanAmount,
      'tenureMonths': tenureMonths,
      // 'overdueInterestRate': overdueInterestRate ?? 0.1,
      'overdueInterestRate': overdueInterestRate,
      'maxInterestRate': maxInterestRate,
      'maxAmount': maxLoanAmount,
      'maxTenureMonths': maxTenureMonths,
      'maxOverdueInterestRate': maxOverdueInterestRate,
      'postExpiresAfter': postExpiresAfter ?? 3,
    };
  }

  factory PostModel.fromEntity(PostEntity entity) {
    return PostModel(
      id: entity.id,
      user: entity.user,
      type: entity.type,
      loanReasonType: entity.loanReasonType,
      loanReason: entity.loanReason,
      status: entity.status,
      title: entity.title,
      description: entity.description,
      images: entity.images,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      interestRate: entity.interestRate,
      loanAmount: entity.loanAmount,
      tenureMonths: entity.tenureMonths,
      overdueInterestRate: entity.overdueInterestRate,
      maxInterestRate: entity.maxInterestRate,
      maxLoanAmount: entity.maxLoanAmount,
      maxTenureMonths: entity.maxTenureMonths,
      maxOverdueInterestRate: entity.maxOverdueInterestRate,
      rejectedReason: entity.rejectedReason,
      deletedAt: entity.deletedAt,
      postExpiresAfter: entity.postExpiresAfter,
    );
  }
}
