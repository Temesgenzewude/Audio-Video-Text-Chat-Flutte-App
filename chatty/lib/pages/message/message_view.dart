import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'message_index.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({super.key});

  // silvers are used inside listviews  and are built lazily and are good for performance
  // Are generally used under CustomScrollView

  Widget _headBar() {
    return Center();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
        CustomScrollView(
          slivers: [],
        )
      ]),
    ));
  }
}
