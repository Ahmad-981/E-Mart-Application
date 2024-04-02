import 'package:get/get.dart';

class CartController extends GetxController {
  var tprice = 0.obs;

  getTotal(data) {
    tprice.value = 0;
    for (var i = 0; i < data.length; i++) {
      tprice.value = tprice.value + int.parse(data[i]['price'].toString());
    }
  }
}
