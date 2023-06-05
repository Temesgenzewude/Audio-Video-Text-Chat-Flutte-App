import 'dart:convert';

import 'package:chatty/common/apis/apis.dart';
import 'package:chatty/common/entities/entities.dart';
import 'package:chatty/common/store/store.dart';
import 'package:chatty/common/widgets/toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../common/routes/routes.dart';
import '../../../common/utils/utils.dart';
import 'sign_in_state.dart';

class SignInController extends GetxController {
  SignInController();

  final state = SignInState();

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["openid"]);

  void handleSignIn(String type) async {
    //1->Email 2->Google 3->Facebook 4->Apple 5-> Phone number
    print("....signin processing.....");

    try {
      if (type == "phone number") {
        if (kDebugMode) {
          print('...you are logging in with phone number...');
        }
      } else if (type == "google") {
        var user = await _googleSignIn.signIn();

        if (user != null) {
          print("Successfully signedin");
        } else {
          print("Error while signing in");
        }

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
         await asyncPostAllData(loginRequestEntity);
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

  asyncPostAllData(LoginRequestEntity loginRequestEntity) async {
    /*

    first save in the database 
    second save in the local storage
    */
    EasyLoading.show(
        indicator: CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true);
    var result = await UserAPI.Login(params: loginRequestEntity);

    if (result.code == 0) {
      if (kDebugMode) {
        print("...successfully saved user info...");
        print(result.msg);
      }
      await UserStore.to.saveProfile(result.data!);
      EasyLoading.dismiss();
    } else {
      EasyLoading.dismiss();
      toastInfo(msg: result.msg!);
    }

    Get.offAllNamed(AppRoutes.Message);
  }
}
