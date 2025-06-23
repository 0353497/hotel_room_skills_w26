import 'package:flutter/material.dart';
import 'package:hotel_room/components/liquid_glass_box.dart';
import 'package:hotel_room/utils/api.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async{
    await HttpService.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            width: MediaQuery.of(context).size.width,
            "assets/curtains_open.jpg",
            fit: BoxFit.fill,
          ),
          LiquidGlassBox(
            width: 150, 
            height: 150, 
            left: 50,
            top: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Test"),
                Icon(Icons.mood),
                Text("Mood is good")
              ],
            ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 10,
                children: [
                  Text("Room",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                  ),
                  Text("206",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32
                  ),
                  )
                ],
              ),
            )
            )
          ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => HttpService.start()
      ),
    );
  }
}