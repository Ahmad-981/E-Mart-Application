import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controller/category_controller.dart';
import 'package:emart_app/views/categories_screen/category_details.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CategoryController());
    return getBackground(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: categories.text.fontFamily(bold).make(),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 30),
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 15,
                crossAxisSpacing: 8,
                mainAxisExtent: 200),
            itemBuilder: (context, index) {
              return Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    categoriesImages[index],
                    height: 120,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  10.heightBox,
                  //Spacer(),
                  categoriesList[index]
                      .text
                      .color(darkFontGrey)
                      .fontFamily(semibold)
                      .align(TextAlign.center)
                      .make()
                ],
              )
                  .box
                  .rounded
                  .white
                  .shadowSm
                  .clip(Clip.antiAlias)
                  .make()
                  .onTap(() {
                controller.getSubCategories(categoriesList[index]);
                Get.to(() => CategoryDetails(title: categoriesList[index]));
              });
            }),
      ),
    ));
  }
}
