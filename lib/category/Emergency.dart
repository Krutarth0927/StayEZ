import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyBellPage extends StatelessWidget {
  const EmergencyBellPage({Key? key}) : super(key: key);

  // Function to open the SMS app with the emergency message
  void sendEmergencyMessage() async {
    const phoneNumber = '+919484776059'; // Replace with the warden/security number
    const emergencyMessage = 'Emergency alert from hostel app. Please respond immediately!';
    final smsUrl = 'sms:$phoneNumber?body=$emergencyMessage';

    if (await canLaunch(smsUrl)) {
      await launch(smsUrl);
    } else {
      throw 'Could not launch $smsUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 35),
                child: Text('Emergency Bell',style: TextStyle(fontWeight: FontWeight.bold),),
              )),
          backgroundColor: Colors.redAccent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Emergency Bell Icon Button
              IconButton(
                icon: Icon(Icons.notifications_active),
                color: Colors.red,
                iconSize: 100,
                onPressed: sendEmergencyMessage, // Send SMS when bell is pressed
              ),
              SizedBox(height: 20),
      
              // Label and description
              Text(
                'Press the bell to send an emergency message to hostel staff.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
      
              // Emergency contact info and call button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Warden:', style: TextStyle(fontSize: 20)),
                      Text('Phone: +91 9484776059', style: TextStyle(fontSize: 24)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text('Security:', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
