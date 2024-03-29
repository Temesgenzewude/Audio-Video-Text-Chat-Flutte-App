import 'package:chatty/common/apis/apis.dart';
import 'package:chatty/common/entities/base.dart';
import 'package:chatty/common/routes/names.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../../common/store/user.dart';
import 'message_state.dart';

class MessageController extends GetxController {
  MessageController();

  final state = MessageState();

  void goToProfile() async {
    await Get.toNamed(AppRoutes.Profile, arguments:  state.head_detail.value);
  }

  @override
  void onReady() {
    super.onReady();
    firebaseMessageSetup();
  }

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future firebaseMessageSetup() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    print("... my device token is... $fcmToken");
    if (fcmToken != null) {
      BindFcmTokenRequestEntity bindFcmTokenRequestEntity =
          BindFcmTokenRequestEntity(fcmtoken: fcmToken);

      var result =
          await ChatAPI.bind_fcmtoken(params: bindFcmTokenRequestEntity);

      if (result.code == 0) {
        print("... success updating the fcm token...");
      } else {
        print("... error updating the fcm token");
      }
    }
  }

  void getProfile() async {
    var result = UserStore.to.profile;

    state.head_detail.value = result;
    state.head_detail.refresh();
  }
}
