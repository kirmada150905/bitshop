class WishlistItem {
  final String id;
  final String image;
  final String title;
  final double price;

  WishlistItem({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
  });

  // Convert WishlistItem to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'price': price,
    };
  }

  // Create a WishlistItem from Map
  factory WishlistItem.fromMap(Map<String, dynamic> map) {
    return WishlistItem(
      id: map['id'],
      image: map['image'],
      title: map['title'],
      price: (map['price'] as num).toDouble(),
    );
  }
}
