import 'package:bitshop/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SellProductsPage extends ConsumerWidget {
  const SellProductsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController productNameController = TextEditingController();
    final TextEditingController productPriceController =
        TextEditingController();
    final TextEditingController productDescriptionController =
        TextEditingController();

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Center(
                child: Text(
                  "Sell a Product",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: darkBlue,
                  ),
                ),
              ),
              const Divider(height: 2, color: Colors.grey),
              const SizedBox(height: 20),

              
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: darkBlue,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Text(
                      "Product Name",
                      style: TextStyle(
                        color: cream,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: productNameController,
                      style: TextStyle(color: cream),
                      decoration: InputDecoration(
                        hintText: "Enter product name",
                        hintStyle: TextStyle(color: cream.withOpacity(0.7)),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: cream),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    
                    Text(
                      "Product Price",
                      style: TextStyle(
                        color: cream,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: productPriceController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: cream),
                      decoration: InputDecoration(
                        hintText: "Enter product price",
                        hintStyle: TextStyle(color: cream.withOpacity(0.7)),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: cream),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    
                    Text(
                      "Product Description",
                      style: TextStyle(
                        color: cream,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: productDescriptionController,
                      maxLines: 4,
                      style: TextStyle(color: cream),
                      decoration: InputDecoration(
                        hintText: "Enter product description",
                        hintStyle: TextStyle(color: cream.withOpacity(0.7)),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: cream),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              
              TextButton.icon(
                onPressed: () {
                  
                },
                icon: Icon(Icons.upload, color: darkBlue),
                label: Text(
                  "Upload Product Image",
                  style:
                      TextStyle(color: darkBlue, fontWeight: FontWeight.w600),
                ),
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  backgroundColor: cream,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    
                    String name = productNameController.text.trim();
                    String price = productPriceController.text.trim();
                    String description =
                        productDescriptionController.text.trim();

                    if (name.isNotEmpty &&
                        price.isNotEmpty &&
                        description.isNotEmpty) {
                      print("Product Name: $name");
                      print("Product Price: $price");
                      print("Product Description: $description");

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Product submitted successfully!"),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Please fill in all fields."),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkBlue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Submit Product",
                    style: TextStyle(fontSize: 16, color: cream),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
