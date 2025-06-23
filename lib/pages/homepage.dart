import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_room/components/glass_button.dart';
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

          GlassButton(
            alignment: Alignment.topLeft,
            children:[
              Text("Test",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18
              )
              ),
              Icon(Icons.mood),
              Text("Mood is good")
            ]
          ),
          GlassButton(
            alignment: Alignment.centerLeft,
            children:[
              Text("Do not disturb",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18
              )
              ),
              SvgPicture.asset("assets/do_not_disturb_off.svg",
              colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
              ),
              Text("Off")
            ]
          ),
          GlassButton(
            alignment: Alignment.bottomLeft,
            children:[
              Text("Make up room",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18
              )
              ),
              SvgPicture.asset("assets/make_up_room_off.svg",
              colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
              ),
              Text("off")
            ]
          ),
           GlassButton(
            alignment: Alignment.topRight,
            children:[
              Text("Curtains",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18
              )
              ),
              SvgPicture.asset("assets/curtains_open.svg",
              colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
              ),
              Text("open")
            ]
          ),
           GlassButton(
            alignment: Alignment.centerRight,
            children:[
              Text("Music",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18
              )
              ),
              SvgPicture.asset("assets/music_off.svg",
              colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
              ),
              Text("off")
            ]
          ),

          GlassButton(
            alignment: Alignment.bottomRight,
            children:[
              Text("Room color",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18
              )
              ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor
                ),
              ),
              Text("color")
            ]
          ),


          GlassSlider(),

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

class GlassSlider extends StatefulWidget {
  const GlassSlider({
    super.key,
  });

  @override
  State<GlassSlider> createState() => _GlassSliderState();
}

class _GlassSliderState extends State<GlassSlider> {

  double value = 20;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LiquidGlassBox(
            width: 400,
            height: 100,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Slider(
                  overlayColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.secondary),
                  divisions: 10,
                  min: 16,
                  max: 26,
                  value: value,
                  onChanged: (newvalue) {
                    setState(() {
                      value = newvalue;
                    });
                  }),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("temperature",
                    style: TextStyle(
                      color: Colors.white
                    ),
                    ),
                    Text("$value degrees"),
                  ],
                )
              ],
            )
            ),
        ],
      ),
    );
  }
}

