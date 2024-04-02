import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget getExitButtonDialog(context) {
  return Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Exit".text.fontFamily(bold).color(darkFontGrey).size(18).make(),
        Divider(),
        15.heightBox,
        "Do you really want to exit?".text.fontFamily(semibold).size(14).make(),
        25.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
                title: "Yes",
                textColor: whiteColor,
                onPress: () {
                  SystemNavigator.pop();
                },
                color: redColor),
            ourButton(
                title: "No",
                textColor: whiteColor,
                onPress: () {
                  Navigator.pop(context);
                },
                color: redColor),
          ],
        )
      ],
    ).box.color(lightGrey).padding(EdgeInsets.all(15)).rounded.make(),
  );
}
