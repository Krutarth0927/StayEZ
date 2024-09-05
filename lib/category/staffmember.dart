import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HostelStaffPage extends StatelessWidget {
  final List<Map<String, String>> staffMembers = [
    {'name': 'Warden', 'role': 'Overall Management', 'phone': '1234567890'},
    {'name': 'Assistant Warden', 'role': 'Assists Warden', 'phone': '0987654321'},
    {'name': 'Caretaker', 'role': 'Maintenance & Housekeeping', 'phone': '1122334455'},
    {'name': 'Security Guard', 'role': 'Safety & Security', 'phone': '2233445566'},
    {'name': 'Housekeeping Staff', 'role': 'Cleaning & Maintenance', 'phone': '3344556677'},
    {'name': 'Mess Manager', 'role': 'Food Services', 'phone': '4455667788'},
    {'name': 'Maintenance Staff', 'role': 'Repairs & Maintenance', 'phone': '5566778899'},
    {'name': 'Receptionist', 'role': 'Front Desk', 'phone': '6677889900'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hostel Staff'),
      ),
      body: ListView.builder(
        itemCount: staffMembers.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            elevation: 4,
            child: ListTile(
              title: Text(staffMembers[index]['name'] ?? ''),
              subtitle: Text(staffMembers[index]['role'] ?? ''),
              trailing: GestureDetector(
                onTap: () {
                  _openDialPad(staffMembers[index]['phone']!);
                },
                child: Text(
                  staffMembers[index]['phone'] ?? '',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _openDialPad(String phoneNumber) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri); // This opens the dial pad with the number filled in
    } else {
      throw 'Could not open dialer for $phoneNumber';
    }
  }
}
