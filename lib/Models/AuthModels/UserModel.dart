class UserModel {
  bool? status;
  String? errNum;
  String? msg;
  Data? data;

  UserModel({this.status, this.errNum, this.msg, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  String? phone;
  String? email;
  String? photo;
  String? address;
  dynamic lat;
  dynamic lang;
  String? type;
  dynamic status;
  String? token;
  String? wallet;
  String? updatedAt;
  String? createdAt;
  dynamic id;
  String? apiToken;

  Data(
      {this.name,
        this.phone,
        this.email,
        this.photo,
        this.address,
        this.lat,
        this.lang,
        this.type,
        this.status,
        this.wallet,
        this.token,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.apiToken});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    photo = json['photo'];
    address = json['address'];
    lat = json['lat'];
    lang = json['lang'];
    type = json['type'];
    status = json['status'];
    wallet = json['wallet'].toString();
    token = json['token'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    apiToken = json['api_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['photo'] = this.photo;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lang'] = this.lang;
    data['type'] = this.type;
    data['wallet'] = this.wallet;
    data['status'] = this.status;
    data['token'] = this.token;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['api_token'] = this.apiToken;
    return data;
  }
}