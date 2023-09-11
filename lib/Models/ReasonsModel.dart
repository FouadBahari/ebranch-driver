class ReasonsModel {
  bool? status;
  String? errNum;
  String? msg;
  List<Data>? data;

  ReasonsModel({this.status, this.errNum, this.msg, this.data});

  ReasonsModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    errNum = json["errNum"];
    msg = json["msg"];
    data = json["data"]==null ? null : (json["data"] as List).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["status"] = status;
    data["errNum"] = errNum;
    data["msg"] = msg;
    if(this.data != null)
      data["data"] = this.data?.map((e)=>e.toJson()).toList();
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? type;
  String? createdAt;
  String? updatedAt;

  Data({this.id, this.name, this.type, this.createdAt, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    type = json["type"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["name"] = name;
    data["type"] = type;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
  }
}