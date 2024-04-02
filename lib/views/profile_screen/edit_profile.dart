import 'dart:io';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/profile_controller.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/custom_text_field.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfile extends StatelessWidget {
  dynamic data;
  EditProfile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return getBackground(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Obx(
        () => SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                //1st if
                data['imageURL'] == '' && controller.imagePath.isEmpty
                    ? Image.asset(
                        imgProfile,
                        width: 140,
                        fit: BoxFit.fill,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    //2nd if
                    : data['imageURL'] != '' && controller.imagePath.isEmpty
                        ? Image.network(
                            data['imageURL'],
                            width: 140,
                            fit: BoxFit.fill,
                          ).box.roundedFull.shadow.clip(Clip.antiAlias).make()
                        //Else- Both are empty
                        : Image.file(
                            File(controller.imagePath.value),
                            width: 140,
                            fit: BoxFit.fill,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                10.heightBox,

                ourButton(
                    title: "Change Profile",
                    textColor: whiteColor,
                    color: redColor,
                    onPress: () {
                      controller.pickImage(context);
                    }),
                25.heightBox,
                customTextField(
                  controller: controller.nameController,
                  title: name,
                  hint: "Edit Name",
                  obsecureText: false,
                ),
                10.heightBox,
                customTextField(
                    controller: controller.oldpasswordController,
                    title: "Old Password",
                    hint: "Enter Old Password",
                    obsecureText: true),
                10.heightBox,
                customTextField(
                    controller: controller.newpasswordController,
                    title: "New Password",
                    hint: "Enter New Password",
                    obsecureText: true),
                40.heightBox,
                SizedBox(
                    width: context.screenWidth,
                    child: controller.isLoading(false)
                        ? const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            ),
                          )
                        : ourButton(
                            title: "Save",
                            textColor: whiteColor,
                            color: redColor,
                            onPress: () async {
                              controller.isLoading(true);

                              //if image is selected
                              if (controller.imagePath.isNotEmpty) {
                                await controller.saveImage();
                              }
                              //if image is not selected
                              else {
                                controller.imageDownloadLink = data['imageURL'];
                              }

                              //If old password matched the database
                              if (data['password'] ==
                                  controller.oldpasswordController.text) {
                                await controller.updateAuthPassword(
                                    email: data['email'],
                                    password:
                                        controller.oldpasswordController.text,
                                    newpass:
                                        controller.newpasswordController.text);
                                await controller.saveUpdatedProfileData(
                                    name: controller.nameController.text,
                                    password:
                                        controller.newpasswordController.text,
                                    imageURL: controller.imageDownloadLink);

                                VxToast.show(context,
                                    msg: "Successfully Updated",
                                    bgColor: darkFontGrey,
                                    textColor: whiteColor);
                              } else {
                                VxToast.show(context,
                                    msg: "Wrong Old Password!",
                                    bgColor: darkFontGrey,
                                    textColor: whiteColor);
                                controller.isLoading(false);
                              }
                            })),
              ],
            )
                .box
                .rounded
                .shadow
                .white
                .padding(const EdgeInsets.all(20))
                .margin(
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 15))
                .make(),
          ),
        ),
      ),
    ));
  }
}
