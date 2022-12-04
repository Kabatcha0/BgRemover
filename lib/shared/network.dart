import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static void init() {
    dio = Dio(BaseOptions(
        baseUrl: "https://api.slazzer.com/v2.0/",
        receiveDataWhenStatusError: true,
        responseType: ResponseType.bytes));
  }

  static Future<Response> getData() async {
    dio.options.headers = {"API-KEY": "a17edf31bb30446eb495e73088aa66b5"};
    return await dio.get("remove_image_background");
  }

  static Future<Response> postData({required Map<String, dynamic> data}) async {
    dio.options.headers = {"API-KEY": "ec77bfed3ff14e3ebe6b2fc446e3a7ac"};
    return await dio.post("remove_image_background", data: data);
  }
}
