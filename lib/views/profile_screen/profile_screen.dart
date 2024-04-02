import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controller/auth_controller.dart';
import 'package:emart_app/controller/profile_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/views/profile_screen/components/wishButton.dart';
import 'package:emart_app/views/profile_screen/edit_profile.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return getBackground(
        child: Scaffold(
            body: StreamBuilder(
      stream: FirestoreServices.getUser(currentUser!.uid),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(redColor),
            ),
          );
        } else {
          //Accessing data is the list
          var data = snapshot.data!.docs[0];
          //Main widget
          return SafeArea(
              child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      "Edit Profile "
                          .text
                          .size(11)
                          .white
                          .fontFamily(semibold)
                          .make()
                          .onTap(() {
                        controller.nameController.text = data['name'];

                        Get.to(() => EditProfile(data: data));
                      }),
                      Align(
                        alignment: Alignment.topRight,
                        child: const Icon(
                          Icons.edit,
                          color: whiteColor,
                        ).onTap(() {
                          controller.nameController.text = data['name'];

                          Get.to(() => EditProfile(data: data));
                        }),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      data['imageURL'] == ""
                          ? Image.asset(
                              imgProfile,
                              width: 90,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make()
                          : Image.network(
                              data['imageURL'],
                              width: 100,
                              height: 80,
                              fit: BoxFit.cover,
                            )
                              .box
                              .roundedFull
                              .shadowLg
                              .clip(Clip.antiAlias)
                              .make(),
                      5.widthBox,
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "${data['name']}".text.size(11).bold.white.make(),
                          5.heightBox,
                          "${data['email']}".text.size(11).white.make(),
                        ],
                      )),
                    ],
                  ).box.padding(EdgeInsets.symmetric(horizontal: 10)).make(),
                  20.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      getWishButton(
                          count: "${data['cart']}",
                          title: "in your Cart",
                          width: context.screenWidth / 3.4),
                      getWishButton(
                          count: "${data['wishlist']}",
                          title: "in your Wishlist",
                          width: context.screenWidth / 3.4),
                      getWishButton(
                          count: "${data['orders']}",
                          title: "total Orders",
                          width: context.screenWidth / 3.4),
                    ],
                  ),
                  60.heightBox,
                  ListView.separated(
                    itemCount: 3,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      return ListTile(
                        leading: Image.asset(
                          profileButtonIcons[index],
                          width: 22,
                        ),
                        title: profileButtonList[index]
                            .text
                            .color(darkFontGrey)
                            .make(),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: lightGrey,
                      );
                    },
                  )
                      .box
                      .white
                      .rounded
                      .padding(const EdgeInsets.symmetric(horizontal: 16))
                      .shadowSm
                      .make()
                ],
              ),
            ),
          ));
        }
      },
    )));
  }
}
