class ChangeFavoritesModel {
  bool? status;
  String? messsage;

  ChangeFavoritesModel.fromJson(Map<String , dynamic> json){
  status = json['status'];
  messsage = json['messsage'];
  }

}

// class FavoritesData {
//   int? id;
//   DataProduct? data;

//   FavoritesData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     data = DataProduct.fromJson(json['data']);
//   }
// }

// class DataProduct {
//   int? id;
//   dynamic price;
//   dynamic oldPrice;
//   int? discount;
//   String? image;

//   DataProduct.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     price = json['price'];
//     oldPrice = json['old_price'];
//     discount = json['discount'];
//     image = json['image'];
//   }
// }
