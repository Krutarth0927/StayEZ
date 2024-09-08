import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stayez/color.dart';
import 'package:stayez/student(register)/database.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? mobileno;
  String? userId;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the userId and isLoggedIn status
    setState(() {
      userId = prefs.getString('userId'); // Retrieve userId as a String
      mobileno = userId; // Assign userId to mobileno only after it's loaded
      print("--------------------");
      print(userId);
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false; // Retrieve login status
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: accentColor,
          title: Center(
            child: Text(
              'Profile',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: mobileno == null
            ? Center(child: CircularProgressIndicator()) // Show a loader while data is loading
            : FutureBuilder<Map<String, dynamic>?>(
          future: DatabaseHelper().getUser(mobileno!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData && snapshot.data != null) {
              Map<String, dynamic> user = snapshot.data!;

              // Create TextEditingControllers with initial values
              final fullNameController =
              TextEditingController(text: user['fullName']);
              final dobController =
              TextEditingController(text: user['dob']);
              final mobileNoController =
              TextEditingController(text: user['mobileNo']);
              final addressController =
              TextEditingController(text: user['address']);
              final collageNameController =
              TextEditingController(text: user['collageName']);
              final nationalityController =
              TextEditingController(text: user['nationality']);
              final religionController =
              TextEditingController(text: user['religion']);
              final categoryController =
              TextEditingController(text: user['category']);
              final currentCourseController =
              TextEditingController(text: user['currentCourse']);
              final yearOfStudyController =
              TextEditingController(text: user['yearOfStudy']);
              final parentNameController =
              TextEditingController(text: user['parentName']);
              final parentContactNoController =
              TextEditingController(text: user['parentContactNo']);

              return SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildTextField('Full Name', fullNameController),
                    _buildTextField('Date of Birth', dobController),
                    _buildTextField('Mobile Number', mobileNoController),
                    _buildTextField('Address', addressController),
                    _buildTextField('College Name', collageNameController),
                    _buildTextField('Nationality', nationalityController),
                    _buildTextField('Religion', religionController),
                    _buildTextField('Category', categoryController),
                    _buildTextField('Current Course', currentCourseController),
                    _buildTextField('Year of Study', yearOfStudyController),
                    _buildTextField("Parent's Name", parentNameController),
                    _buildTextField(
                        "Parent's Contact Number", parentContactNoController),
                  ],
                ),
              );
            }

            return Center(child: Text('No data found'));
          },
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
