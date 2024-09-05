// import 'dart:convert';
//
// class Room {
//   final int id;
//   String number;
//   bool isAvailable;
//   int beds;
//
//   Room({
//     required this.id,
//     required this.number,
//     required this.isAvailable,
//     required this.beds,
//   });
//
//   factory Room.fromJson(Map<String, dynamic> json) {
//     return Room(
//       id: json['id'],
//       number: json['number'],
//       isAvailable: json['isAvailable'],
//       beds: json['beds'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'number': number,
//       'isAvailable': isAvailable,
//       'beds': beds,
//     };
//   }
// }