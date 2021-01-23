class Numero {
  int _id;
  String _numero;
  String _message;

  int get id => _id;
  String get numero => _numero;
  Numero(this._id, this._numero, this._message);
  Numero.map(dynamic obj) {
    this._id = obj["id"];
    this._numero = obj["numero"];
    this._numero = obj["message"];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map["id"] = _id;
    }
    map["numero"] = _numero;
    map["message"] = _message;

    return map;
  }

  Numero.fromMap(Map<String, dynamic> map) {
    this._id = map["id"];
    this._numero = map["numero"];
    this._message = map["message"];
  }
  @override
  String toString() {
    return _numero;
  }
}
