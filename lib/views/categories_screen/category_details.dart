import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/controller/category_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/categories_screen/item_details.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CategoryController());
    return getBackground(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: title!.text.fontFamily(bold).make(),
          ),
          body: StreamBuilder(
              stream: FirestoreServices.getProducts(title),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    ),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return "No Products Found"
                      .text
                      .fontFamily(semibold)
                      .size(17)
                      .color(darkFontGrey)
                      .makeCentered();
                } else {
                  //Main

                  var data = snapshot.data!.docs;
                  return Container(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                controller.subCategories.length,
                                (index) => "${controller.subCategories[index]}"
                                    .text
                                    .size(12)
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .makeCentered()
                                    .box
                                    .white
                                    .shadowSm
                                    .size(120, 60)
                                    .rounded
                                    .padding(
                                        EdgeInsets.symmetric(horizontal: 3))
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 3))
                                    .make()),
                          ),
                        ),
                        20.heightBox,
                        Expanded(
                          child: GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: data.length,
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                      mainAxisExtent: 250,
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      data[index]['p_images'][0],
                                      width: 165,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ).box.rounded.clip(Clip.antiAlias).make(),
                                    10.heightBox,
                                    data[index]['p_name']
                                        .toString()
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    data[index]['p_price']
                                        .toString()
                                        .numCurrencyWithLocale()
                                        .text
                                        .color(redColor)
                                        .fontFamily(bold)
                                        .size(14)
                                        .make()
                                  ],
                                )
                                    .box
                                    .white
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .roundedSM
                                    .shadowSm
                                    .padding(const EdgeInsets.all(8))
                                    .make()
                                    .onTap(() {
                                  Get.to(() => ItemDetails(
                                      title: data[index]['p_name'].toString(),
                                      data: data[index]));
                                });
                              }),
                        ),
                      ],
                    ),
                  );
                }
              })),
    );
  }
}
