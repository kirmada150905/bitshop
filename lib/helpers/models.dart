import 'dart:convert';

class Review {
  int? rating;
  String? comment;
  DateTime? date;
  String? reviewerName;
  String? reviewerEmail;

  Review({
    this.rating,
    this.comment,
    this.date,
    this.reviewerName,
    this.reviewerEmail,
  });

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      rating: map['rating'] as int?,
      comment: map['comment'] as String?,
      date: map['date'] != null ? DateTime.tryParse(map['date'] as String) : null,
      reviewerName: map['reviewerName'] as String?,
      reviewerEmail: map['reviewerEmail'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rating': rating,
      'comment': comment,
      'date': date?.toIso8601String(),
      'reviewerName': reviewerName,
      'reviewerEmail': reviewerEmail,
    };
  }
}

class Dimensions {
  double? width;
  double? height;
  double? depth;

  Dimensions({
    this.width,
    this.height,
    this.depth,
  });

  factory Dimensions.fromMap(Map<String, dynamic> map) {
    return Dimensions(
      width: (map['width'] as num?)?.toDouble(),
      height: (map['height'] as num?)?.toDouble(),
      depth: (map['depth'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'width': width,
      'height': height,
      'depth': depth,
    };
  }
}

class Product {
  int? id;
  String? title;
  String? description;
  String? category;
  double? price;
  double? discountPercentage;
  double? rating;
  int? stock;
  List<String>? tags;
  String? brand;
  String? sku;
  double? weight;
  Dimensions? dimensions;
  String? warrantyInformation;
  String? shippingInformation;
  String? availabilityStatus;
  List<Review>? reviews;
  String? returnPolicy;
  int? minimumOrderQuantity;
  Map<String, dynamic>? meta;
  List<String>? images;
  String? thumbnail;

  Product({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.tags,
    this.brand,
    this.sku,
    this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.meta,
    this.images,
    this.thumbnail,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int?,
      title: map['title'] as String?,
      description: map['description'] as String?,
      category: map['category'] as String?,
      price: (map['price'] as num?)?.toDouble(),
      discountPercentage: (map['discountPercentage'] as num?)?.toDouble(),
      rating: (map['rating'] as num?)?.toDouble(),
      stock: map['stock'] as int?,
      tags: (map['tags'] as List?)?.cast<String>(),
      brand: map['brand'] as String?,
      sku: map['sku'] as String?,
      weight: (map['weight'] as num?)?.toDouble(),
      dimensions: map['dimensions'] != null
          ? Dimensions.fromMap(map['dimensions'] as Map<String, dynamic>)
          : null,
      warrantyInformation: map['warrantyInformation'] as String?,
      shippingInformation: map['shippingInformation'] as String?,
      availabilityStatus: map['availabilityStatus'] as String?,
      reviews: (map['reviews'] as List?)
          ?.map((review) => Review.fromMap(review as Map<String, dynamic>))
          .toList(),
      returnPolicy: map['returnPolicy'] as String?,
      minimumOrderQuantity: map['minimumOrderQuantity'] as int?,
      meta: map['meta'] != null ? Map<String, dynamic>.from(map['meta']) : null,
      images: (map['images'] as List?)?.cast<String>(),
      thumbnail: map['thumbnail'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'tags': tags,
      'brand': brand,
      'sku': sku,
      'weight': weight,
      'dimensions': dimensions?.toMap(),
      'warrantyInformation': warrantyInformation,
      'shippingInformation': shippingInformation,
      'availabilityStatus': availabilityStatus,
      'reviews': reviews?.map((review) => review.toMap()).toList(),
      'returnPolicy': returnPolicy,
      'minimumOrderQuantity': minimumOrderQuantity,
      'meta': meta,
      'images': images,
      'thumbnail': thumbnail,
    };
  }

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());
}

class Category {
  String? slug;
  String? name;
  String? url;

  Category({
    this.slug,
    this.name,
    this.url,
  });

  Category copyWith({
    String? slug,
    String? name,
    String? url,
  }) {
    return Category(
      slug: slug ?? this.slug,
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'slug': slug,
      'name': name,
      'url': url,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      slug: map['slug'] as String?,
      name: map['name'] as String?,
      url: map['url'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);
}
