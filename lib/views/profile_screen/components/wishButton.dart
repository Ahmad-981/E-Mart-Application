import 'package:flutter/material.dart';
import 'package:emart_app/consts/consts.dart';

Widget getWishButton({width, String? title, String? count}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      count!.text.fontFamily(semibold).size(16).color(darkFontGrey).make(),
      5.heightBox,
      title!.text.center.color(darkFontGrey).make()
    ],
  ).box.white.rounded.height(80).width(width).padding(const EdgeInsets.all(4)).make();
}
