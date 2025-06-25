import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotel_room/pages/homepage.dart';
import 'package:hotel_room/utils/current_room.dart';
import 'package:hotel_room/models/room.dart';

void main() async {
  await dotenv.load();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Color _themeColor = const Color.fromARGB(255, 8, 87, 152);

  @override
  void initState() {
    super.initState();
    CurrentRoom.instance().currentRoomStream.listen((Room room) {
      setState(() {
        _themeColor = room.color;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _themeColor),
        primaryColor: _themeColor
      ),
      home: Homepage(),
    );
  }
}
