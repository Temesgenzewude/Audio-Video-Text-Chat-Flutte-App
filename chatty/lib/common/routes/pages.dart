import 'package:chatty/pages/frame/welcome/welcome_index.dart';
import 'package:flutter/material.dart';
import 'package:chatty/common/middlewares/middlewares.dart';

import 'package:get/get.dart';

import '../../pages/contact/contact_index.dart';
import '../../pages/frame/signin/sign_in_index.dart';
import '../../pages/message/chat/chat_index.dart';
import '../../pages/message/message_index.dart';

import '../../pages/profile_pages/profile_index.dart';
import 'routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [
    // about boot up the app
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => const WelcomePage(),
      binding: WelcomeBinding(),
    ),

    //sing in page
    GetPage(
      name: AppRoutes.SIGN_IN,
      page: () => const SignInPage(),
      binding: SignInBinding(),
    ),

    /*

    // 需要登录
    // GetPage(
    //   name: AppRoutes.Application,
    //   page: () => ApplicationPage(),
    //   binding: ApplicationBinding(),
    //   middlewares: [
    //     RouteAuthMiddleware(priority: 1),
    //   ],
    // ),

    // 最新路由
    GetPage(name: AppRoutes.EmailLogin, page: () => EmailLoginPage(), binding: EmailLoginBinding()),
    GetPage(name: AppRoutes.Register, page: () => RegisterPage(), binding: RegisterBinding()),
    GetPage(name: AppRoutes.Forgot, page: () => ForgotPage(), binding: ForgotBinding()),
    GetPage(name: AppRoutes.Phone, page: () => PhonePage(), binding: PhoneBinding()),
    GetPage(name: AppRoutes.SendCode, page: () => SendCodePage(), binding: SendCodeBinding()),
    // 首页
    */
    // contact page
    GetPage(name: AppRoutes.Contact, 
    page: () => ContactPage(),
     binding: ContactBinding()),
    
    
    // message page
    GetPage(
      name: AppRoutes.Message,
      page: () => const MessagePage(),
      binding: MessageBinding(),
      middlewares: [
        RouteAuthMiddleware(priority: 1),
      ],
    ),

    // Profile page
    GetPage(
        name: AppRoutes.Profile,
        page: () => const ProfilePage(),
        binding: ProfileBinding()),
    
    //chat page
    GetPage(name: AppRoutes.Chat, page: () => ChatPage(), binding: ChatBinding()),

   /* GetPage(name: AppRoutes.Photoimgview, page: () => PhotoImgViewPage(), binding: PhotoImgViewBinding()),
    GetPage(name: AppRoutes.VoiceCall, page: () => VoiceCallViewPage(), binding: VoiceCallViewBinding()),
    GetPage(name: AppRoutes.VideoCall, page: () => VideoCallPage(), binding: VideoCallBinding()),*/
  ];
}
