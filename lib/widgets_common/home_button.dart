import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget homeButton({icon, String? title, height, width, onPress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icTodaysDeal,
        width: 26,
      ),
      10.heightBox,
      title!.text
          .fontFamily(semibold)
          .align(TextAlign.center)
          .color(darkFontGrey)
          .make()
    ],
  ).box.white.shadowSm.rounded.size(width, height).make();
}
