import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;
import '../utill/images.dart';
import 'exception_api/exception_alert.dart';

class Api {
  Dio? dio;
  String? token;
  late String linkApi;

  Api() {
    token = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiMWY4YmIwNzg1NTgyOTlmZTQyMjcyNzViNGZkMzdjMiIsInN1YiI6IjY1ZTkwZWRkYWY5NTkwMDE2MWRiNmNmOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.DIpuX7U70fdPssj4-hiObVtneE9_neBCkh96bR8U5gs";
    linkApi = "https://api.themoviedb.org/3/";
    dio = Dio(
      BaseOptions(
          receiveDataWhenStatusError: true,
          connectTimeout: const Duration(minutes: 1), // 60 seconds
          receiveTimeout: const Duration(minutes: 1) // 60 seconds
          ),
    );
  }
  Future<Response<dynamic>?> methodGet(
    String url, {
    Map<String, dynamic>? queryParameters,
    bool? shoError = true,
    bool? isExternalLink = false,
  }) async {
    try {
      Map<String, dynamic>? query = queryParameters;
      query ??= <String, dynamic>{};
      if (isExternalLink != true) query.addEntries({"lang": "${g.Get.locale?.languageCode}"}.entries);
      Response<dynamic> response = await dio!.get(
        isExternalLink == true ? url : "$linkApi$url",
        queryParameters: query,
        options: Options(
          headers: {
            "enctype": "application/json",
            "Accept": "application/json",
            if (token != null && isExternalLink != true) "Authorization": token,
          },
        ),
      );

      printResponse(response);

      return response;
    } on DioException catch (ex) {
      if (shoError == false) {
        printError(ex);
        return ex.response;
      }
      return (await errorResponse(
          ex,
          () => methodGet(
                url,
                queryParameters: queryParameters,
                isExternalLink: isExternalLink,
                shoError: shoError,
              )) as Response<dynamic>?);
    }
  }

  Future<Response<dynamic>?> methodPost(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool? isExternalLink = false,
    bool? shoError = true,
  }) async {
    try {
      Response<dynamic>? response;
      response = await dio!.post(
        isExternalLink == true ? url : linkApi + url,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            "enctype": "application/json",
            "Accept": "application/json",
            if (token != null) "Authorization": token,
          },
        ),
        data: jsonEncode(data),
      );

      printResponse(response);

      return response;
    } on DioException catch (ex) {
      if (shoError == false) {
        printError(ex);
        return ex.response;
      }
      return (await errorResponse(
          ex,
          () => methodPost(
                url,
                data: data,
                queryParameters: queryParameters,
                isExternalLink: isExternalLink,
                shoError: shoError,
              )) as Response<dynamic>?);
    }
  }

  errorResponse(DioException ex, Function() functionApi) async {
    try {
      printError(ex);
    } catch (e) {}
    switch (ex.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        await Future.delayed(const Duration(
          milliseconds: 2 * 1000,
        ));

        if (ExceptionAlert.isDialogOpen == false) {
          ExceptionAlert.isDialogOpen = true;
          Map? result = await g.Get.dialog(
            ExceptionAlert(
                image: Images.icon404,
                text:
                    "There was a problem downloading data. Please check your network."),
           // navigatorKey: g.Get.global(0),
          );
          ExceptionAlert.isDialogOpen = false;
          if (result != null && result["event"] == "close") {
            return null;
          }
        } else {
          await Future.delayed(const Duration(
            milliseconds: 10 * 1000,
          ));
        }

        return await functionApi();

      case DioExceptionType.unknown:
        await Future.delayed(const Duration(
          milliseconds: 5 * 1000,
        ));
        if (ExceptionAlert.isDialogOpen == false) {
          ExceptionAlert.isDialogOpen = true;
          Map? result = await g.Get.dialog(
            ExceptionAlert(
                image: Images.icon404,
                text:
                    "There was a problem downloading data. Please check your network."),
            navigatorKey: g.Get.global(0),
          );
          ExceptionAlert.isDialogOpen = false;
          if (result != null && result["event"] == "close") {
            return null;
          }
        } else {
          await Future.delayed(const Duration(
            milliseconds: 10 * 1000,
          ));
        }

        return await functionApi();

      case DioExceptionType.badResponse:
      case DioExceptionType.badCertificate:
        if (ex.response!.statusCode == 401) {
          if (ExceptionAlert.isDialogOpen == false) {
            ExceptionAlert.isDialogOpen = true;
            await g.Get.dialog(
              ExceptionAlert(
                image: Images.errorSer,
                text:
                    "You have lost permission to access the server. Please log out.",
                textBtn: "Log out",
              ),
              navigatorKey: g.Get.global(0),
            );
            ExceptionAlert.isDialogOpen = false;
            return null;
          } else {
            await Future.delayed(const Duration(
              milliseconds: 2 * 1000,
            ));
          }
        }
        await Future.delayed(const Duration(
          milliseconds: 2 * 1000,
        ));

        if (ExceptionAlert.isDialogOpen == false) {
          ExceptionAlert.isDialogOpen = true;
          await g.Get.dialog(
            ExceptionAlert(
              image: Images.errorSer,
              text: "An unknown error occurred. Please try again later.",
              textBtn: "ok",
            ),
            navigatorKey: g.Get.global(0),
          );
          ExceptionAlert.isDialogOpen = false;
          return null;
        } else {
          await Future.delayed(const Duration(
            milliseconds: 2 * 1000,
          ));
        }
        return await functionApi();

      default:
    }
  }

  printError(
    DioException e,
  ) {
    var data;
    try {
      data = e.requestOptions.data == null
          ? null
          : jsonEncode(e.requestOptions.data);
    } catch (e) {}
    log("""
°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#
=============> Url      :  ${e.requestOptions.uri}
=============> Method   : ${e.requestOptions.method}
=============> data     : $data
=============> queryParameters     : ${jsonEncode(e.requestOptions.queryParameters)}
=============> Headers  : ${{
      "enctype": "application/json",
      "Accept": "application/json",
      if (token != null) "Authorization": token
    }}
=============> error    : ${e.error}
=============> message  : ${e.message}
=============> response : ${e.response?.data}
=============> type     : ${e.type}
°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#°#
""");
  }

  printResponse(
    Response<dynamic>? response,
  ) {
    var data;
    try {
      data = response!.requestOptions.data == null
          ? null
          : jsonEncode(response.requestOptions.data);
    } catch (e) {}
    log("""
---------------------------------------------------------------------------------
o  Url      :  ${response!.requestOptions.uri}
o  Method   : ${response.requestOptions.method}
o  data     : $data
o  queryParameters     : ${jsonEncode(response.requestOptions.queryParameters)}
o  Headers  : ${response.requestOptions.headers}
o  response status code : ${response.statusCode}
o  response data : ${jsonEncode(response.data)}
---------------------------------------------------------------------------------
""");
  }
}
