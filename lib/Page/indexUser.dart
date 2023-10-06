import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tugas_kp/Page/User/dashboardUser.dart';

import '../utils/widget/WAColors.dart';
import 'Admin/dashboardAdmin.dart';
import 'Profile/profile.dart';

class IndexUser extends StatefulWidget {
  final int index;
  const IndexUser(this.index, {Key? key}) : super(key: key);

  @override
  State<IndexUser> createState() => _IndexUserState();
}

class _IndexUserState extends State<IndexUser> {
  int _selectedIndex = 0;
  final List<Widget> _pages = <Widget>[
    const DashboardUser(),
    const Profile(),
  ];


  set(){
    setState(() {
      _selectedIndex = widget.index;
      print(widget.index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.index != null){
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
