import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/home_screen/components/feature_button.dart';
import 'package:emart_app/widgets_common/home_button.dart';
import 'package:flutter/material.dart';

import '../../consts/lists.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: goldenColor,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
          child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 60,
            //color: lightGrey,
            // decoration: BoxDecoration(
            //     color: redColor, borderRadius: BorderRadius.circular(50)),
            //decoration: BoxDecoration(),
            child: TextFormField(
              decoration: const InputDecoration(
                  focusedBorder: InputBorder.none,
                  suffixIcon: Icon(Icons.search),
                  hintText: searchAnything,
                  fillColor: whiteColor,
                  filled: true,
                  hintStyle: TextStyle(color: textfieldGrey)),
            ),
          ),

          15.heightBox,
          //Swiper

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  VxSwiper.builder(
                      height: 150,
                      aspectRatio: 16 / 9,
                      reverse: true,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      itemCount: swiperList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          swiperList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .margin(const EdgeInsets.symmetric(horizontal: 10))
                            .shadowSm
                            .clip(Clip.antiAlias)
                            .make();
                      }),

                  15.heightBox,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        2,
                        (index) => homeButton(
                            width: context.screenWidth / 2.5,
                            height: context.screenHeight * 0.15,
                            title: index == 0 ? todayDeal : flashSale,
                            icon: index == 0 ? icTodaysDeal : icFlashDeal)),
                  ),

                  15.heightBox,

                  //Swiper 2
                  //Swiper
                  VxSwiper.builder(
                      height: 150,
                      aspectRatio: 16 / 9,
                      reverse: true,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      itemCount: secondSwiperList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          secondSwiperList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .margin(const EdgeInsets.symmetric(horizontal: 10))
                            .clip(Clip.antiAlias)
                            .make();
                      }),

                  15.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        3,
                        (index) => homeButton(
                            width: context.screenWidth / 3.5,
                            height: context.screenHeight * 0.15,
                            title: index == 0
                                ? topCategories
                                : index == 1
                                    ? brands
                                    : topSellers,
                            icon: index == 0
                                ? icTopCategories
                                : index == 1
                                    ? icBrands
                                    : icTopSeller)),
                  ),
                  15.heightBox,
                  Align(
                      alignment: Alignment.centerLeft,
                      child: topCategories.text
                          .size(17)
                          .fontFamily(semibold)
                          .make()),
                  20.heightBox,

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(
                            3,
                            (index) => Column(
                                  children: [
                                    featureButton(
                                        icon: featureImages1[index],
                                        title: featureTitle1[index]),
                                    10.heightBox,
                                    featureButton(
                                        icon: featureImages2[index],
                                        title: featureTitle2[index])
                                  ],
                                )).toList()),
                  ),
                  20.heightBox,
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: const BoxDecoration(color: redColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        featureProduct.text.white
                            .fontFamily(bold)
                            .size(18)
                            .make(),
                        15.heightBox,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                6,
                                (index) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          imgP1,
                                          width: 150,
                                          fit: BoxFit.fill,
                                        ),
                                        10.heightBox,
                                        "Laptop 64GB/16GB "
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

                  20.heightBox,
                  VxSwiper.builder(
                      height: 150,
                      aspectRatio: 16 / 9,
                      reverse: true,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      itemCount: secondSwiperList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          secondSwiperList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .margin(const EdgeInsets.symmetric(horizontal: 10))
                            .clip(Clip.antiAlias)
                            .make();
                      }),

                  20.heightBox,

                  GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 20,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 300,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              imgP5,
                              width: 200,
                              height: 200,
                              fit: BoxFit.fill,
                            ),
                            const Spacer(),
                            "Shoes Ladies "
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            10.heightBox,
                            "\$100"
                                .text
                                .color(redColor)
                                .fontFamily(bold)
                                .size(14)
                                .make()
                          ],
                        )
                            .box
                            .white
                            .margin(const EdgeInsets.symmetric(horizontal: 4))
                            .padding(const EdgeInsets.all(8))
                            .roundedSM
                            .shadowSm
                            .make();
                      })
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
