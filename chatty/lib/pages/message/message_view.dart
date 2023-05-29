import 'package:chatty/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'message_index.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({super.key});

  // silvers are used inside listviews  and are built lazily and are good for performance
  // Are generally used under CustomScrollView

  Widget _headBar() {
    return Center(
        child: Container(
            width: 320.w,
            height: 44.w,
            margin: EdgeInsets.only(
              bottom: 20.h,
              top: 20.h,
            ),
            child: Row(
              children: [
                Stack(
                  children: [
                    GestureDetector(
                      child: Container(
                        width: 44.h,
                        height: 44.h,
                        decoration: BoxDecoration(
                            color: AppColors.primarySecondaryBackground,
                            borderRadius: BorderRadius.all(
                              (Radius.circular(22.h)),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.red.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 1))
                            ]),
                        child: controller.state.head_detail.value.avatar == null
                            ? Image(
                                image: AssetImage(
                                    "assets/images/account_header.png"),
                              )
                            : Text("Hi"),
                      ),
                    )
                  ],
                )
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
        CustomScrollView(
          slivers: [
            SliverAppBar(
              title: _headBar(),
              pinned: true,
            )
          ],
        )
      ]),
    ));
  }
}
