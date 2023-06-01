import 'package:chatty/common/entities/entities.dart';
import 'package:chatty/common/store/store.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../common/routes/routes.dart';
import 'sign_in_state.dart';

class SignInController extends GetxController {
  SignInController();

  final state = SignInState();

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["openid"]);

  void handleSignIn(String type) async {
    //1->Email 2->Google 3->Facebook 4->Apple 5-> Phone number

    try {
      if (type == "phone number") {
        if (kDebugMode) {
          print('...you are logging in with phone number...');
        }
      } else if (type == "google") {
        var user = await _googleSignIn.signIn();

        if (user != null) {
          String? displayName = user.displayName;
          String email = user.email;
          String id = user.id;
          String photoUrl = user.photoUrl ?? "assets/icons/google.png";

          LoginRequestEntity loginRequestEntity = LoginRequestEntity();
          loginRequestEntity.avatar = photoUrl;
          loginRequestEntity.name = displayName;
          loginRequestEntity.email = email;
          loginRequestEntity.open_id = id;
          loginRequestEntity.type = 2;
          asyncPostAllData();
        }
      } else {
        if (kDebugMode) {
          print('...login type not known');
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print("...error with login $error");
      }
    }
  }

  asyncPostAllData() async {

    /*

    first save in the database 
    second save in the local storage
    */
    UserStore.to.setIsLogin = true;

    Get.offAllNamed(AppRoutes.Message);
  }
}
