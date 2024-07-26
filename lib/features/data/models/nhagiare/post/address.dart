import 'dart:math';

import '../../../../domain/entities/nhagiare/posts/address.dart';

class AddressModel extends AddressEntity {
  AddressModel(
    super.streetAddress2, {
    required super.streetAddress,
    final String? cityName,
    required super.city,
    final String? districtName,
    required super.stateProvince,
    final String? wardName,
    required super.country,
    final double? latitude,
    final double? longitude,
  });

  @override
  Map<String, dynamic> toJson() => {
        'city_code': streetAddress,
        'district_code': city,
        'ward_code': stateProvince,
        'detail': country,
      };

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      json['streetAddress2'] ?? '',
      streetAddress: json['streetAddress'],
      city: json['city'],
      stateProvince: json['stateProvince'],
      country: json['country'],
    );
  }

  factory AddressModel.fromEntity(AddressEntity entity) {
    return AddressModel(entity.streetAddress2 ?? '',
        streetAddress: entity.streetAddress,
        city: entity.city,
        stateProvince: entity.stateProvince,
        country: entity.country);
  }
}
