import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/models/category_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  var subCategories = [];
  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;

  getSubCategories(title) async {
    subCategories.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var jsonDecoded = categoryModelFromJson(data);

    var mainCat = jsonDecoded.categories
        .where((element) => element.name == title)
        .toList();

    for (var element in mainCat[0].subcategories) {
      subCategories.add(element);
    }
  }

  changeColorIndex(index) {
    colorIndex = index;
  }

  incQuantity(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  decQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  getTotalPrice(price) {
    //print(totalPrice.value);
    return totalPrice.value = price * quantity.value;
  }

  addToCart({title, img, color, tprice, seller, qty, context}) async {
    await fireStore.collection(cartCollection).doc().set({
      'title': title,
      'image': img,
      'color': color,
      'price': tprice,
      'seller': seller,
      'quantity': qty,
      'added_by': currentUser!.uid
    }).catchError((onError) {
      VxToast.show(context,
          msg: onError.toString(),
          bgColor: darkFontGrey,
          textColor: whiteColor);
    });
  }

  resetValues() {
    colorIndex.value = 0;
    quantity.value = 0;
    totalPrice.value = 0;
  }
}
