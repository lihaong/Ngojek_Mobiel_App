import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uastpm/model/pay.dart';
import 'model/user.dart';
import 'page/login.dart';
import 'package:uastpm/page/btmNavbar.dart';

String boxUser = 'userBox';
String boxOrder = 'boxOrder';
String Username = '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  await Hive.initFlutter();
  Hive.registerAdapter<UserModel>(UserModelAdapter());
  Hive.registerAdapter<PayModel>(PayModelAdapter()); // Register the OrderModel adapter
  await Hive.openBox<PayModel>(boxOrder);
  await Hive.openBox<UserModel>(boxUser);

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UAS TPM',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: getTimeZoneThemeMode(),
      home: isLoggedIn ? BtmNavBar() : const LoginPage(),
    );
  }

  ThemeMode getTimeZoneThemeMode() {
    final DateTime now = DateTime.now().toUtc().add(Duration(hours: 0));
    final int currentHour = now.hour;

    // Adjust the hour range based on the desired time for dark mode
    // In this example, dark mode is enabled from 6 PM (18) to 6 AM (6)
    if (currentHour >= 18 || currentHour < 6) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }
}
