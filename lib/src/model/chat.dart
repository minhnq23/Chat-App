class Chat {
  String _id;
  List<String> _members;

  Chat(this._id, this._members);

  List<String> get members => _members;

  set members(List<String> value) {
    _members = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}