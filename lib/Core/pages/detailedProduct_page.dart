import 'package:bitshop/helpers/cart_manger.dart';
import 'package:bitshop/helpers/models.dart';
import 'package:bitshop/styles/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailedProductPage extends ConsumerWidget {
  final Product product;

  const DetailedProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: cream),
        title: Text(
          product.title,
          style: TextStyle(color: cream),
          softWrap: true,
        ),
        backgroundColor: darkBlue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImageCarousel(images: product.images),
            ProductInfoSection(product: product),
            ActionButtons(
                onAddToCart: () {
                  User? user = FirebaseAuth.instance.currentUser;
                  final cartManager = ref.read(cartManagerProvider);
                  cartManager.addToCart(CartItem(
                      id: product.id.toString(),
                      title: product.title,
                      thumbnail: product.thumbnail,
                      price: product.price,
                      quantity: 1));
                },
                onAddToWishlist: () {}),
            Divider(color: Colors.grey),
            ProductAdditionalDetails(product: product),
            Divider(color: Colors.grey),
            ProductReviewsSection(reviews: product.reviews),
          ],
        ),
      ),
    );
  }
}

class ProductImageCarousel extends ConsumerWidget {
  final List<String> images;

  const ProductImageCarousel({super.key, required this.images});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: CarouselView(
        onTap: (index) {
          showDialog(
            context: context,
            builder: (_) => Dialog(
              child: Container(
                decoration: BoxDecoration(
                  color: cream,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8.0,
                      spreadRadius: 2.0,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    images[index],
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Center(
                      child: Icon(Icons.broken_image, color: Colors.red),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        itemExtent: MediaQuery.of(context).size.width,
        itemSnapping: true,
        shrinkExtent: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        backgroundColor: cream,
        elevation: 6.0,
        children: images.map((imageUrl) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: cream,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8.0,
                  spreadRadius: 2.0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Center(
                  child: Icon(Icons.broken_image, color: Colors.red),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ProductInfoSection extends StatelessWidget {
  final Product product;

  const ProductInfoSection({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            product.description,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text(
                "\$${product.price.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: darkBlue,
                ),
              ),
              SizedBox(width: 16),
              if (product.discountPercentage > 0)
                Text(
                  "-${product.discountPercentage.toStringAsFixed(1)}% off",
                  style: TextStyle(color: Colors.green),
                ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            "Rating: ${product.rating.toStringAsFixed(1)} ★",
            style: TextStyle(fontSize: 16, color: Colors.orange),
          ),
        ],
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  final VoidCallback onAddToCart;
  final VoidCallback onAddToWishlist;
  final bool isInCart;
  final bool isInWishlist;

  const ActionButtons({
    Key? key,
    required this.onAddToCart,
    required this.onAddToWishlist,
    this.isInCart = false,
    this.isInWishlist = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: onAddToCart,
          icon: Icon(
            isInCart ? Icons.shopping_cart : Icons.add_shopping_cart,
            color: cream,
          ),
          label: Text(
            isInCart ? 'In Cart' : 'Add to Cart',
            style: TextStyle(color: cream),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: isInCart ? Colors.green : darkBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        OutlinedButton.icon(
          onPressed: onAddToWishlist,
          icon: Icon(
            isInWishlist ? Icons.favorite : Icons.favorite_border,
            color: isInWishlist ? Colors.red : darkBlue,
          ),
          label: Text(
            isInWishlist ? 'In Wishlist' : 'Wishlist',
            style: TextStyle(
              color: isInWishlist ? Colors.red : darkBlue,
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: isInWishlist ? Colors.red : darkBlue,
              width: 1.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}

class ProductAdditionalDetails extends StatelessWidget {
  final Product product;

  const ProductAdditionalDetails({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Additional Details",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text("Brand: ${product.brand}"),
          Text("Stock: ${product.stock} available"),
          Text(
            "Dimensions: ${product.dimensions.width} x ${product.dimensions.height} x ${product.dimensions.depth} cm",
          ),
          SizedBox(height: 8),
          Text("Warranty: ${product.warrantyInformation}"),
          Text("Return Policy: ${product.returnPolicy}"),
        ],
      ),
    );
  }
}

class ProductReviewsSection extends StatelessWidget {
  final List<Review> reviews;

  const ProductReviewsSection({Key? key, required this.reviews})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Customer Reviews",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          reviews.isEmpty
              ? Text("No reviews yet.")
              : ListView.builder(
                  itemCount: reviews.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final review = reviews[index];
                    return ReviewCard(review: review);
                  },
                ),
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              review.reviewerName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              review.comment,
              style: TextStyle(color: Colors.grey[700]),
            ),
            SizedBox(height: 8),
            Text(
              "Rating: ${review.rating} ★",
              style: TextStyle(color: Colors.orange),
            ),
            SizedBox(height: 4),
            Text(
              "Reviewed on: ${review.date.toLocal().toString().split(' ')[0]}",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
