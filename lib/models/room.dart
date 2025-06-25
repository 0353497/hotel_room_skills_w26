
import 'package:flutter/material.dart';

enum Curtain { closed, open }
enum Music { off, hiphop, jazz, disco }

class Room {
  final Color color;
  final Curtain curtain;
  final Music music;
  final bool locked;
  final int climate;
  final bool doNotDisturb;
  final bool makeUpRoom;
  final int roomNumber;
  final String colorInString;

  Room({
    required this.color,
    required this.curtain,
    required this.music,
    required this.locked,
    required this.climate,
    required this.doNotDisturb,
    required this.makeUpRoom,
    required this.roomNumber,
    required this.colorInString
  });

  static Color _parseColor(String? colorName) {
    //['green','blue','red','purple','pink','gold','yellow'],
    switch (colorName?.toLowerCase()) {
      case 'green':
        return Colors.green;
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'purple':
      return Colors.purple;
      case 'pink':
      return Colors.pink;
      case 'gold':
      return Colors.amberAccent;
      case 'yellow':
      return Colors.yellow;
      default:
      //default is blauw want ik hou van blau (:
        return Colors.blue;
    }
  }
  static Curtain _parseCurtain(String? curtainName) {
    switch (curtainName?.toLowerCase()) {
      case 'open':
      return Curtain.open;
      case 'closed':
      return Curtain.closed;
      default:
        return Curtain.open;
    }
  }
  static Music _parseMusic(String? musicName) {
    switch (musicName?.toLowerCase()) {
      case 'hiphop':
        return Music.hiphop;
      case 'jazz':
        return Music.jazz;
      case 'disco':
        return Music.disco;
      case 'off':
      default:
        return Music.off;
    }
  }

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      color: _parseColor(json['room_colour']), //"room_colour" -> "yellow"
      colorInString: json['room_colour'],
      curtain: _parseCurtain(json['curtains']?.toString()), //"curtains" -> "open"
      music: _parseMusic(json['music']?.toString()), //"music" -> "off"
      locked: json['locked'] == 1, //"locked" -> 0
      climate: json['climate'] ?? 20, //"climate" -> 20
      doNotDisturb: json['do_not_disturb'] == 1, //"do_not_disturb" -> 0
      makeUpRoom: json['make_up_room'] == 1, //"make_up_room" -> 0
      roomNumber: json['room_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'color': color,
      'curtain': curtain.index,
      'music': music.index,
      'locked': locked ? 1 : 0,
      'climate': climate,
      'doNotDisturb': doNotDisturb ? 1 : 0,
      'makeUpRoom': makeUpRoom ? 1 : 0,
    };
  }
}