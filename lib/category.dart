import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  final String category;

  CategoryPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: 10, // Replace with your dynamic item count
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.asset('assets/item.jpg', fit: BoxFit.cover), // Replace with your item image
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Item Name'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('\$17.00'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
