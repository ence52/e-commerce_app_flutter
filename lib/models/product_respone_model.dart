class Product {
  String? name;
  String? brand;
  String? model;
  String? description;
  double? price;
  double? rating;
  int? categoryId;
  List<Images>? images;
  int? stock;
  int? id;
  String? createdAt;
  String? updatedAt;

  Product(
      {this.name,
      this.brand,
      this.model,
      this.description,
      this.price,
      this.rating,
      this.categoryId,
      this.images,
      this.stock,
      this.id,
      this.createdAt,
      this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    brand = json['brand'];
    model = json['model'];
    description = json['description'];
    price = json['price'];
    rating = json['rating'];
    categoryId = json['category_id'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    stock = json['stock'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['brand'] = brand;
    data['model'] = model;
    data['description'] = description;
    data['price'] = price;
    data['rating'] = rating;
    data['category_id'] = categoryId;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['stock'] = stock;
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Images {
  String? url;

  Images({this.url});

  Images.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    return data;
  }
}
