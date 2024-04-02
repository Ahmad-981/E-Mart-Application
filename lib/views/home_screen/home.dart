import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/home_controller.dart';
import 'package:emart_app/views/cart_screen/cart_screen.dart';
import 'package:emart_app/views/categories_screen/categories_screen.dart';
import 'package:emart_app/views/home_screen/home_screen.dart';
import 'package:emart_app/views/profile_screen/profile_screen.dart';
import 'package:emart_app/widgets_common/exit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var homeController = Get.put(HomeController());
    var navbarItem = [
      BottomNavigationBarItem(
        icon: Image.asset(
          icHome,
          width: 26,
        ),
        label: home,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          icCategories,
          width: 26,
        ),
        label: categories,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          icCart,
          width: 26,
        ),
        label: cart,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          icProfile,
          width: 26,
        ),
        label: account,
      ),
    ];

    //List 2
    var navBody = [
      const HomeScreen(),
      const CategoriesScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];

    //Main
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return getExitButtonDialog(context);
            });

        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(
              () => Expanded(
                  child:
                      navBody.elementAt(homeController.currenItemIndex.value)),
            )
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: homeController.currenItemIndex.value,
            items: navbarItem,
            selectedItemColor: redColor,
            backgroundColor: whiteColor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              homeController.currenItemIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}
