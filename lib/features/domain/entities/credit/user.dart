import 'package:equatable/equatable.dart';
import 'package:dinar/features/domain/enums/role.dart';
import 'package:dinar/features/domain/enums/user_status.dart';
import '../nhagiare/posts/address.dart';

class UserEntity extends Equatable {
  final String? id;
  final UserStatus? status;
  final bool? isIdentityVerified;
  final Role? role;
  final String? email;
  final AddressEntity? address;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? avatar;
  final String? dob;
  final String? phone;
  final DateTime? lastActiveAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? bannedUtil;
  final String? banReason;

  String get fullName => "$firstName $lastName";

  const UserEntity({
    this.id,
    this.status,
    this.isIdentityVerified,
    this.role,
    this.email,
    this.address,
    this.firstName,
    this.lastName,
    this.gender,
    this.avatar,
    this.dob,
    this.phone,
    this.banReason,
    this.lastActiveAt,
    this.createdAt,
    this.updatedAt,
    this.bannedUtil,
  });

  @override
  List<Object?> get props => [id];

  UserEntity copyWith({
    String? id,
    UserStatus? status,
    bool? isIdentityVerified,
    Role? role,
    String? email,
    AddressEntity? address,
    String? firstName,
    String? lastName,
    String? gender,
    String? avatar,
    String? dob,
    String? phone,
    String? banReason,
    DateTime? lastActiveAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? bannedUtil,
  }) {
    return UserEntity(
      id: id ?? this.id,
      status: status ?? this.status,
      isIdentityVerified: isIdentityVerified ?? this.isIdentityVerified,
      role: role ?? this.role,
      email: email ?? this.email,
      address: address ?? this.address,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      avatar: avatar ?? this.avatar,
      dob: dob ?? this.dob,
      phone: phone ?? this.phone,
      banReason: banReason ?? this.banReason,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      bannedUtil: bannedUtil ?? this.bannedUtil,
    );
  }

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['_id'],
      status: UserStatus.parse(json['status'] ?? ""),
      isIdentityVerified: json['isIdentityVerified'] ?? false,
      role: Role.parse(json['role'] ?? ""),
      email: json['emailAddress']['email'] ?? "",
      address: AddressEntity.fromJson(json['address'] ?? {}),
      firstName: json['firstName'] ?? "",
      lastName: json['lastName'] ?? "",
      gender: json['gender'] ?? false,
      avatar: json['avatar'] ?? "",
      dob: json['dateOfBirth'] ?? "",
      phone: json['phoneNumber']['number'] ?? "",
      banReason: json['banReason'] ?? "",
      lastActiveAt: DateTime.parse(json['lastActiveAt'] ?? ""),
      createdAt: DateTime.parse(json['createdAt'] ?? ""),
      // createdAt: DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
      // updatedAt: DateTime.now(),
      bannedUtil: DateTime.tryParse(json['banUntil'] ?? ""),
    );
  }

  String? getFullName() {
    if (firstName == "" || lastName == "") {
      return null;
    }
    return "$firstName $lastName";
  }
}
