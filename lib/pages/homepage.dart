import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_room/components/glass_button.dart';
import 'package:hotel_room/components/liquid_glass_box.dart';
import 'package:hotel_room/models/room.dart';
import 'package:hotel_room/utils/api.dart';
import 'package:hotel_room/utils/current_room.dart';
import 'package:flutter/cupertino.dart';

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

  void fetchData() async {
    await HttpService.start();
    await HttpService.getRoomData();
  }

  void _showMusicOptions(BuildContext context, Room currentRoom) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text('Select Music'),
          actions: ['off', 'hiphop', 'jazz', 'disco'].map((musicOption) {
            return CupertinoActionSheetAction(
              onPressed: () {
                HttpService.updateRoom("music", musicOption);
                Navigator.pop(context);
              },
              child: Text(musicOption.toUpperCase()),
            );
          }).toList(),
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        );
      },
    );
  }

  void _showColorOptions(BuildContext context, Room currentRoom) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text('Select Room Color'),
          actions: ['green', 'blue', 'red', 'purple', 'pink', 'gold', 'yellow'].map((colorOption) {
            return CupertinoActionSheetAction(
              onPressed: () {
                HttpService.updateRoom("room_colour", colorOption);
                Navigator.pop(context);
              },
              child: Text(colorOption.toUpperCase()),
            );
          }).toList(),
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: CurrentRoom.instance().currentRoomStream,
        builder: (context, asyncSnapshot) {
          final Room? currentRoom = asyncSnapshot.data;
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),);
          }
          if (currentRoom == null) return Center(child: Text("something went wrong"),);

          return Stack(
            children: [
              Image.asset(
                currentRoom.curtain == Curtain.closed
                ? "assets/curtains_closed.jpg" :
                "assets/curtains_open.jpg",
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
          
              GlassButton(
                isActive: currentRoom.locked,
                alignment: Alignment.topLeft,
                onTap: () {
                  HttpService.updateRoom("locked", currentRoom.locked ? "0" : "1");
                },
                children:[
                  Text("Room door",
                  style: TextStyle(
                    color: currentRoom.locked ? null : Colors.white,
                    fontSize: 18
                  )
                  ),
                   SvgPicture.asset(
                    currentRoom.locked ? "assets/door_locked.svg" :
                    "assets/door_unlocked.svg",
                    colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
                  ),
                  Text(currentRoom.locked ? "LOCKED" : "UNLOCKED",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 24, fontWeight: FontWeight.bold
                  )
                  )
                ]
              ),
              GlassButton(
                alignment: Alignment.centerLeft,
                onTap: () {
                  HttpService.updateRoom("do_not_disturb", currentRoom.doNotDisturb ? "0" : "1");
                },
                isActive: !currentRoom.doNotDisturb,
                children:[
                  Text("Do not disturb",
                  style: TextStyle(
                    color: currentRoom.doNotDisturb ? Colors.white : null,
                    fontSize: 18
                  )
                  ),
                  SvgPicture.asset(
                    currentRoom.doNotDisturb ? "assets/do_not_disturb_off.svg" :
                    "assets/do_not_disturb_on.svg",
                  colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
                  ),
                  Text(currentRoom.doNotDisturb ? "OFF" : "ON",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 24, fontWeight: FontWeight.bold
                  )
                  )
                ]
              ),
              GlassButton(
                alignment: Alignment.bottomLeft,
                isActive: currentRoom.makeUpRoom,
                onTap: () {
                  HttpService.updateRoom("make_up_room", currentRoom.makeUpRoom ? "0" : "1");
                },
                children:[
                  Text("Make up room",
                  style: TextStyle(
                    color: currentRoom.makeUpRoom ? null : Colors.white,
                    fontSize: 18
                  )
                  ),
                  SvgPicture.asset(
                    currentRoom.makeUpRoom ? "assets/make_up_room_on.svg" :
                    "assets/make_up_room_off.svg",
                  colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
                  ),
                  Text(currentRoom.makeUpRoom ? "ON" : "OFF",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 24, fontWeight: FontWeight.bold
                  )
                  )
                ]
              ),
               GlassButton(
                alignment: Alignment.topRight,
                isActive: currentRoom.curtain == Curtain.closed,
                onTap: () {
                  HttpService.updateRoom("curtains", currentRoom.curtain == Curtain.open ? "closed" : "open");
                },
                children:[
                  Text("Curtains",
                  style: TextStyle(
                    color: currentRoom.curtain == Curtain.closed ? null : Colors.white,
                    fontSize: 18
                  )
                  ),
                  SvgPicture.asset(
                    currentRoom.curtain == Curtain.open ?
                    "assets/curtains_open.svg" : "assets/curtains_closed.svg",
                  colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
                  ),
                  Text(
                    currentRoom.curtain == Curtain.open ?
                    "OPEN" : "CLOSED",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 24, fontWeight: FontWeight.bold
                    )

                    )
                ]
              ),
               GlassButton(
                alignment: Alignment.centerRight,
                isActive: currentRoom.music != Music.off,
                onTap: () => _showMusicOptions(context, currentRoom),
                children:[
                  Text("Music",
                  style: TextStyle(
                    color: currentRoom.music == Music.off ? Colors.white : null,
                    fontSize: 18
                  )
                  ),
                  SvgPicture.asset(
                    currentRoom.music == Music.off ?
                    "assets/music_off.svg" : "assets/music_on.svg",
                  colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
                  ),
                  Text(currentRoom.music.toString().toUpperCase(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 24, fontWeight: FontWeight.bold
                  )
                  )
                ]
              ),
          
              GlassButton(
                onTap: () => _showColorOptions(context, currentRoom),
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
                      color: Theme.of(context).primaryColor,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        width: 6
                      )
                    ),
                  ),
                  Text(currentRoom.colorInString.toUpperCase(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 24, fontWeight: FontWeight.bold
                  )
                  )
                ]
              ),
          
          
              GlassSlider(initialValue: currentRoom.climate),
          
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
                      Text(currentRoom.roomNumber.toString(),
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
          );
        }
      ),
    );
  }
}

class GlassSlider extends StatefulWidget {
  const GlassSlider({
    super.key, required this.initialValue,
  });
  final int initialValue;

  @override
  State<GlassSlider> createState() => _GlassSliderState();
}

class _GlassSliderState extends State<GlassSlider> {

  late double value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LiquidGlassBox(
            onTap: (){},
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
                    HttpService.updateRoom("climate", newvalue.toString());
                  }),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Temperature",
                    style: TextStyle(
                      color: Colors.white
                    ),
                    ),
                    Text("${value.toInt().toString().toUpperCase()} DEGREES",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24
                      ),
                    ),
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

