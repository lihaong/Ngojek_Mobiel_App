import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'teams.dart';
import 'datetime.dart';
import 'login.dart';
import 'profile.dart';
import '../model/user.dart';
import 'package:hive/hive.dart';
import '../main.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Box<UserModel> _myBox;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _myBox = Hive.box(boxName);
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _myBox.close();
              _prefs.setBool('isLoggedIn', false);
              _prefs.remove('username');
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/profile.png",
                    width: 70,
                  ),
                  SizedBox(height: 10),
                  Text('Profile'),
                ],
              ),
            ),
            SizedBox(height: 30),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NbaTeamsList()),
                );
              },
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/calculator.png',
                    width: 70,
                  ),
                  SizedBox(height: 10),
                  Text('Calculator'),
                ],
              ),
            ),
            SizedBox(height: 30),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarPage()),
                );
              },
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/calendar.png',
                    width: 70,
                  ),
                  SizedBox(height: 10),
                  Text('Date & Time'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
