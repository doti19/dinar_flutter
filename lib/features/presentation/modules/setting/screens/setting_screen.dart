import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dinar/features/presentation/global_widgets/my_appbar.dart';
import 'package:dinar/features/presentation/modules/setting/setting_controller.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  final SettingController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: "Setting"),
      body: const Center(
        child: Text('Setting Screen'),
      ),
    );
  }
}
