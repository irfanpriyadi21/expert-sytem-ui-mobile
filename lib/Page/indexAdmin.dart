import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tugas_kp/Page/Admin/dashboardAdmin.dart';
import 'package:tugas_kp/Page/Profile/profile.dart';

import '../utils/widget/WAColors.dart';


class IndextAdmin extends StatefulWidget {
  const IndextAdmin({Key? key}) : super(key: key);

  @override
  State<IndextAdmin> createState() => _IndextAdminState();
}

class _IndextAdminState extends State<IndextAdmin> {
  int _selectedIndex = 0;
  var _pages = <Widget>[
    DashboardAdmin(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          backgroundColor: context.cardColor,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: WAPrimaryColor,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
