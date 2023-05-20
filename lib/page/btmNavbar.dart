import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'profile.dart';
import 'maps.dart';
class BtmNavBar extends StatefulWidget {
  const BtmNavBar({Key? key}) : super(key: key);

  @override
  State<BtmNavBar> createState() => _BtmNavBarState();
}

class _BtmNavBarState extends State<BtmNavBar> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = [
      Dashboard(),
      MapsPage(), // Add MapsPage widget here
      ProfilePage(),
    ];

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onItemTapped,
        children: _widgetOptions,
      ),
      bottomNavigationBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: BottomNavigationBar(
          backgroundColor: Color(0xFF191825),
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFF865DFF),
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard, size: 30),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map, size: 30),
              label: 'Maps',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 30),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

