import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/cart_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import '../auth_screen/login_screen.dart';

// import '../../controller/auth_controller.dart';
// import '../../controller/profile_controller.dart';
// import '../auth_screen/login_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return getBackground(
        child: Scaffold(
            appBar: AppBar(
              title: "Cart Details".text.fontFamily(bold).make(),
              elevation: 0,
            ),
            body: StreamBuilder(
              stream: FirestoreServices.getCart(currentUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: "Cart is Empty"
                            .text
                            .size(16)
                            .color(darkFontGrey)
                            .bold
                            .make(),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: whiteColor),
                        ),
                        onPressed: () {
                          Get.put(AuthController()).logout(context);
                          Get.offAll(() => const LoginScreen());
                        },
                        child: logout.text.white.make(),
                      ),
                    ],
                  );
                } else {
                  var data = snapshot.data!.docs;
                  controller.getTotal(data);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    ListTile(
                                      leading: Image.network(
                                        "${data[index]['image']}",
                                        height: 35,
                                        width: 35,
                                        fit: BoxFit.cover,
                                      ),
                                      title:
                                          "${data[index]['title']}   (${data[index]['quantity']})"
                                              .text
                                              .fontFamily(semibold)
                                              .size(14)
                                              .make(),
                                      subtitle: "${data[index]['price']}"
                                          .text
                                          .size(14)
                                          .color(redColor)
                                          .make(),
                                      trailing: IconButton(
                                        onPressed: () {
                                          FirestoreServices.deleteDocument(
                                              data[index].id);
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: redColor,
                                        ),
                                        color: redColor,
                                      ),
                                      minVerticalPadding: 15,
                                    ),
                                    const Divider(
                                      endIndent: 6,
                                      color: redColor,
                                    )
                                  ],
                                );
                              }),
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                "Total Price:".text.fontFamily(semibold).make(),
                                "${controller.tprice}"
                                    .numCurrency
                                    .text
                                    .color(redColor)
                                    .fontFamily(bold)
                                    .make(),
                              ],
                            ),
                            10.heightBox,
                            SizedBox(
                              width: context.screenWidth - 90,
                              child: ourButton(
                                  title: "Proceed To pay",
                                  textColor: whiteColor,
                                  color: redColor,
                                  onPress: () {}),
                            )
                          ],
                        )
                            .box
                            .margin(EdgeInsets.all(4))
                            .padding(EdgeInsets.all(10))
                            .color(goldenColor)
                            .alignment(Alignment.bottomRight)
                            .make(),
                      ],
                    )
                        .box
                        .white
                        .shadow
                        .roundedSM
                        .padding(EdgeInsets.symmetric(vertical: 10))
                        .make(),
                  );
                }
              },
            )));
  }
}
