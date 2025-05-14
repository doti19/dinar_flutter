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
    super.postExpiresAt,
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
    super.bids,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    // print('zxcv ${(json['interestRate'] as Map).values.first}');
    DateTime? parseDate(String dateStr) {
      try {
        return DateTime.parse(dateStr);
      } catch (e) {
        print('Invalid date format: $dateStr');
        // return null;
        rethrow;
      }
    }

    return PostModel(
      id: json['_id'],
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
      createdAt: parseDate(json['createdAt']),
      updatedAt: parseDate(json['updatedAt']),
      postExpiresAt: json['postExpiresAt'] != null
          ? parseDate(json['postExpiresAt'])
          : null,
      interestRate: json['interestRate'] != null
          ? InterestRate.fromJson(json['interestRate'])
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
          ? InterestRate.fromJson(json['overdueInterestRate'])
          : null,
      // overdueInterestRate: 0.0,
      maxInterestRate: json['maxInterestRate'] != null
          ? InterestRate.fromJson(json['maxInterestRate'])
          : null,
      // maxInterestRate: 0.0,
      maxLoanAmount: json['maxAmount'] != null
          ? double.parse((json['maxAmount'] as Map).values.first)
          : null,
      // maxLoanAmount: 0.0,
      maxTenureMonths: json['maxTenureMonths'],
      // maxTenureMonths: 0,
      maxOverdueInterestRate: json['maxOverdueInterestRate'] != null
          ? InterestRate.fromJson(json['maxOverdueInterestRate'])
          : null,
      // maxOverdueInterestRate: 0.0,
      rejectedReason: json['rejectionReason'],
      deletedAt:
          json['deletedAt'] != null ? parseDate(json['deletedAt']) : null,
      postExpiresAfter: json['postExpiresAfter'],
      bids: json['bids'] != null ? json['bids'].cast<String>() : [],
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'type': type.toString(),
      'loanReasonType': loanReasonType?.toString(),
      'loanReasonDescription': loanReason,
      'title': title,
      'description': description,
      'images': images,
      'interestRate': interestRate?.toMap(),
      'amount': loanAmount,
      'tenureMonths': tenureMonths,
      // 'overdueInterestRate': overdueInterestRate ?? 0.1,
      'overdueInterestRate': overdueInterestRate?.toMap(),
      'maxInterestRate': maxInterestRate?.toMap(),
      'maxAmount': maxLoanAmount,
      'maxTenureMonths': maxTenureMonths,
      'maxOverdueInterestRate': maxOverdueInterestRate?.toMap(),
      'postExpiresAfter': postExpiresAfter ?? 3,
      'bids': bids,
    };

    //remove null values
    data.removeWhere((key, value) => value == null);
    return data;
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
      postExpiresAt: entity.postExpiresAt,
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
      bids: entity.bids,
    );
  }
}
