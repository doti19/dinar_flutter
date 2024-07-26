import '../../../domain/entities/nhagiare/posts/address.dart';
import '../../../domain/entities/credit/user.dart';
import '../../../domain/enums/role.dart';
import '../../../domain/enums/user_status.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.id,
    super.status,
    super.isIdentityVerified,
    super.role,
    super.email,
    super.address,
    super.firstName,
    super.lastName,
    super.gender,
    super.avatar,
    super.dob,
    super.phone,
    super.lastActiveAt,
    super.createdAt,
    super.updatedAt,
    super.bannedUtil,
    super.banReason,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // print('haye $json');
    return UserModel(
      id: json['_id'],
      //status: UserStatus.parse(json['status']),
      status: UserStatus.parse(json['status'] ?? ""),
      isIdentityVerified: json['isIdentityVerified'],
      role: Role.parse(json['role']),
      email: json['emailAddress']['email'],
      address: json['address'] != null
          ? AddressEntity.fromJson(json['address'])
          : null,
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      avatar: json['avatar'],
      dob: json['dateOfBirth'],
      phone: json['phoneNumber']['number'],
      banReason: json['banReason'],
      lastActiveAt: DateTime.parse(json['lastActiveAt']),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      bannedUtil: json['bannedUntil'] != null
          ? DateTime.tryParse(json['bannedUntil'] ?? "")
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status.toString(),
      'isIdentityVerified': isIdentityVerified,
      'role': role.toString(),
      'email': email,
      'address': address,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'avatar': avatar,
      'dateOfBirth': dob,
      'phoneNumber': phone,
      'banReason': banReason,
      'lastActiveAt': lastActiveAt!.toIso8601String(),
      'created_at': createdAt != null ? createdAt?.toIso8601String() : null,
      'updated_at': updatedAt != null ? updatedAt!.toIso8601String() : null,
      'bannedUntil': bannedUtil != null ? bannedUtil!.toIso8601String() : null,
    };
  }
}
