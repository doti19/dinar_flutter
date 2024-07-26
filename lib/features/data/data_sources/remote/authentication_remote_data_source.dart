import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/typedef.dart';
import '../../../../di/injection_container.dart';
import '../../models/credit/user.dart';
import '../local/authentication_local_data_source.dart';

abstract class AuthenRemoteDataSrc {
  Future<HttpResponse<Map<String, String>>> login(
      String email, String password);
  Future<HttpResponse<String>> signUp(String email, String password,
      String confirmPassword, String firstName, String lastName, String phone);
  Future<HttpResponse<UserModel>> updateProfile(File? avatar);
  Future<HttpResponse<void>> changePassword(
      String oldPassword, String newPassword, String confirmNewPassword);
  Future<HttpResponse<void>> signOut();
  Future<HttpResponse<void>> signOutAll();
  Future<HttpResponse<void>> activeAccount(
      String email, String password, String code);
  Future<HttpResponse<void>> resendOTP(String email);
  Future<HttpResponse<Map<String, String>>> refreshToken(String refreshToken);
  Future<HttpResponse<UserModel>> getMe();
}

class AuthenRemoteDataSrcImpl implements AuthenRemoteDataSrc {
  final Dio client;

  AuthenRemoteDataSrcImpl(this.client);

  @override
  Future<HttpResponse<void>> activeAccount(
      String email, String password, String code) async {
    // TODO: implement activeAccount
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse<void>> changePassword(
      String oldPassword, String newPassword, String confirmNewPassword) async {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse<Map<String, String>>> login(
      String email, String password) async {
    const url = '$apiDevAuthUrl$kSignIn';
    try {
      // Gửi yêu cầu đăng nhập
      final response = await client.post(
        url,
        data: {'email': email, 'password': password},
      );
      print(response);
      if (response.statusCode != 200) {
        throw ApiException(
          message: response.data,
          statusCode: response.statusCode!,
        );
      }
      // print(response);
      // Nếu yêu cầu thành công, giải mã dữ liệu JSON
      final DataMap data = DataMap.from(response.data);
      // print('saminas $');

      // Lấy AccessToken và RefreshToken từ dữ liệu giải mã
      String accessToken = data['tokens']['accessToken'];
      String refreshToken = data['tokens']['refreshToken'];

      // Trả về AccessToken và RefreshToken
      Map<String, String> value = {
        'accessToken': accessToken,
        'refreshToken': refreshToken
      };
      print('emhlelu $value');

      return HttpResponse(value, response);
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }

  @override
  Future<HttpResponse<Map<String, String>>> refreshToken(
      String refreshToken) async {
    const url = '$apiDevAuthUrl$kRefreshToken';
    try {
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? refreshToken = localDataSrc.getRefreshToken();

      if (refreshToken == null) {
        throw const ApiException(
            message: 'Refresh token is null', statusCode: 505);
      }

      // get new access token
      final response = await client.post(
        url,
        data: {"refreshToken": refreshToken},
        options: Options(
          receiveTimeout: const Duration(
            milliseconds: 5000,
          ), // Tăng thời gian chờ (milliseconds)
        ),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          message: response.data,
          statusCode: response.statusCode!,
        );
      }
      // print('kiros ${response.data['tokens']}');

      // Nếu yêu cầu thành công, giải mã dữ liệu JSON
      final DataMap data = DataMap.from(response.data["tokens"]);

      // Lấy AccessToken và RefreshToken từ dữ liệu giải mã
      String accessToken = data['accessToken'];
      String refresh = data['refreshToken'];
      Map<String, String> value = {
        'accessToken': accessToken,
        'refreshToken': refresh
      };

      // print('kiros 2: $value');

      return HttpResponse(value, response);
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }

  @override
  Future<HttpResponse<void>> resendOTP(String email) async {
    // TODO: implement resendOTP
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse<void>> signOut() async {
    const url = '$apiDevAuthUrl$kSignOut';
    try {
      // get access token
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();
      String? refreshToken = localDataSrc.getRefreshToken();

      if (accessToken == null) {
        throw const ApiException(
            message: 'Access token is null', statusCode: 505);
      }
      // Gửi yêu cầu đăng xuat
      final response = await client.post(
        url,
        data: {'refreshToken': refreshToken},
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode != 200) {
        throw ApiException(
          message: response.data,
          statusCode: response.statusCode!,
        );
      }

      return HttpResponse(null, response);
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }

  @override
  Future<HttpResponse<void>> signOutAll() async {
    // TODO: implement signOutAll
    throw UnimplementedError();
  }

  @override
  Future<HttpResponse<String>> signUp(
      String email,
      String password,
      String confirmPassword,
      String firstName,
      String lastName,
      String phoneNumber) async {
    const url = '$apiDevAuthUrl$kSignUp';
    try {
      // Gửi yêu cầu đăng ky
      final response = await client.post(
        url,
        options: Options(sendTimeout: const Duration(seconds: 10)),
        data: {
          'firstName': firstName,
          'lastName': lastName,
          'phoneNumber': phoneNumber,
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword
        },
      );
      if (response.statusCode != 201) {
        throw ApiException(
          message: response.data['message'],
          statusCode: response.statusCode!,
        );
      }
      print('samin ${response.data['user']}');
      // Nếu yêu cầu thành công, giải mã dữ liệu JSON
      final DataMap data = DataMap.from(response.data["user"]);
      String otpCode = data['otp'];
      print('nahum $otpCode');

      return HttpResponse(otpCode, response);
    } on DioException catch (e) {
      throw ApiException(
        message: e.message!,
        statusCode: e.response?.statusCode ?? 505,
      );
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }

  MediaType getMediaType(String path) {
    final ext = path.split('.').last;
    switch (ext) {
      case 'jpg':
      case 'jpeg':
        return MediaType('image', 'jpg');
      case 'png':
        return MediaType('image', 'png');
      case 'mp4':
        return MediaType('video', 'mp4');
      default:
        throw const ApiException(
            message: 'Media type not supported', statusCode: 505);
    }
  }

  @override
  Future<HttpResponse<UserModel>> updateProfile(
    File? avatar,
  ) async {
    String url = '$apiUrl$kUpdateMe';
    try {
      // get access token
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();
      if (accessToken == null) {
        throw const ApiException(
            message: 'Access token is null', statusCode: 505);
      }
      // final avatar = params?['avatar'] ?? null;

      final FormData formData = FormData.fromMap({
        "avatar": avatar != null
            ? MultipartFile.fromFileSync(avatar.path,
                contentType: getMediaType(avatar.path))
            : '',
      });
      print('abrsh ${formData}');

      // if (params!['email']) {
      //   formData['email'] = params['email'];
      // }

      final response = await client.patch(
        url,
        data: formData,
        options: Options(
            sendTimeout: const Duration(seconds: 10),
            headers: {'Authorization': 'Bearer $accessToken'}),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          message: response.data['message'],
          statusCode: response.statusCode!,
        );
      }

      UserModel user1 = UserModel.fromJson(response.data);

      return HttpResponse<UserModel>(
        user1,
        response,
      );
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }

  @override
  Future<HttpResponse<UserModel>> getMe() {
    const url = '$apiUrl$kGetMe';
    AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
    String? accessToken = localDataSrc.getAccessToken();
    if (accessToken == null) {
      throw const ApiException(
          message: 'Access token is null', statusCode: 505);
    }
    return client
        .get(url,
            options: Options(headers: {'Authorization': 'Bearer $accessToken'}))
        .then((response) {
      if (response.statusCode != 200) {
        throw ApiException(
          message: response.data['message'],
          statusCode: response.statusCode!,
        );
      }

      // Nếu yêu cầu thành công, giải mã dữ liệu JSON
      final DataMap data = DataMap.from(response.data);

      // print('abrsha ${data}');
      UserModel user = UserModel.fromJson(data);

      return HttpResponse(user, response);
    });
  }
}
