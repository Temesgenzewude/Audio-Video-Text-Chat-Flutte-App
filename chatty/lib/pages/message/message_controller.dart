import 'package:chatty/common/routes/names.dart';
import 'package:get/get.dart';

import 'message_state.dart';

class MessageController extends GetxController {
  MessageController();

  final state = MessageState();

  void goToProfile() async {
    await Get.toNamed(AppRoutes.Profile);
  }
}
