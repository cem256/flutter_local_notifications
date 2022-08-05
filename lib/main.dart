import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'features/home/home_view.dart';
import 'product/constants/string_constants.dart';
import 'product/init/local_notifications_init.dart';
import 'product/theme/product_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();
  await LocalNotificationsInit().initializeLocalNotifications();

  runApp(const FlutterLocalNotifications());
}

class FlutterLocalNotifications extends StatelessWidget {
  const FlutterLocalNotifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ProductTheme.theme,
        title: StringConstants.appName,
        home: const HomeView());
  }
}
