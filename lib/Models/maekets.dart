class MarketsModel {
  bool? status;
  String? errNum;
  String? msg;
  List<Vendors>? vendors;

  MarketsModel({this.status, this.errNum, this.msg, this.vendors});

  MarketsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['vendors'] != null) {
      vendors = [];
      json['vendors'].forEach((v) {
        vendors!.add(new Vendors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.vendors != null) {
      data['vendors'] = this.vendors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vendors {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? type;
  Null emailVerifiedAt;
  String? photo;
  dynamic serviceId;
  String? address;
  String? lat;
  String? lang;
  dynamic wallet;
  dynamic status;
  String? token;
  String? createdAt;
  String? updatedAt;

  Vendors(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.type,
        this.emailVerifiedAt,
        this.photo,
        this.serviceId,
        this.address,
        this.lat,
        this.lang,
        this.wallet,
        this.status,
        this.token,
        this.createdAt,
        this.updatedAt});

  Vendors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    type = json['type'];
    emailVerifiedAt = json['email_verified_at'];
    photo = json['photo'];
    serviceId = json['service_id'];
    address = json['address'];
    lat = json['lat'];
    lang = json['lang'];
    wallet = json['wallet'];
    status = json['status'];
    token = json['token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['type'] = this.type;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['photo'] = this.photo;
    data['service_id'] = this.serviceId;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lang'] = this.lang;
    data['wallet'] = this.wallet;
    data['status'] = this.status;
    data['token'] = this.token;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}