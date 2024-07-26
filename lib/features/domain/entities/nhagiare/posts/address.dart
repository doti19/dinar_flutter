import 'package:dinar/di/injection_container.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../usecases/address/get_address.dart';

class AddressEntity extends Equatable {
  final String streetAddress;
  final String? streetAddress2;

  final String city;
  final String stateProvince;
  final String country;

  AddressEntity(
    this.streetAddress2, {
    required this.streetAddress,
    required this.city,
    required this.stateProvince,
    required this.country,
  }) : assert(country?.trim().isNotEmpty ?? true);

  Map<String, dynamic> toJson() => {
        'streetAddress': streetAddress,
        'streetAddress2': streetAddress2 ?? '',
        'city': city,
        'stateProvince': stateProvince,
        'country': country,
      };

  AddressEntity.fromJson(Map<String, dynamic> json)
      : streetAddress =
            json['streetAddress'] != null ? json['streetAddress'] : '',
        streetAddress2 = json['streetAddress2'] ?? '',
        city = json['city'],
        stateProvince = json['stateProvince'],
        country = json['country'];

  @override
  String toString() {
    String result = "";
    result += country != null ? "$country, " : "";
    result += stateProvince != null ? "$stateProvince, " : "";
    result += city != null ? "$city, " : "";
    result += streetAddress != null ? "$streetAddress" : "";
    return result;
  }

  String getDetailAddress() {
    final GetAddressUseCase getAddressUseCase = sl<GetAddressUseCase>();
    final dataState = getAddressUseCase(
      params: this,
    );

    if (dataState is DataSuccess) {
      return dataState.data!;
    } else {
      return toString();
    }
  }

  @override
  List<Object?> get props => [streetAddress];
}
