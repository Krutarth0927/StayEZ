import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stayez/admindash/adminservices.dart';
import 'package:stayez/admindash/complint.dart';
import 'package:stayez/admindash/insruction/insruction.dart';
import 'package:stayez/admindash/register.dart';
import 'package:stayez/admindash/room/roomallocation.dart';
import 'package:stayez/color.dart';
import 'package:stayez/custom_naviation.dart';
import 'package:stayez/student(register)/profile.dart';
import '../splashscrren.dart';
import '../student(register)/database.dart';
import 'Staffmember.dart';

class AdiminDash extends StatefulWidget {
  const AdiminDash({super.key});

  @override
  State<AdiminDash> createState() => _AdiminDashState();
}

class _AdiminDashState extends State<AdiminDash> {
  int totalRooms = 0;
  int availableRooms = 0;
  int unavailableRooms = 0;

  @override
  void initState() {
    super.initState();
    _fetchRoomCounts();
  }

  Future<void> _fetchRoomCounts() async {
    // Assuming you have a method to load rooms from shared preferences or the database
    final prefs = await SharedPreferences.getInstance();
    final String? roomsJson = prefs.getString('rooms');
    if (roomsJson != null) {
      final List<dynamic> decoded = jsonDecode(roomsJson);
      final rooms = decoded.map((room) => Room.fromJson(room)).toList();

      setState(() {
        totalRooms = rooms.length;
        availableRooms = rooms.where((room) => room.isAvailable).length;
        unavailableRooms = rooms.where((room) => !room.isAvailable).length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: accentColor,
          title: Center(
              child: Padding(
            padding: const EdgeInsets.only(right: 35),
            child: Text(
              'Admin DashBoard',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )),
        ),
        drawer: Drawer(
          backgroundColor: backgroundColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: accentColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Text(
                    'StayEZ',
                    style: TextStyle(
                      color: black,
                      fontSize: 44,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.school),
                title: Text('Students Details'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Student())); // Close the drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.room),
                title: Text('Room Details'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AdminRoomManagementPage())); // Close the drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.app_registration),
                title: Text('Register Entry'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Register())); // Close the drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.comment),
                title: Text('Complaint Details'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminComplaintView()));
                },
              ),
              ListTile(
                leading: Icon(Icons.inbox),
                title: Text('Admin Insruction'),
                onTap: () {
                  // Handle contact navigation
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AdminPage())); // Close the drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.person_2),
                title: Text('Staff Member'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminStaffMemberPage()));
                  // // Handle contact navigation
                  // // Close the drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.miscellaneous_services),
                title: Text('Services Provide'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminServiceProviderPage()));
                  // // Handle contact navigation
                  // // Close the drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Log Out'),
                onTap: () {
                  _logout(context);
                  // Handle contact navigation
                  // Close the drawer
                },
              ),
            ],
          ),
        ),
        body: FutureBuilder<int>(
          future: _fetchRecordCount(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == 0) {
              return Center(child: Text('No records found'));
            }

            final studentRecordCount = snapshot.data!;

            return Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 110, top: 20),
                    child: Card(
                      elevation: 5,
                      color: accentColor, // Set transparent background
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side:
                            BorderSide(), // Black border
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Total Student Records: $studentRecordCount',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color:
                                black, // Set text color to black for contrast
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                FutureBuilder<List<Room>>(
                  future: _fetchRooms(),
                  builder: (context, roomSnapshot) {
                    if (roomSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (roomSnapshot.hasError) {
                      return Center(
                          child: Text('Error: ${roomSnapshot.error}'));
                    } else if (!roomSnapshot.hasData ||
                        roomSnapshot.data!.isEmpty) {
                      return Center(child: Text('No rooms found'));
                    }

                    final rooms = roomSnapshot.data!;
                    final totalRooms = rooms.length;
                    final availableRooms =
                        rooms.where((room) => room.isAvailable).length;
                    final unavailableRooms = totalRooms - availableRooms;

                    // Grid view with 2x2 layout
                    return Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(10.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 columns
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio:
                              2, // Adjust the aspect ratio as needed
                        ),
                        itemCount: 3, // For the three types of cards
                        itemBuilder: (context, index) {
                          String title;
                          String value;
                          switch (index) {
                            case 0:
                              title = 'Total Rooms';
                              value = totalRooms.toString();
                              break;
                            case 1:
                              title = 'Available Rooms';
                              value = availableRooms.toString();
                              break;
                            case 2:
                              title = 'Unavailable Rooms';
                              value = unavailableRooms.toString();
                              break;
                            default:
                              title = '';
                              value = '';
                          }

                          return Card(
                            elevation: 5,
                            color: accentColor, // Transparent background
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                  ), // Black border
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Center(
                                child: Text(
                                  '$title: $value',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }


  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    prefs1.setBool('isLoggedIn', false);
    prefs1.setBool('isAdmin', false);
    prefs1.setString('userId',""); // Store userId as a String

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SplashScreen()), // Navigate to SecondPage
    );

  }

  Future<int> _fetchRecordCount() async {
    DatabaseHelper db = DatabaseHelper();
    final users = await db.getAllUsers();
    return users.length;
  }

  Future<List<Room>> _fetchRooms() async {
    final prefs = await SharedPreferences.getInstance();
    final String? roomsJson = prefs.getString('rooms');
    if (roomsJson != null) {
      final List<dynamic> decoded = jsonDecode(roomsJson);
      return decoded.map((room) => Room.fromJson(room)).toList();
    }
    return [];
  }
}

class Student extends StatefulWidget {
  const Student({super.key});

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
  late Future<List<Map<String, dynamic>>> _usersFuture;
  int recordCount = 0;

  @override
  void initState() {
    super.initState();
    _usersFuture = _fetchAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: accentColor,
          title: Center(
              child: Padding(
            padding: const EdgeInsets.only(right: 35),
            child: Text(
              'Student Details',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )),
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: _fetchAllUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No users found'));
            }

            final users = snapshot.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Full Name')),
                  DataColumn(label: Text('Mobile Number')),
                  DataColumn(label: Text('College Name')),
                  DataColumn(label: Text('Category')),
                  DataColumn(label: Text('Course')),
                  DataColumn(label: Text('Year of Study')),
                  DataColumn(label: Text('Password')),
                  DataColumn(label: Text('Profile')),
                  DataColumn(label: Text('Update')), // Update button column
                  DataColumn(label: Text('Delete')), // Delete button column
                ],
                rows: users.map((user) {
                  return DataRow(
                    cells: [
                      DataCell(Text(user['id'].toString())),
                      DataCell(Text(user['fullName'] ?? 'N/A')),
                      DataCell(Text(user['mobileNo'] ?? 'N/A')),
                      DataCell(Text(user['collageName'] ?? 'N/A')),
                      DataCell(Text(user['category'] ?? 'N/A')),
                      DataCell(Text(user['currentCourse'] ?? 'N/A')),
                      DataCell(Text(user['yearOfStudy'] ?? 'N/A')),
                      DataCell(Text(user['password'] ?? 'N/A')),
                      DataCell(
                        IconButton(
                          icon: Icon(Icons.person),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProfilePage(),
                              ),
                            );
                          },
                        ),
                      ),
                      DataCell(
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UpdateUserPage(userId: user['id']),
                              ),
                            ).then((value) {
                              setState(
                                  () {}); // Refresh the page when coming back
                            });
                          },
                          child: Text('Update', style: TextStyle(color: black)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                          ),
                        ),
                      ),
                      DataCell(
                        ElevatedButton(
                          onPressed: () async {
                            bool? confirm = await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Confirm Delete'),
                                  content: Text(
                                      'Are you sure you want to delete this user?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            );

                            if (confirm == true) {
                              DatabaseHelper db = DatabaseHelper();
                              await db.deleteUser(user['id']);
                              setState(() {}); // Refresh the table
                            }
                          },
                          child: Text('Delete', style: TextStyle(color: black)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor, // Button color
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _fetchAllUsers() async {
    DatabaseHelper db = DatabaseHelper();
    return await db.getAllUsers();
  }
}

class UpdateUserPage extends StatefulWidget {
  final int userId;

  const UpdateUserPage({required this.userId, Key? key}) : super(key: key);

  @override
  _UpdateUserPageState createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _userData = {};

  @override
  void initState() {
    super.initState();
    // _loadUserData();
  }

  // void _loadUserData() async {
  //   DatabaseHelper dbClient = DatabaseHelper();
  //   final user = await dbClient.getUserProfile;
  //   setState(() {
  //     _userData = _userData;
  //   });
  // }


  void _updateUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      DatabaseHelper db = DatabaseHelper();
      await db.updateUser(widget.userId, _userData);

      Navigator.pop(context); // Go back to the previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: accentColor,
        title: Text('Update User'),
      ),
      body: _userData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  TextFormField(
                    initialValue: _userData['fullName'],
                    decoration: InputDecoration(labelText: 'Full Name'),
                    onSaved: (value) {
                      _userData['fullName'] = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a full name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: _userData['mobileNo'],
                    decoration: InputDecoration(labelText: 'Mobile Number'),
                    onSaved: (value) {
                      _userData['mobileNo'] = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a mobile number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: _userData['collageName'],
                    decoration: InputDecoration(labelText: 'College Name'),
                    onSaved: (value) {
                      _userData['collageName'] = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a college name';
                      }
                      return null;
                    },
                  ),
                  // Add more fields as necessary...

                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _updateUser,
                    child: Text('Update'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      textStyle: TextStyle(color: black),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
