import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage('assets/images/fajar.jpg'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Muhammad Fajar Andikha',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Kelas : IF - A',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'NIM : 123200054',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16.0),
            Divider(),
            ListTile(
              leading: Icon(Icons.menu_open_rounded),
              title: Text('Detail'),
              trailing: Icon(Icons.arrow_drop_down),
              onTap: () {
                showDetail(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void showDetail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.cake),
              title: Text('Magelang, 9 Juli 2000'),
            ),
            ListTile(
              leading: Icon(Icons.library_books),
              title: Text('Cita-Cita Bekerja di Google'),
            ),
          ],
        );
      },
    );
  }
}
