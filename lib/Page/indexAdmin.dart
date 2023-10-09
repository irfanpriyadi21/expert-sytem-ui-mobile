import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tugas_kp/Page/Admin/dashboardAdmin.dart';
import 'package:tugas_kp/Page/Profile/profile.dart';

import '../utils/widget/WAColors.dart';


class IndextAdmin extends StatefulWidget {
  final int selectedIndext;
  const IndextAdmin(this.selectedIndext, { Key? key}) : super(key: key);

  @override
  State<IndextAdmin> createState() => _IndextAdminState();
}

class _IndextAdminState extends State<IndextAdmin> {
  int _selectedIndex = 0;
  var _pages = <Widget>[
    DashboardAdmin(),
    Profile(),
  ];

  set(){
    setState(() {
      _selectedIndex = widget.selectedIndext!;
      print(widget.selectedIndext);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.selectedIndext != null){
      set();
    }
  }

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
