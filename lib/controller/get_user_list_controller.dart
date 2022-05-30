import 'package:get/get.dart';
import 'package:ticker_service/common/network_utils.dart';
import 'package:ticker_service/models/TrickerListModel.dart';


class GetUserListController extends GetxController {
  var trickerList = TickerList();
  var isLoading = true.obs;
  var isLoadingMore = false.obs;
  var listOfUser = <TickerInfo>[].obs;
  int i=0;
  String stocksId = "";

  @override
  void onInit() {
    // TODO: implement onInit
    getUserListAPICall(stocksId);
    super.onInit();
  }

  void getUserListAPICall(stocksId) {
    if(i!=0){
      isLoadingMore(true);
    }
    i++;
    NetworkUtils().getMemeList(stocksId).then((value) {
      if (value != null) {
        trickerList = value;
        value.tickerInfo!.forEach((element) {
          listOfUser.add(element);
        });
        isLoading(false);
        isLoadingMore(false);
      }
    });
  }
}
