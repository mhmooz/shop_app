class SearchModel {
   bool? status;
   SearchData? data;

  SearchModel.fomJson(Map<String, dynamic> json) {
    status = json['status'];
    data = SearchData.fromJson(json['data']);
  }
}

class SearchData {
   int? currentPage;
  List<SearchProductData>? data = [];
   String? firstPageUrl;
   int? from;
   int? lastPage;
   String? lastPageUrl;
   int? perPage;
   int? to;
   int? total;

  SearchData.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    json['data'].forEach((element) {
      data!.add(SearchProductData.fromJson(element));
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

class SearchProductData {
   int? id;
  dynamic price;
   String? image;
   String? name;
   bool? inFavorites;
   bool? inCart;

  SearchProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
