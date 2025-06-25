import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotel_room/models/room.dart';
import 'package:hotel_room/utils/current_room.dart';
import 'package:http/http.dart' as http;




//http://104.248.94.17
// /api/start
// /api/change 
// /api/room
class HttpService {
  
  static String get _token => dotenv.env["ACCES_TOKEN"] ?? '';

  static Future<void> start() async {
    try {
      debugPrint("calling api");
      final http.Response response = await http.post(
        Uri.parse('http://104.248.94.175/api/start'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $_token',
        },
      );
      final body =  jsonDecode(response.body) as Map<String, dynamic>;
      debugPrint(body.toString());
      final int roomNumber = body['room_number'] ?? 0;
      debugPrint('Room Number: $roomNumber');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

    static Future<void> getRoomData() async {
    try {
      debugPrint("calling api");
      final http.Response response = await http.post(
        Uri.parse('http://104.248.94.175/api/room'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $_token',
        },
      );
      final body =  jsonDecode(response.body) as Map<String, dynamic>;
      debugPrint(body.toString());

      final room = Room.fromJson(body);
      CurrentRoom.instance().updateRoom(room);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  
  static Future<void> updateRoom(String key, String value) async {
    // 'room_colour' => ['green','blue','red','purple','pink','gold','yellow'],
    // 'curtains' => ['open','closed'],
    // 'music' => ['off','hiphop','jazz','disco'],
    // 'locked' => ['0','1'],
    // 'climate' => range(16,26),
    // 'do_not_disturb' => ['0','1'],
    // 'make_up_room' => ['0','1']

    // Two POST parameters can be sent:
    // service: The type of service you want to change
    // value: The new value of the change request
    
    
    try {
      debugPrint("Updating room data");
      final http.Response response = await http.post(
        Uri.parse('http://104.248.94.175/api/change'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $_token',
        },
        body: jsonEncode(<String, String>{
          "service" : key,
          "value" : value
        }),
      );

      if (response.statusCode == 200) {
        debugPrint("succes");
        await getRoomData();
      } else {
        debugPrint("error:: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

}