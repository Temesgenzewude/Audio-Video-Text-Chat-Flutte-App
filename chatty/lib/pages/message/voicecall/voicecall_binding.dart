import 'package:get/get.dart';
import 'voicecall_controller.dart';

class VoiceCallViewBinding implements Bindings {

@override
void dependencies() {
  Get.lazyPut<VoiceCallViewController>(() => VoiceCallViewController());
}
}
