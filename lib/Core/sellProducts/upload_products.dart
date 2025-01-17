import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:bitshop/Core/pages/profileMangement/editProfile_page.dart';
import 'package:image_picker/image_picker.dart';

class CustomProduct {
  String name;
  String price;
  String description;
  String imageUrl;

  CustomProduct({
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  CustomProduct copyWith({
    String? name,
    String? price,
    String? description,
    String? imageUrl,
  }) {
    return CustomProduct(
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  factory CustomProduct.fromMap(Map<String, dynamic> map) {
    return CustomProduct(
      name: map['name'] as String,
      price: map['price'] as String,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomProduct.fromJson(String source) =>
      CustomProduct.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CustomProduct(name: $name, price: $price, description: $description, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(covariant CustomProduct other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.price == price &&
        other.description == description &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        price.hashCode ^
        description.hashCode ^
        imageUrl.hashCode;
  }
}

Future<void> uploadImage(File file) async {
  if (!file.existsSync()) {
    print("Error: File does not exist at path: ${file.path}");
    return;
  }

  try {
    final storageRef = FirebaseStorage.instance.ref();

    final fileName = (DateTime.now().millisecondsSinceEpoch).toString();
    final fileRef = storageRef.child("images/$fileName.jpg");

    if (file.existsSync()) {
      print("File does exist at path: ${file.path}");
    }

    TaskSnapshot snapshot = await fileRef.putFile(file);

    String downloadUrl = await snapshot.ref.getDownloadURL();
    print("File uploaded successfully. Download URL: $downloadUrl");
  } catch (e) {
    print("Error uploading file: ${e.toString()}");
  }
}
