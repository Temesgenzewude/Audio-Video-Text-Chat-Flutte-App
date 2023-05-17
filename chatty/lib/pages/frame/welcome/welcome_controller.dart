import 'package:chatty/common/routes/names.dart';
import 'package:get/get.dart';

import 'welcome_state.dart';

class WelcomeController extends GetxController {
  WelcomeController();

  final String title = "Chatty .";
  final state = WelcomeState();

  // used for navigation, transition, routing to new page
  @override
  void onReady() {
    super.onReady();

    Future.delayed(
        Duration(seconds: 4), (() => Get.offNamed(AppRoutes.Message)));
  }

}
