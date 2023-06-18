
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:get/get.dart';

class VoiceCallViewState {
  //  RxString url = "".obs;
   RxBool isJoined = false.obs;
   RxBool openMicrophone = true.obs;
   RxBool enableSpeaker = true.obs;
   RxString callTime = "00:00".obs;
   RxString callStatus = "not connected".obs;


   var channelId = "".obs;

   var to_token = "".obs;
   var to_name = "".obs;
   var to_avatar = "".obs;
   var doc_id = "".obs;
   var call_role = "audience".obs;// 1，anchor 2，audience

}
