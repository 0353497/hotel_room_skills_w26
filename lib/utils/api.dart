import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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

}