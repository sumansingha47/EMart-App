import 'package:emart_app_2023_baaba_devs1/consts/consts.dart';
import 'package:emart_app_2023_baaba_devs1/consts/lists.dart';
import 'package:emart_app_2023_baaba_devs1/controllers/auth_controller.dart';
import 'package:emart_app_2023_baaba_devs1/views/auth_screens/signup_screen.dart';
import 'package:emart_app_2023_baaba_devs1/views/home_screen/home.dart';
import 'package:emart_app_2023_baaba_devs1/widgets_common/applogo_widget.dart';
import 'package:emart_app_2023_baaba_devs1/widgets_common/bg_widget.dart';
import 'package:emart_app_2023_baaba_devs1/widgets_common/custom_textField.dart';
import 'package:emart_app_2023_baaba_devs1/widgets_common/our_button.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
              15.heightBox,
              Obx(
                () => Column(
                  children: [
                    customTextField(
                      controller: controller.emailController,
                      hint: emailHint,
                      title: email,
                      isPass: false,
                    ),
                    customTextField(
                      controller: controller.passwordController,
                      hint: passwordHint,
                      title: password,
                      isPass: false,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: forgetPass.text.make(),
                      ),
                    ),
                    5.heightBox,
                    // ourButton().box.width(context.screenWidth - 50).make(),

                    //LOGIN BUTTON
                    (controller.isLoading.value == true)
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          )
                        : ourButton(
                            color: redColor,
                            title: login,
                            textColor: whiteColor,
                            onPress: () async {
                              controller.isLoading(true);

                              await controller
                                  .loginMethod(context: context)
                                  .then((value) {
                                if (value != null) {
                                  VxToast.show(context, msg: loggedin);
                                  Get.offAll(() => const Home());
                                } else {
                                  controller.isLoading(false);
                                }
                              });
                            }).box.width(context.screenWidth - 50).make(),
                    5.heightBox,

                    createNewAccount.text.color(fontGrey).make(),

                    //SIGN UP BUTTON
                    5.heightBox,
                    ourButton(
                      color: lightGolden,
                      title: signup,
                      textColor: redColor,
                      onPress: () {
                        Get.to(() => const SignupScreen());
                      },
                    ).box.width(context.screenWidth - 50).make(),

                    10.heightBox,
                    loginWith.text.color(fontGrey).make(),
                    5.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          3,
                          (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: lightGrey,
                                  radius: 25,
                                  child: Image.asset(
                                    socialIconList[index],
                                    width: 30,
                                  ),
                                ),
                              )),
                    )
                  ],
                ),
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            ],
          ),
        ),
      ),
    );
  }
}
