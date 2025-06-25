import 'package:hotel_room/models/room.dart';
import 'package:rxdart/subjects.dart';

class CurrentRoom {
  static final CurrentRoom _instance = CurrentRoom._internal();

  CurrentRoom._internal();

  factory CurrentRoom.instance() {
    return _instance;
  }

  final BehaviorSubject<Room> _currentRoom = BehaviorSubject<Room>();

  Room? get currentRoomValue => _currentRoom.valueOrNull;

  Stream<Room> get currentRoomStream => _currentRoom.stream;

  void updateRoom(Room newRoom) {
    _currentRoom.add(newRoom);
  }
}