class OrderModel {
  bool? status;
  String? errNum;
  String? msg;
  List<OrderData>? data;

  OrderModel({this.status, this.errNum, this.msg, this.data});

  OrderModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    errNum = json["errNum"];
    msg = json["msg"];
    data = json["data"]==null ? null : (json["data"] as List).map((e)=>OrderData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["status"] = status;
    data["errNum"] = errNum;
    data["msg"] = msg;
    if(this.data != null)
      data["data"] = this.data!.map((e)=>e.toJson()).toList();
    return data;
  }
}

class OrderData {
  int? id;
  String? productId;
  String? amount;
  String? description;
  dynamic price;
  dynamic userId;
  dynamic driverId;
  String? address;
  String? lat;
  String? lang;
  String? vendor_name;
  String? vendor_id;
  String? vendor_address;
  String? vendor_lat;
  String? vendor_lang;
  String? vendor_phone;
  String? username;
  String? userphone;
  String? status;
  String? type;
  dynamic rate;
  dynamic replay;
  String? deliveryPrice;
  String? createdAt;
  String? updatedAt;
  List<Products>? products;
  Driver? driver;

  OrderData({this.id,this.description,this.username,this.userphone,this.vendor_phone,this.vendor_address,this.vendor_id,this.vendor_lang,this.vendor_lat,this.vendor_name, required this.deliveryPrice, this.productId, this.amount, this.price, this.userId, this.driverId, this.address, this.lat, this.lang, this.status, this.type, this.rate, this.replay, this.createdAt, this.updatedAt, this.products, this.driver});

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productId = json["product_id"];
    amount = json["amount"];
    description = json["description"];
    price = json["price"];
    userId = json["user_id"];
    driverId = json["driver_id"];
    address = json["address"];
    vendor_id = json["vendor_id"].toString();
    vendor_name = json["vendor_name"];
    vendor_phone = json["vendor_phone"];
    vendor_address = json["vendor_address"];
    vendor_lat = json["vendor_lat"];
    vendor_lang = json["vendor_lang"];
    username = json["username"];
    userphone = json["userphone"];
    lat = json["lat"];
    lang = json["lang"];
    status = json["status"];
    type = json["type"];
    rate = json["rate"];
    replay = json["replay"];
    deliveryPrice = json["shipping_price"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    products = json["products"]==null ? null : (json["products"] as List).map((e)=>Products.fromJson(e)).toList();
    driver = json["user"] == null ? null : Driver.fromJson(json["user"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["product_id"] = productId;
    data["amount"] = amount;
    data["description"] = description;
    data["price"] = price;
    data["user_id"] = userId;
    data["driver_id"] = driverId;
    data["address"] = address;
    data["lat"] = lat;
    data["lang"] = lang;
    data["status"] = status;
    data["type"] = type;
    data["rate"] = rate;
    data["shipping_price"] = deliveryPrice;
    data["replay"] = replay;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    if(products != null)
      data["products"] = products!.map((e)=>e.toJson()).toList();
    if(driver != null)
      data["driver"] = driver!.toJson();
    return data;
  }
}

class Driver {
  dynamic id;
  String? name;
  String? email;
  String? phone;
  String? type;
  dynamic emailVerifiedAt;
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

  Driver({this.id, this.name, this.email, this.phone, this.type, this.emailVerifiedAt, this.photo, this.serviceId, this.address, this.lat, this.lang, this.wallet, this.status, this.token, this.createdAt, this.updatedAt});

  Driver.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    type = json["type"];
    emailVerifiedAt = json["email_verified_at"];
    photo = json["photo"];
    serviceId = json["service_id"];
    address = json["address"];
    lat = json["lat"];
    lang = json["lang"];
    wallet = json["wallet"];
    status = json["status"];
    token = json["token"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["name"] = name;
    data["email"] = email;
    data["phone"] = phone;
    data["type"] = type;
    data["email_verified_at"] = emailVerifiedAt;
    data["photo"] = photo;
    data["service_id"] = serviceId;
    data["address"] = address;
    data["lat"] = lat;
    data["lang"] = lang;
    data["wallet"] = wallet;
    data["status"] = status;
    data["token"] = token;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
  }
}

class Products {
  int? id;
  String? name;
  dynamic price;
  String? photo;
  dynamic offer;
  String? description;
  dynamic userId;
  dynamic catId;
  dynamic amount;
  String? colors;
  String? sizes;
  String? createdAt;
  String? updatedAt;
  User? user;
  Cat? cat;

  Products({this.id, this.name, this.price, this.photo, this.offer, this.description, this.userId, this.catId, this.amount, this.colors, this.sizes, this.createdAt, this.updatedAt, this.user, this.cat});

  Products.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    price = json["price"];
    photo = json["photo"];
    offer = json["offer"];
    description = json["description"];
    userId = json["user_id"];
    catId = json["cat_id"];
    amount = json["amount"];
    colors = json["colors"];
    sizes = json["sizes"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    user = json["user"] == null ? null : User.fromJson(json["user"]);
    cat = json["cat"] == null ? null : Cat.fromJson(json["cat"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["name"] = name;
    data["price"] = price;
    data["photo"] = photo;
    data["offer"] = offer;
    data["description"] = description;
    data["user_id"] = userId;
    data["cat_id"] = catId;
    data["amount"] = amount;
    data["colors"] = colors;
    data["sizes"] = sizes;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    if(user != null)
      data["user"] = user!.toJson();
    if(cat != null)
      data["cat"] = cat!.toJson();
    return data;
  }
}

class Cat {
  int? id;
  String? name;
  dynamic userId;
  String? photo;
  String? createdAt;
  String? updatedAt;

  Cat({this.id, this.name, this.userId, this.photo, this.createdAt, this.updatedAt});

  Cat.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    userId = json["user_id"];
    photo = json["photo"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["name"] = name;
    data["user_id"] = userId;
    data["photo"] = photo;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? type;
  dynamic emailVerifiedAt;
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

  User({this.id, this.name, this.email, this.phone, this.type, this.emailVerifiedAt, this.photo, this.serviceId, this.address, this.lat, this.lang, this.wallet, this.status, this.token, this.createdAt, this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    type = json["type"];
    emailVerifiedAt = json["email_verified_at"];
    photo = json["photo"];
    serviceId = json["service_id"];
    address = json["address"];
    lat = json["lat"];
    lang = json["lang"];
    wallet = json["wallet"];
    status = json["status"];
    token = json["token"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["name"] = name;
    data["email"] = email;
    data["phone"] = phone;
    data["type"] = type;
    data["email_verified_at"] = emailVerifiedAt;
    data["photo"] = photo;
    data["service_id"] = serviceId;
    data["address"] = address;
    data["lat"] = lat;
    data["lang"] = lang;
    data["wallet"] = wallet;
    data["status"] = status;
    data["token"] = token;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
  }
}