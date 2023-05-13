// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uastpm/page/dashboard.dart';
import 'model/user.dart';
import 'page/login.dart';

String boxName = 'userBox';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  String username = prefs.getString('username') ?? '';
  await Hive.initFlutter();
  Hive.registerAdapter<UserModel>(UserModelAdapter());
  await Hive.openBox<UserModel>(boxName);
  runApp(MyApp(isLoggedIn: isLoggedIn, username: username));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String username;
  const MyApp({Key? key, required this.isLoggedIn, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tugas UTS',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
      home: isLoggedIn ? DashboardPage() : const LoginPage(),
    );
  }
}


