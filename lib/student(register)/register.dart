import 'package:flutter/material.dart';
import 'package:stayez/color.dart';
// import 'package:intl/intl.dart';
// import 'package:stayez/Dashbord/Homepage.dart';
import 'package:stayez/student(register)/database.dart';
import 'package:stayez/student(register)/login.dart';
import 'package:stayez/student(register)/profile.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegistrationForm(),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  // Using TextEditingController to manage text fields
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  DateTime? dob;
  String? mobileNo;
  String? address;
  String? collageName;
  String? nationality;
  String? religion;
  String? category;
  String? currentCourse;
  String? yearOfStudy;
  String? parentName;
  String? parentContactNo;

  final List<String> categories = ['General', 'OBC', 'SC', 'ST'];
  final List<String> courses = ['B.Sc', 'B.Tech', 'M.Sc', 'M.Tech'];
  final List<String> religions = ['Hindu', 'Muslim', 'Christian', 'Other'];

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Map<String, dynamic> user = {
        'fullName': fullNameController.text,
        'dob': dob?.toIso8601String(),
        'mobileNo': mobileNo,
        'address': address,
        'collageName': collageName,
        'nationality': nationality,
        'religion': religion,
        'category': category,
        'currentCourse': currentCourse,
        'yearOfStudy': yearOfStudy,
        'parentName': parentName,
        'parentContactNo': parentContactNo,
        'password': passwordController.text,
      };

      DatabaseHelper db = DatabaseHelper();
      int userId = await db.saveUser(user); // Save and get the inserted ID

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => Homepage(fullName: fullNameController.text),
      //   ),
      // );
      // Navigate to Profile Page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(userId: userId),
        ),
      );
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
                  'Student Sign-Up',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      controller: fullNameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );

                        if (picked != null) {
                          setState(() {
                            dob = picked;
                          });
                        }
                      },
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Date of Birth',
                          prefixIcon: Icon(Icons.calendar_today),
                          border: OutlineInputBorder(),
                        ),
                        child: dob == null
                            ? Text('Select Date of Birth')
                            : Text(
                                '${dob!.day}/${dob!.month}/${dob!.year}',
                              ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Mobile Number',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                      onSaved: (value) {
                        mobileNo = value;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Address',
                        prefixIcon: Icon(Icons.home),
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value) {
                        address = value;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'College Name',
                        prefixIcon: Icon(Icons.school),
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value) {
                        collageName = value;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Nationality',
                        prefixIcon: Icon(Icons.flag),
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value) {
                        nationality = value;
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Religion',
                              border: OutlineInputBorder(),
                            ),
                            items: religions.map((String religion) {
                              return DropdownMenuItem<String>(
                                value: religion,
                                child: Text(religion),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                religion = newValue;
                              });
                            },
                            onSaved: (value) {
                              religion = value;
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Category',
                              border: OutlineInputBorder(),
                            ),
                            items: categories.map((String category) {
                              return DropdownMenuItem<String>(
                                value: category,
                                child: Text(category),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                category = newValue;
                              });
                            },
                            onSaved: (value) {
                              category = value;
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Current Course',
                              border: OutlineInputBorder(),
                            ),
                            items: courses.map((String course) {
                              return DropdownMenuItem<String>(
                                value: course,
                                child: Text(course),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                currentCourse = newValue;
                              });
                            },
                            onSaved: (value) {
                              currentCourse = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Year of Study',
                        prefixIcon: Icon(Icons.timeline),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        yearOfStudy = value;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Parent's Name",
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value) {
                        parentName = value;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Parent's Contact Number",
                        prefixIcon: Icon(Icons.phone_in_talk),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                      onSaved: (value) {
                        parentContactNo = value;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Set Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: _saveForm,
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: black),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor)),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(color: black),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: buttonColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
