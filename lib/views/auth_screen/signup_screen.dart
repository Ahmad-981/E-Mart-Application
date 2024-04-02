import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/auth_controller.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/widgets_common/applogo_widget.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets_common/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? isChecked = false;
  var controller = Get.put(AuthController());

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final retypePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return getBackground(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            appLogo(),
            15.heightBox,
            "Register to $appname"
                .text
                .white
                .fontFamily(semibold)
                .size(17)
                .make(),
            15.heightBox,
            // customTextField()
            Obx(
              () => Column(
                children: [
                  customTextField(
                      title: name,
                      hint: nameHint,
                      controller: nameController,
                      obsecureText: false),
                  customTextField(
                      title: email,
                      hint: emailhint,
                      controller: emailController,
                      obsecureText: false),
                  customTextField(
                      title: password,
                      hint: passwordHint,
                      controller: passwordController,
                      obsecureText: true),
                  customTextField(
                      title: reTypePassword,
                      hint: passwordHint,
                      controller: retypePasswordController,
                      obsecureText: true),
                  15.heightBox,
                  Row(
                    children: [
                      Checkbox(
                          checkColor: whiteColor,
                          activeColor: redColor,
                          value: isChecked,
                          onChanged: (newValue) {
                            setState(() {
                              isChecked = newValue;
                            });
                          }),
                      Expanded(
                        child: RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                              text: "I have agreed to",
                              style: TextStyle(
                                  fontFamily: regular, color: fontGrey)),
                          TextSpan(
                              text: termsAndCond,
                              style: TextStyle(
                                  fontFamily: regular, color: redColor)),
                          TextSpan(
                              text: " & ",
                              style: TextStyle(
                                  fontFamily: regular, color: fontGrey)),
                          TextSpan(
                              text: privacyPolicy,
                              style: TextStyle(
                                  fontFamily: regular, color: redColor)),
                        ])),
                      )
                    ],
                  ),
                  15.heightBox,
                  controller.loading.value
                      ? const CircularProgressIndicator()
                      : ourButton(
                          title: signup,
                          color: isChecked == true ? redColor : fontGrey,
                          textColor: whiteColor,
                          onPress: () async {
                            if (isChecked != false) {
                              controller.loading.value = true;
                              try {
                                await controller
                                    .signUp(
                                        context: context,
                                        email: emailController.text,
                                        password: passwordController.text)
                                    .then((value) {
                                  return controller.storageUserData(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text);
                                }).then((value) {
                                  VxToast.show(context,
                                      msg: "User Created Successfully",
                                      showTime: 5000,
                                      bgColor: fontGrey,
                                      textColor: whiteColor);
                                  Get.offAll(() => const Home());
                                });
                              } catch (e) {
                                controller.loading.value = false;
                                controller.logout(context);
                                VxToast.show(
                                  context,
                                  msg: e.toString(),
                                );
                                // bgColor: Colors.black,
                                // textColor: whiteColor
                              }
                            }
                          }).box.width(context.screenWidth - 50).make(),
                  15.heightBox,
                  RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                        text: alreadyHaveAccount,
                        style: TextStyle(color: fontGrey, fontFamily: bold)),
                    TextSpan(
                        text: login,
                        style: TextStyle(color: redColor, fontFamily: bold)),
                  ])).onTap(() {
                    Get.back();
                  })
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            ),
          ],
        ),
      ),
    ));
  }
}
