import 'package:stayez/Dashbord/category.dart';
import 'color.dart';
import 'package:stayez/Dashbord/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:stayez/student(register)/profile.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key,required});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _SelectedIndex=0;

  void _navigationBottomBar(int index){
    setState(() {
      _SelectedIndex=index;

    });
  }

  final List _pages =[

    Homepage(),
    Category(),
    ProfilePage(userId: 1),


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: backgroundColor ,
      body: _pages[_SelectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40, left: 20, right: 20),
        child: Container(
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(50),
              bottomRight: Radius.circular(50),
              bottomLeft: Radius.circular(50),
            ),
            boxShadow: const [
              BoxShadow(
                color: black12,
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: trans,
            elevation: 0,
            selectedItemColor: white,
            unselectedItemColor: black,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: _SelectedIndex,
            onTap: _navigationBottomBar,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.category,

                ),
                label: 'Category',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
