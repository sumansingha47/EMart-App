import 'package:emart_app_2023_baaba_devs1/consts/consts.dart';
import 'package:emart_app_2023_baaba_devs1/controllers/cart_controller.dart';
import 'package:emart_app_2023_baaba_devs1/views/cart_screens/payment_method.dart';
import 'package:emart_app_2023_baaba_devs1/widgets_common/custom_textField.dart';
import 'package:get/get.dart';

import '../../widgets_common/our_button.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          color: redColor,
          onPress: () {
            if (controller.addressController.text.length > 10) {
              Get.to(const PaymentMethods());
            } else {
              VxToast.show(context,
                  bgColor: Colors.orange, msg: "Please fill all the fields!");
            }
          },
          textColor: whiteColor,
          title: "Procced to shipping",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(
              hint: "Address",
              isPass: false,
              title: "Address",
              controller: controller.addressController,
            ),
            customTextField(
              hint: "City",
              isPass: false,
              title: "City",
              controller: controller.cityController,
            ),
            customTextField(
              hint: "State",
              isPass: false,
              title: "State",
              controller: controller.stateController,
            ),
            customTextField(
              hint: "Postal Code",
              isPass: false,
              title: "Postal Code",
              controller: controller.postalController,
            ),
            customTextField(
              hint: "Phone",
              isPass: false,
              title: "Phone",
              controller: controller.phoneController,
            ),
          ],
        ),
      ),
    );
  }
}
