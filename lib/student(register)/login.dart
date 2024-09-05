import 'package:flutter/material.dart';
import 'package:stayez/color.dart';
import 'package:stayez/student(register)/database.dart';
import 'package:stayez/student(register)/profile.dart';
import 'package:stayez/student(register)/register.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      String phone = phoneController.text;
      String password = passwordController.text;

      DatabaseHelper db = DatabaseHelper();
      Map<String, dynamic>? user =
          await db.getUserByPhoneAndPassword(phone, password);

      // String studentName = 'John Doe'; // Replace with actual student's name
      //
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => Homepage(studentName: studentName),
      //     ));

      if (user != null) {
        // If user is found, navigate to the ProfilePage with the userId
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(userId: user['id']),
          ),
        );
      } else {
        // Show an error message if the credentials don't match
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid phone number or password')),
        );
      }
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
              padding: const EdgeInsets.only(right: 35.0),
              child: Text(
                'Login',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ))),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: _login,
                    child: Text(
                      'Login',
                      style: TextStyle(color: black, fontSize: 20),
                    ),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: buttonColor)),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: black),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          color: buttonColor,
                          fontSize: 15,
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
      ),
    );
  }
}
