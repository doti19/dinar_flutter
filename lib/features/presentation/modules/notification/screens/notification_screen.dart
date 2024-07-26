import 'package:flutter/material.dart';
import 'package:dinar/features/presentation/global_widgets/my_appbar.dart';
import 'package:dinar/features/presentation/modules/notification/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final NotificationController controller = NotificationController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: "Notification"),
      body: const Center(
        child: Text('Notification Screen'),
      ),
    );
  }
}
