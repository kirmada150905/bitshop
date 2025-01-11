// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Review {
  final int rating;
  final String comment;
  final DateTime date;
  final String reviewerName;
  final String reviewerEmail;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      rating: map['rating'] as int,
      comment: map['comment'] as String,
      date: DateTime.parse(map['date'] as String),
      reviewerName: map['reviewerName'] as String,
      reviewerEmail: map['reviewerEmail'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rating': rating,
      'comment': comment,
      'date': date.toIso8601String(),
      'reviewerName': reviewerName,
      'reviewerEmail': reviewerEmail,
    };
  }
}

class Dimensions {
  final double width;
  final double height;
  final double depth;

  Dimensions({
    required this.width,
    required this.height,
    required this.depth,
  });

  factory Dimensions.fromMap(Map<String, dynamic> map) {
    return Dimensions(
      width: (map['width'] as num).toDouble(),
      height: (map['height'] as num).toDouble(),
      depth: (map['depth'] as num).toDouble(),
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
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String brand;
  final String sku;
  final double weight;
  final Dimensions dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final List<Review> reviews;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final Map<String, dynamic> meta;
  final List<String> images;
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
    required this.thumbnail,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      price: (map['price'] as num).toDouble(),
      discountPercentage: (map['discountPercentage'] as num).toDouble(),
      rating: (map['rating'] as num).toDouble(),
      stock: map['stock'] as int,
      tags: List<String>.from(map['tags'] as List),
      brand: map['brand'] as String,
      sku: map['sku'] as String,
      weight: (map['weight'] as num).toDouble(),
      dimensions: Dimensions.fromMap(map['dimensions'] as Map<String, dynamic>),
      warrantyInformation: map['warrantyInformation'] as String,
      shippingInformation: map['shippingInformation'] as String,
      availabilityStatus: map['availabilityStatus'] as String,
      reviews: (map['reviews'] as List)
          .map((review) => Review.fromMap(review as Map<String, dynamic>))
          .toList(),
      returnPolicy: map['returnPolicy'] as String,
      minimumOrderQuantity: map['minimumOrderQuantity'] as int,
      meta: Map<String, dynamic>.from(map['meta'] as Map),
      images: List<String>.from(map['images'] as List),
      thumbnail: map['thumbnail'] as String,
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
      'dimensions': dimensions.toMap(),
      'warrantyInformation': warrantyInformation,
      'shippingInformation': shippingInformation,
      'availabilityStatus': availabilityStatus,
      'reviews': reviews.map((review) => review.toMap()).toList(),
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
  final String slug;
  final String name;
  final String url;
  Category({
    required this.slug,
    required this.name,
    required this.url,
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
    return <String, dynamic>{
      'slug': slug,
      'name': name,
      'url': url,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      slug: map['slug'] as String,
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Category(slug: $slug, name: $name, url: $url)';

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;

    return other.slug == slug && other.name == name && other.url == url;
  }

  @override
  int get hashCode => slug.hashCode ^ name.hashCode ^ url.hashCode;
}
