import 'package:chatty/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'sign_in_index.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});

  // Widget _buildLogo() {
  //   return Container(
  //     margin: EdgeInsets.only(top: 100.h, bottom: 80.h),
  //     child: Text(
  //       "Chatty .",
  //       textAlign: TextAlign.center,
  //       style: TextStyle(
  //         color: AppColors.primaryText,
  //         fontWeight: FontWeight.bold,
  //         fontSize: 34.sp,
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildThirdPartyLogin(String loginType, String logo) {
  //   return GestureDetector(
  //     onTap: () {
  //       controller.handleSignIn("google");
  //     },
  //     child: Container(
  //       width: 295.w,
  //       height: 44.h,
  //       padding: EdgeInsets.all(10.h),
  //       margin: EdgeInsets.only(bottom: 15.h),
  //       decoration: BoxDecoration(
  //           color: AppColors.primaryBackground,
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(5.h),
  //           ),
  //           boxShadow: [
  //             BoxShadow(
  //                 color: Colors.grey.withOpacity(0.1),
  //                 spreadRadius: 1,
  //                 blurRadius: 2,
  //                 offset: const Offset(0, 1)),
  //           ]),
  //       child: Row(
  //           mainAxisAlignment: logo.isEmpty
  //               ? MainAxisAlignment.center
  //               : MainAxisAlignment.start,
  //           children: [
  //             logo.isEmpty
  //                 ? Container()
  //                 : Container(
  //                     padding: EdgeInsets.only(left: 40.w, right: 30.w),
  //                     child: Image.asset("assets/icons/$logo.png"),
  //                   ),
  //             Container(
  //               child: Text(
  //                 "Sign In with $loginType",
  //                 style: TextStyle(
  //                   color: AppColors.primaryText,
  //                   fontWeight: FontWeight.normal,
  //                   fontSize: 14.sp,
  //                 ),
  //               ),
  //             )
  //           ]),
  //     ),
  //   );
  // }

  // Widget _buildOrWidget() {
  //   return Container(
  //     margin: EdgeInsets.only(top: 20.h, bottom: 35.h),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: Divider(
  //             indent: 50,
  //             height: 2.h,
  //             color: AppColors.primarySecondaryElementText,
  //           ),
  //         ),
  //         const Text("  or  "),
  //         Expanded(
  //           child: Divider(
  //             endIndent: 50,
  //             height: 2.h,
  //             color: AppColors.primarySecondaryElementText,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildSignInWidget() {
  //   return Column(
  //     children: [
  //       Text(
  //         "Already have an account?",
  //         textAlign: TextAlign.center,
  //         style: TextStyle(
  //           color: AppColors.primaryText,
  //           fontWeight: FontWeight.normal,
  //           fontSize: 12.sp,
  //         ),
  //       ),
  //       GestureDetector(
  //         onTap: () {},
  //         child: Text(
  //           "Sign In Here",
  //           textAlign: TextAlign.center,
  //           style: TextStyle(
  //             color: AppColors.primaryElement,
  //             fontWeight: FontWeight.normal,
  //             fontSize: 12.sp,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.primarySecondaryBackground,
      // body: Center(
      //   child: Column(
      //     children: [
      //       _buildLogo(),
      //       _buildThirdPartyLogin("Google", "google"),
      //       _buildThirdPartyLogin("Facebook", "facebook"),
      //       _buildThirdPartyLogin("Apple", "apple"),
      //       _buildOrWidget(),
      //       _buildThirdPartyLogin("phone number", ""),
      //       SizedBox(
      //         height: 30.h,
      //       ),
      //       _buildSignInWidget(),
      //     ],
      //   ),
      // ),
    );
  }
}

