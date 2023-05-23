import 'package:chatty/common/services/services.dart';
import 'package:chatty/common/store/user.dart';
import 'package:chatty/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/*
Difference between put, lazyput and putAsync:
->put: with put we inject the controller which will be always in the memory and  ready to be used
      It's very fast and quick because everything will be ready immediately
->lazyput: the instance of the controller will be created whenever you call the controller
            :the controller gets initialized when you need to use it
-> putAsync: used to load data the will be available in the future

*/

class Global {
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await Get.putAsync<StorageService>(() => StorageService().init());

    Get.put<UserStore>(UserStore());
    
  }
}
