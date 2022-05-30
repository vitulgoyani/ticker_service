import 'package:dio/dio.dart';
import 'package:ticker_service/models/TrickerListModel.dart';


class NetworkUtils {
  final Dio dio = Dio();
  final String baseUrl = "https://ticker-service-w3zz3dng3q-uc.a.run.app/";

  /// get shipment list API call
  Future<TickerList?> getMemeList(String stocksId) async {
    try {
     dio.options.baseUrl = baseUrl;
      Response response = await dio.get(
        "ticker_id/?stocks=${stocksId??""}",
        options: Options(headers: {
          "Accept": "application/json",
        }),
      );
      print("response:$response");
      return TickerList.fromJson(response.data);
    } catch (error) {
      print(error);
    }
    return null;
  }

}
