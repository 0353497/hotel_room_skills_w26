class CurrentRoom {
  static final CurrentRoom _instance = CurrentRoom._internal();

  CurrentRoom._internal();

  factory CurrentRoom.instance() {
    return _instance;
  }
}