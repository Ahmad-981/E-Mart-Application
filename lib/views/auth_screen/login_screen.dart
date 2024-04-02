import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controller/auth_controller.dart';
import 'package:emart_app/views/auth_screen/signup_screen.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/widgets_common/applogo_widget.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:emart_app/';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets_common/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var loading = false.obs;
  var controller = Get.put(AuthController());
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
            "Login to $appname".text.white.fontFamily(semibold).size(17).make(),
            15.heightBox,
            // customTextField()
            Obx(
              () => Column(
                children: [
                  customTextField(
                      title: email,
                      hint: emailhint,
                      controller: controller.emailController,
                      obsecureText: false),
                  customTextField(
                      title: password,
                      hint: passwordHint,
                      controller: controller.passwordController,
                      obsecureText: true),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {},
                        child: forgetPassword.text
                            .fontFamily(semibold)
                            .color(Colors.blue)
                            .make()),
                  ),
                  5.heightBox,
                  controller.loading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        )
                      : ourButton(
                          title: login,
                          color: redColor,
                          textColor: whiteColor,
                          onPress: () async {
                            controller.loading.value = true;
                            try {
                              await controller
                                  .signIn(context: context)
                                  .then((value) {
                                if (value != null) {
                                  VxToast.show(context,
                                      msg: "Login Successfully",
                                      showTime: 5000,
                                      bgColor: fontGrey,
                                      textColor: whiteColor);
                                  Get.to(() => const Home());
                                } else {
                                  controller.loading.value = false;
                                }
                              });
                            } catch (e) {
                              VxToast.show(context,
                                  msg: e.toString(),
                                  showTime: 5000,
                                  pdVertical: 40);
                            }
                          }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  10.heightBox,
                  ourButton(
                      title: signup,
                      color: goldenColor,
                      textColor: redColor,
                      onPress: () {
                        Get.to(() => const SignUpScreen());
                      }).box.width(context.screenWidth - 50).make(),
                  15.heightBox,
                  loginWith.text.color(fontGrey).make(),
                  10.heightBox,
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          3,
                          (index) => Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: CircleAvatar(
                                  backgroundColor: lightGrey,
                                  radius: 25,
                                  child: Image.asset(
                                    iconList[index],
                                    width: 30,
                                  ),
                                ),
                              )))
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
