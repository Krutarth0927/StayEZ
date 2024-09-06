import 'package:flutter/material.dart';
import 'package:stayez/admindash/adminservices.dart';
import 'package:stayez/admindash/complint.dart';
import 'package:stayez/admindash/insruction/insruction.dart';
import 'package:stayez/admindash/register.dart';
import 'package:stayez/admindash/room/roomallocation.dart';
import 'package:stayez/color.dart';
import 'package:stayez/custom_naviation.dart';
import 'package:stayez/student(register)/profile.dart';
import '../student(register)/database.dart';
import 'Staffmember.dart';

class AdiminDash extends StatefulWidget {
  const AdiminDash({super.key});

  @override
  State<AdiminDash> createState() => _AdiminDashState();
}

class _AdiminDashState extends State<AdiminDash> {
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
            child: Text('Admin DashBoard'),
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
                          builder: (context) =>  AdminStaffMemberPage()));
                  // // Handle contact navigation
                  // // Close the drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.miscellaneous_services),
                title: Text('Services Provide'),
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>  AdminServicesMemberPage()));
                  // // Handle contact navigation
                  // // Close the drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Log Out'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NavigationMenu()));
                  // Handle contact navigation
                  // Close the drawer
                },
              ),
            ],
          ),
        ),
        body: Center(
          child: Text('Swipe or tap the icon to open the drawer.'),
        ),
      ),
    );
  }
}

class Student extends StatefulWidget {
  const Student({super.key});

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
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
                                    ProfilePage(userId: user['id']),
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
    _loadUserData();
  }

  void _loadUserData() async {
    DatabaseHelper dbClient = DatabaseHelper();
    final user = await dbClient.getUser1(widget.userId);
    setState(() {
      _userData = user;
    });
  }

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
