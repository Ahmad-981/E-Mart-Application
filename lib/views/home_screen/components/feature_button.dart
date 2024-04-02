import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';
// // ignore: duplicate_import
// import 'package:emart_app/consts/consts.dart';

Widget featureButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 60,
        fit: BoxFit.fill,
      ),
      5.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  )
      .box
      .width(220)
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .white
      .padding(const EdgeInsets.all(4))
      .rounded
      .outerShadowSm
      .make();
}
