import 'package:get/get.dart';

import 'sign_in_index.dart';

class SignInBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
  }
}
