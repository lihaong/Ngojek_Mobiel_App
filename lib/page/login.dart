import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../main.dart';
import 'dashboard.dart';
import '../model/user.dart';
import 'register.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Box<UserModel> _myBox;
  late SharedPreferences _prefs;

  final _formKey = GlobalKey<FormState>();
  String _inputUsername = "";
  String _inputPassword = "";
  bool _obscureText = true;

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

  void _submit() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();

      if (!_myBox.containsKey(_inputUsername)) {
        // Check if username exists during login
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid username or password')),
        );
        return;
      }

      final user = _myBox.get(_inputUsername);
      if (_inputPassword == user!.password) {
        // Save user's session
        _prefs.setBool('isLoggedIn', true);
        _prefs.setString('username', _inputUsername);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid username or password')),
        );
      }

    }
  }

  void _register() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Login'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              Image.asset(
                'assets/images/login.jpg',
                height: 220,
              ),
              SizedBox(height: 25.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter a username' : null,
                onSaved: (value) => _inputUsername = value!.toLowerCase(),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter a password' : null,
                onSaved: (value) => _inputPassword = value!,
                obscureText: _obscureText,
              ),
              SizedBox(height: 25.0),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Login'),
              ),
              SizedBox(height: 16.0),
              Center(child: Text("Don't have an account?")),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: _register,
                child: Text('Create Account'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 146, 204, 0),
                ),
              ),
            ],
          ),
        ),


      ),
    );
  }

}
