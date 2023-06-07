class ShopLoginModel {
  bool? status;
  String? message;
  Userdata? data;

  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Userdata.fromJson(json['data']): null ;
  }
}

class Userdata {
  int? id;
  String? name;
  String? image;
  String? email;
  String? phone;
  int? points;
  int? credits;
  String? token;

  //named constructor:
  Userdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    email = json['email'];
    phone = json['phone'];
    points = json['points'];
    credits = json['credits'];
    token = json['token'];
  }
}
