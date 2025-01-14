import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getUsername();
    super.onInit();
  }

  var currenItemIndex = 0.obs;
  var username = '';

  getUsername() async {
    var user = await fireStore
        .collection(userCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        return "No value";
      }
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });
    username = user;
    print(username);
  }
}
