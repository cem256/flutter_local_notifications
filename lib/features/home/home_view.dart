import 'package:flutter/material.dart';
import 'package:flutter_local_notification/product/constants/string_constants.dart';

import '../../core/extension/contex_extension.dart';
import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConstants.appName),
      ),
      body: Padding(
        padding: context.paddingAllDefault,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomElevatedButton(
              label: "Insant Notification",
              onPressed: () async {
                if (await HomeViewModel().showNotification()) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text("Insant notification created successfully")));
                }
              },
            ),
            CustomElevatedButton(
              label: "Schedule Notification",
              onPressed: () async {
                if (await HomeViewModel().showScheduledNotification()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Scheduled notification set to trigger in 5 seconds")));
                }
              },
            ),
            CustomElevatedButton(
              label: "Cancel Notifications",
              onPressed: () async {
                if (await HomeViewModel().cancelAllNotifications()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("All notifications cancelled successfuly"),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    this.onPressed,
    this.label,
  }) : super(key: key);

  final void Function()? onPressed;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text(label ?? ""),
          ),
        ),
      ],
    );
  }
}
