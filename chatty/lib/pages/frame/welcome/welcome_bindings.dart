
import 'package:chatty/pages/frame/welcome/welcome_controller.dart';
import 'package:get/get.dart';



// for dependencies injection
class WelcomeBinding implements Bindings {
  @override
  void dependencies() {
    // 
    Get.lazyPut<WelcomeController>(() => WelcomeController());
  }
}


