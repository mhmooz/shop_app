class FavoritesModel {
  bool? status;
  FavoritesData? data;

  FavoritesModel.fomJson(Map<String, dynamic> json) {
    status = json['status'];
    data = FavoritesData.fromJson(json['data']);
  }
}

class FavoritesData {
  int? currentPage;
  List<FavData>? data = [];
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  int? perPage;
  int? to;
  int? total;

  FavoritesData.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    json['data'].forEach((element) {
      data!.add(FavData.fromJson(element));
    });
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }
}

class FavData {
  int? id;
  FavProductData? product;

  FavData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = FavProductData.fromJson(json['product']);
  }
}

class FavProductData {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;

  FavProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }
}
