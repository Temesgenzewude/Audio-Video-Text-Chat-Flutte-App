import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chatty/common/widgets/widgets.dart';
import 'contact_index.dart';
import 'contact_widgets/contact_widgets.dart';
import 'package:chatty/common/values/values.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactPage extends GetView<ContactController> {
  // AppBar _buildAppBar() {
  //   return AppBar(
  //     // backgroundColor: Colors.transparent,
  //     // elevation: 0,
  //       title: Text(
  //         "Contact",
  //         style: TextStyle(
  //           color: AppColors.primaryText,
  //           fontSize: 16.sp,
  //           fontWeight: FontWeight.normal,
  //         ),
  //       ));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text("Contact Page")),
      ),

      // appBar: _buildAppBar(),
      // body: ContactList(),
    );
  }
}
