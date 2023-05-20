import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uastpm/model/pay.dart';
import '../model/user.dart';
import 'package:hive/hive.dart';
import '../main.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Box<UserModel> _myBox;
  late Box<PayModel> _myBoxOrder;

  @override
  void initState() {
    super.initState();
    _openBox();
    // _myBox = Hive.box(boxUser);
    // _myBoxOrder = Hive.box(boxOrder);
  }

  void _openBox() async {
    await Hive.openBox<UserModel>(boxUser);
    _myBox = Hive.box<UserModel>(boxUser);
    await Hive.openBox<PayModel>(boxOrder);
    _myBoxOrder = Hive.box<PayModel>(boxOrder);
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
              // _myBox.close();
              // _myBoxOrder.clear();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyApp(isLoggedIn: false)),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Mapsicle.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                'Hello $Username \n'
                    'Welcome to the Dashboard!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
