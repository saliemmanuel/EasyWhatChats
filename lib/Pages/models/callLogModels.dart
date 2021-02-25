class CallLogModels {
  int _id;
  String _number;
  String _name;

  int get id => _id;
  String get number => _number;
  String get name => _name;
  CallLogModels(this._id, this._number, this._name);
  CallLogModels.map(dynamic obj) {
    this._id = obj["id"];
    this._number = obj["number"];
    this._name = obj["name"];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map["id"] = _id;
    }
    map["number"] = _number;
    map["name"] = _name;

    return map;
  }

  CallLogModels.fromMap(Map<String, dynamic> map, this._name) {
    this._id = map["id"];
    this._number = map["number"];
    this._name = map["name"];
  }
  @override
  String toString() {
    if (_name == '')
      return "$_number";
    else
      return "$_name";
  }
}
