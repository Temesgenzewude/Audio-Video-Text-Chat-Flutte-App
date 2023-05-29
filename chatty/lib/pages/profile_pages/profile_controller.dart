import 'package:chatty/common/routes/names.dart';
import 'package:get/get.dart';

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
       const  Duration(seconds: 4), (() => Get.offAllNamed(AppRoutes.Message)));
  }
}
