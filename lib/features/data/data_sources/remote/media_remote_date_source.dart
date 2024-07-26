import 'dart:io';
import 'package:dinar/core/constants/constants.dart';
import 'package:dinar/di/injection_container.dart';
import 'package:dinar/features/data/data_sources/local/authentication_local_data_source.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:retrofit/dio.dart';
import '../../../../core/errors/exceptions.dart';

abstract class MediaRemoteDataSource {
  Future<HttpResponse<List<String>>> uploadMedia(
      List<File> media, String typeMedia);
}

class MediaRemoteDataSourceImpl implements MediaRemoteDataSource {
  final Dio client;

  MediaRemoteDataSourceImpl(this.client);

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
  Future<HttpResponse<List<String>>> uploadMedia(
      List<File> media, String typeMedia) async {
    const url = '$apiUrl/media/upload';
    try {
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();
      final formData = FormData.fromMap({
        "medias": media
            .map((e) => MultipartFile.fromFileSync(e.path,
                contentType: getMediaType(e.path)))
            .toList(),
      });

      final response = await client.post(
        url,
        data: formData,
        options: Options(
            sendTimeout: const Duration(seconds: 10),
            headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode != 200) {
        throw DioException(
          error: response.data,
          response: response,
          type: DioExceptionType.badResponse,
          requestOptions: response.requestOptions,
        );
      }

      final data = response.data;
      List<String> result = [];
      print('habesha $typeMedia');
      if (typeMedia == "image") {
        result = List<String>.from(
            data['result']['images'].map((e) => e['filename']));
      } else {
        result = List<String>.from(data["result"]['videos']);
      }

      return HttpResponse(result, response);
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }
}
