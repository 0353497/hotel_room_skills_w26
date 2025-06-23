
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

  Room({
    required this.color,
    required this.curtain,
    required this.music,
    required this.locked,
    required this.climate,
    required this.doNotDisturb,
    required this.makeUpRoom,
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
      color: _parseColor(json['color']),
      curtain: _parseCurtain(json['curtain']?.toString()),
      music: _parseMusic(json['music']?.toString()),
      locked: int.tryParse(json['locked']) == 1,
      climate: int.tryParse(json['climate']) ?? 20,
      doNotDisturb: int.tryParse(json['doNotDisturb']) == 1,
      makeUpRoom: int.tryParse(json['makeUpRoom']) == 1,
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