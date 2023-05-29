import 'package:chatty/common/values/colors.dart';
import 'package:chatty/pages/frame/welcome/welcome_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends GetView<WelcomeController> {
  const ProfilePage({super.key});

// for building the head title of the profile page

  AppBar _buildAppBar() {
    return AppBar(
        title: Text(
      "Profile",
      style: TextStyle(
          color: AppColors.primaryText,
          fontSize: 16.sp,
          fontWeight: FontWeight.normal),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: SafeArea(child: CustomScrollView(slivers: []),));
  }
}
