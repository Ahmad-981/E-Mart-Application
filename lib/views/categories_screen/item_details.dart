import 'dart:ffi';

import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controller/category_controller.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  var data;
  ItemDetails({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CategoryController>();
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                controller.resetValues();
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios_new)),
          // backgroundColor: fontGrey.withOpacity(0.5),
          elevation: 0,
          title:
              title!.text.fontFamily(bold).color(darkFontGrey).size(15).make(),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  color: fontGrey,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_outline,
                  color: fontGrey,
                ))
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                        height: 350,
                        reverse: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        itemCount: data['p_images'].length,
                        itemBuilder: (contect, index) {
                          return Image.network(
                            data["p_images"][index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ).box.roundedSM.clip(Clip.antiAlias).make();
                        }),

                    //Details
                    10.heightBox,
                    data['p_name']
                        .toString()
                        .text
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .size(17)
                        .make(),
                    10.heightBox,
                    VxRating(
                      value: double.parse(data['p_rating']),
                      onRatingUpdate: (index) {},
                      normalColor: lightGrey,
                      selectionColor: redColor,
                      count: 5,
                      isSelectable: false,
                      size: 25,
                      maxRating: 5,
                    ),
                    10.heightBox,
                    data['p_price']
                        .toString()
                        .numCurrencyWithLocale()
                        .text
                        .size(18)
                        .fontFamily(bold)
                        .color(redColor)
                        .make(),
                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Seller:"
                                  .text
                                  .fontFamily(semibold)
                                  .color(redColor)
                                  .make(),
                              10.heightBox,
                              data['p_seller']
                                  .toString()
                                  .text
                                  .color(redColor)
                                  .size(16)
                                  .color(darkFontGrey)
                                  .make()
                            ],
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: whiteColor,
                          child: IconButton(
                            focusColor: whiteColor,
                            color: redColor,
                            onPressed: () {},
                            icon: const Icon(Icons.message_rounded),
                          ),
                        ),
                      ],
                    )
                        .box
                        .height(70)
                        .color(lightGrey)
                        .padding(const EdgeInsets.symmetric(horizontal: 14))
                        .make(),

                    //Color Selection
                    15.heightBox,
                    Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                  width: 100,
                                  child: "Colors:"
                                      .text
                                      .fontFamily(semibold)
                                      .color(fontGrey)
                                      .make()),
                              Row(
                                children: List.generate(
                                    data['p_color'].length,
                                    (index) => Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            VxBox()
                                                .roundedFull
                                                .size(40, 40)
                                                .color(Color(
                                                        data['p_color'][index])
                                                    .withOpacity(1.0))
                                                .margin(
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 7))
                                                .make()
                                                .onTap(() {
                                              controller
                                                  .changeColorIndex(index);
                                            }),
                                            Visibility(
                                                visible: index ==
                                                    controller.colorIndex,
                                                child: Icon(
                                                  Icons.done,
                                                  color: whiteColor,
                                                ))
                                          ],
                                        )),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                  width: 100,
                                  child: "Quantity:"
                                      .text
                                      .fontFamily(semibold)
                                      .color(fontGrey)
                                      .make()),
                              Row(children: [
                                IconButton(
                                    onPressed: () {
                                      controller.getTotalPrice(
                                          int.parse(data['p_price']));
                                      controller.decQuantity();
                                    },
                                    icon: const Icon(Icons.remove)),
                                controller.quantity.value.text
                                    .fontFamily(bold)
                                    .size(14)
                                    .make(),
                                IconButton(
                                    onPressed: () {
                                      controller.getTotalPrice(
                                          int.parse(data['p_price']));
                                      controller.incQuantity(
                                          int.parse(data['p_quantity']));
                                    },
                                    icon: const Icon(Icons.add)),
                                "(${data['p_quantity']} Items available)"
                                    .text
                                    .color(redColor)
                                    .fontFamily(semibold)
                                    .make()
                              ]),
                              10.heightBox,
                            ],
                          ),
                          Row(children: [
                            SizedBox(
                                width: 100,
                                child: "Total Price:"
                                    .text
                                    .fontFamily(semibold)
                                    .color(fontGrey)
                                    .make()),
                            30.widthBox,
                            SizedBox(
                                width: 120,
                                child: controller
                                    .getTotalPrice(int.parse(data['p_price']))
                                    .toString()
                                    .numCurrencyWithLocale()
                                    .text
                                    .fontFamily(bold)
                                    .color(redColor)
                                    .make()),
                          ])
                        ],
                      )
                          .box
                          .white
                          .padding(const EdgeInsets.all(10))
                          .shadowSm
                          .make(),
                    ),

                    //Items Desc
                    15.heightBox,
                    "Description:"
                        .text
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .make(),
                    15.heightBox,
                    "${data['p_desc']}:"
                        .text
                        .fontFamily(semibold)
                        .color(textfieldGrey)
                        .make(),
                    15.heightBox,

                    ListView(
                      shrinkWrap: true,
                      children: List.generate(
                          5,
                          (index) => ListTile(
                                leading: itemDetailsButton[index].text.make(),
                                trailing: const Icon(Icons.arrow_forward),
                              )),
                    ),

                    20.heightBox,

                    productsLike.text
                        .size(16)
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .make(),
                    15.heightBox,
                    //Products You make Like
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            6,
                            (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      imgP6,
                                      width: 150,
                                      fit: BoxFit.fill,
                                    ),
                                    10.heightBox,
                                    "Sports Shoes "
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    "\$600"
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
                                    .padding(const EdgeInsets.all(8))
                                    .make()),
                      ),
                    )
                  ],
                ),
              ),
            )),
            SizedBox(
              width: context.screenWidth,
              height: 60,
              child: SizedBox(
                width: context.screenWidth,
                child: ourButton(
                    color: redColor,
                    textColor: whiteColor,
                    title: addToCart,
                    onPress: () {
                      controller.addToCart(
                          title: data['p_name'],
                          img: data['p_images'][0],
                          color: data['p_color'][controller.colorIndex.value],
                          context: context,
                          qty: controller.quantity.value,
                          tprice: controller.totalPrice.value,
                          seller: data['p_seller']);
                      VxToast.show(context, msg: "Added to cart");
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
