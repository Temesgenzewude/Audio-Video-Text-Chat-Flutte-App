import 'package:chatty/common/routes/names.dart';
import 'package:chatty/common/store/store.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'profile_state.dart';

class ProfileController extends GetxController {
  ProfileController();

  final String title = "Chatty .";
  final state = ProfileState();

  // used for navigation, transition, routing to new page
  @override
  void onReady() {
    super.onReady();

    Future.delayed(
        const Duration(seconds: 4), (() => Get.offAllNamed(AppRoutes.Message)));
  }


  @override
  void onInit() {
    super.onInit();
    var userItem= Get.arguments
  }

  void logOut() async {
    await GoogleSignIn().signOut();
    await UserStore.to.onLogout();
  }
}
