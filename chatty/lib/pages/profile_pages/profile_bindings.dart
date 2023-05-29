
// ignore: unused_import
import 'package:chatty/pages/frame/welcome/welcome_controller.dart';
import 'package:get/get.dart';

import 'profile_controller.dart';



// for dependencies injection
class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    // 
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}


