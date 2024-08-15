import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app_2023_baaba_devs1/consts/consts.dart';
import 'package:emart_app_2023_baaba_devs1/views/auth_screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  var goToLoginScreen = false;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //login method
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (ex) {
      VxToast.show(context, bgColor: Colors.red, msg: ex.toString());
    }

    return userCredential;
  }

  //signup method
  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (ex) {
      VxToast.show(context, bgColor: Colors.red, msg: ex.toString());
    }

    return userCredential;
  }

  //storing data method
  storeUserData({name, password, email}) async {
    DocumentReference store =
        firestore.collection(usersCollection).doc(currentUser!.uid);
    store.set({
      "name": name,
      "password": password,
      "email": email,
      "imageUrl": "",
      "id": currentUser!.uid,
      "cart_count": "00",
      "wishlist_count": "00",
      "order_count": "00",
    });
  }

  //signout method
  signoutMethod(context) async {
    try {
      await auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        ),
      );

      goToLoginScreen = true;
    } catch (ex) {
      VxToast.show(context, bgColor: Colors.red, msg: ex.toString());
      goToLoginScreen = false;
    }
  }
}
