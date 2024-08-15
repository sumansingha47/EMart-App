// ignore_for_file: use_build_context_synchronously, unnecessary_import

import 'dart:io';

import 'package:emart_app_2023_baaba_devs1/consts/colors.dart';
import 'package:emart_app_2023_baaba_devs1/consts/consts.dart';
import 'package:emart_app_2023_baaba_devs1/consts/images.dart';
import 'package:emart_app_2023_baaba_devs1/controllers/profile_controller.dart';
import 'package:emart_app_2023_baaba_devs1/widgets_common/bg_widget.dart';
import 'package:emart_app_2023_baaba_devs1/widgets_common/custom_textField.dart';
import 'package:emart_app_2023_baaba_devs1/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //if data image url and controller path is empty
                data["imageUrl"] == "" && controller.profileImgPath.isEmpty
                    ? Image.asset(imgProfile2, width: 100, fit: BoxFit.cover)
                        .box
                        .roundedFull
                        .clip(Clip.antiAlias)
                        .make()

                    // if data is not empty but controller path is empty
                    : data["imageUrl"] != "" &&
                            controller.profileImgPath.isEmpty
                        ? Image.network(data["imageUrl"],
                                width: 100, fit: BoxFit.cover)
                            .box
                            .roundedFull
                            .clip(Clip.antiAlias)
                            .make()

                        // if both data empty
                        : Image.file(File(controller.profileImgPath.value),
                                width: 100, fit: BoxFit.cover)
                            .box
                            .roundedFull
                            .clip(Clip.antiAlias)
                            .make(),
                10.heightBox,
                ourButton(
                  color: redColor,
                  onPress: () {
                    controller.changeImage(context);
                  },
                  textColor: whiteColor,
                  title: "Change",
                ),
                const Divider(),
                20.heightBox,
                customTextField(
                  controller: controller.nameController,
                  hint: nameHint,
                  title: name,
                  isPass: false,
                ),
                10.heightBox,
                customTextField(
                  controller: controller.oldPasswordController,
                  hint: passwordHint,
                  title: oldPass,
                  isPass: true,
                ),
                10.heightBox,
                customTextField(
                  controller: controller.newPasswordController,
                  hint: passwordHint,
                  title: newPass,
                  isPass: true,
                ),
                20.heightBox,
                controller.isLoading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : SizedBox(
                        width: context.screenWidth - 60,
                        child: ourButton(
                          color: redColor,
                          onPress: () async {
                            controller.isLoading(true);

                            //if image is not selected
                            if (controller.profileImgPath.value.isNotEmpty) {
                              await controller.uploadProfileImage();
                            } else {
                              controller.profileImageLink = data["imageUrl"];
                            }

                            //if old password matches database's password
                            if (data["password"] ==
                                controller.oldPasswordController.text) {
                              await controller.changeAuthPassword(
                                  email: data['email'],
                                  password:
                                      controller.oldPasswordController.text,
                                  newPassword:
                                      controller.newPasswordController.text);

                              await controller.updateProfile(
                                imageUrl: controller.profileImageLink,
                                name: controller.nameController.text,
                                password: controller.newPasswordController.text,
                              );
                              VxToast.show(context,
                                  bgColor:
                                      const Color.fromARGB(255, 22, 246, 30),
                                  msg: "Updated!");
                            } else {
                              VxToast.show(context,
                                  bgColor: Colors.orange,
                                  msg: "Wrong old pasword");
                              controller.isLoading(false);
                            }
                          },
                          textColor: whiteColor,
                          title: "Save",
                        ),
                      ),
              ],
            )
                .box
                .white
                .shadowSm
                .padding(const EdgeInsets.all(16))
                .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
                .rounded
                .make(),
          ),
        ),
      ),
    );
  }
}
