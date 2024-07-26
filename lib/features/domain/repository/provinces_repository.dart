import '../../../core/resources/data_state.dart';

abstract class ProvincesRepository {
  DataState<String> getFullAddress(
    String streetAddress,
    String? streetAddress2,
    String city,
    String stateProvince,
    String country,
  );

  DataState<String> getProvinceName(int provinceCode);
  DataState<String> getDistrictName(int provinceCode, int districtCode);
  DataState<String> getWardName(
      int provinceCode, int districtCode, int wardCode);

  DataState<int> getProvinceCode(String provinceName);
  DataState<int> getDistrictCode(String districtName);
  DataState<int> getWardCode(String wardName);

  DataState<List<String>> getProvinceNames();
}
