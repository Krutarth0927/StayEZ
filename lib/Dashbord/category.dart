import 'package:flutter/material.dart';
import 'package:stayez/Dashbord/roomBooking.dart';
import 'package:stayez/admindash/room/roomallocation.dart';
import 'package:stayez/category/Emergency.dart';
import 'package:stayez/category/Servicesstudent.dart';
import 'package:stayez/category/complint/complint.dart';
import 'package:stayez/category/daily%20register/register_form.dart';
import 'package:stayez/category/dialyupdate.dart';
import 'package:stayez/category/rules.dart';
import 'package:stayez/category/staffmember.dart';
import 'package:stayez/login(Admin)/login.dart';
import 'package:stayez/student(register)/login.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<Room> rooms = [];

  // @override
  // void initState() {
  //   super.initState();
  //   _loadRooms();
  // }
  // Handle click events here
  void onCategoryClick(BuildContext context, Widget? page) {
    if (page != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
    }
  }

  // get room => null;
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        'icon': Image.asset(
          'assets/playscreen/report.png',
          height: 40,
          width: 40,
        ),
        'label': 'Complaint Box',
        'page': ComplaintBoxScreen(),
      },
      {
        'icon': const Icon(Icons.login, size: 40, color: Colors.black),
        'label': 'Student Login',
        'page': LoginPage(),
      },
      {
        'icon': const Icon(Icons.schedule, size: 40, color: Colors.black),
        'label': 'Daily Register',
        'page': DailyRegisterForm(),
      },
      {
        'icon': const Icon(Icons.payments, size: 40, color: Colors.black),
        'label': 'Fees Payments',
      },
      {
        'icon': const Icon(Icons.meeting_room, size: 40, color: Colors.black),
        'label': 'Room Booking',
        'page': StudentPage()
      },
      {
        'icon': const Icon(Icons.group, size: 40, color: Colors.black),
        'label': 'Staff Member',
        'page' : StaffPage()
      },
      {
        'icon': const Icon(Icons.rule, size: 40, color: Colors.black),
        'label': 'Rules',
        'page' : HostelRulesPage()
      },
      {
        'icon': const Icon(Icons.update, size: 40, color: Colors.black),
        'label': 'Daily Update',
        'page': Update()
      },
      {
        'icon': const Icon(Icons.miscellaneous_services,
            size: 40, color: Colors.black),
        'label': 'Services',
        'page' : servicespro()
      },
      {
        'icon': Image.asset(
          'assets/playscreen/administrator.png',
          height: 40,
          width: 40,
        ),
        'label': 'Admin',
        'page': Login(),
      },
      {
        'icon': Image.asset(
          'assets/playscreen/bell.png',
          height: 40,
          width: 40,
        ),
        'label': 'Emergency Bell',
        'page' : EmergencyBellPage()
      },
    ];

    // final Room room;
    // Example Room Data
    // final List<Room> rooms;
    //
    // List of category items with icon and label

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFE7E8D1),
        body: Column(
          children: [
            // Gradient background title
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Color(0xFFA7BEAE)),
              child: const Center(
                child: Text(
                  'Category',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            // Grid view for categories
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 10, left: 20, right: 20),
                child: GridView.builder(
                  itemCount: items.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Three items per row
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio:
                        0.80, // Decreased aspect ratio to make cards taller
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        final page = items[index]['page'];
                        onCategoryClick(context, page);
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFA7BEAE)
                            // // gradient: LinearGradient(
                            // //   colors: [Colors.green.shade300, Colors.blue.shade600],
                            // //   begin: Alignment.topLeft,
                            // //   end: Alignment.bottomRight,
                            // ),
                            ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            items[index]['icon'],
                            const SizedBox(height: 10),
                            Text(
                              items[index]['label'],
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
