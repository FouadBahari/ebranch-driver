class WalletModel {
  bool? status;
  String? errNum;
  dynamic wallet;
  dynamic gain;
  dynamic countorders;
  String? msg;
  List<Data>? data;

  WalletModel({this.status, this.errNum, this.wallet, this.gain, this.countorders, this.msg, this.data});

  WalletModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    errNum = json["errNum"];
    wallet = json["wallet"];
    gain = json["gain"];
    countorders = json["countorders"];
    msg = json["msg"];
    data = json["data"]==null ? null : (json["data"] as List).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status"] = status;
    data["errNum"] = errNum;
    data["wallet"] = wallet;
    data["gain"] = gain;
    data["countorders"] = countorders;
    data["msg"] = msg;
    if(this.data != null) {
      data["data"] = this.data?.map((e)=>e.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  int? cardId;
  String? createdAt;
  String? updatedAt;
  dynamic wallet;

  Card? card;

  Data({this.id, this.userId, this.cardId, this.createdAt, this.updatedAt, this.card});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["user_id"];
    cardId = json["card_id"];
    wallet = json["wallet"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    card = json["card"] == null ? null : Card.fromJson(json["card"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["user_id"] = userId;
    data["card_id"] = cardId;
    data["created_at"] = createdAt;
    data["wallet"] = wallet;
    data["updated_at"] = updatedAt;
    if(card != null) {
      data["card"] = card?.toJson();
    }
    return data;
  }
}

class Card {
  int? id;
  int? price;
  String? code;
  String? createdAt;
  String? updatedAt;

  Card({this.id, this.price, this.code, this.createdAt, this.updatedAt});

  Card.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["price"];
    code = json["code"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["price"] = price;
    data["code"] = code;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
  }
}