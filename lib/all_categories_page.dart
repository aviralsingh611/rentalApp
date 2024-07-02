import 'package:flutter/material.dart';

class AllCategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Categories'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'All Categories',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      FilterChip(
                        label: Text('All'),
                        onSelected: (bool selected) {},
                      ),
                      SizedBox(width: 8),
                      FilterChip(
                        label: Text('Bike'),
                        onSelected: (bool selected) {},
                      ),
                      SizedBox(width: 8),
                      FilterChip(
                        label: Text('Vehicle'),
                        onSelected: (bool selected) {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _buildCategoryItem(context, 'Bajaj Avengers', 'Models', 'xl-1', 'Color', 'Black', 'e-BIKE'),
                  _buildCategoryItem(context, 'Bajaj Avengers', 'Models', 'xr/2', 'Color', 'Purple', 'Vehicle'),
                  // Add more items as needed
                ],
              ),
            ),
            ExpansionTile(
              title: Text('Furniture'),
              children: [
                ListTile(title: Text('Item 1')),
                ListTile(title: Text('Item 2')),
              ],
            ),
            ExpansionTile(
              title: Text('Stationery'),
              children: [
                ListTile(title: Text('Item 1')),
                ListTile(title: Text('Item 2')),
              ],
            ),
            ExpansionTile(
              title: Text('Printing'),
              children: [
                ListTile(title: Text('Item 1')),
                ListTile(title: Text('Item 2')),
              ],
            ),
            ExpansionTile(
              title: Text('Car'),
              children: [
                ListTile(title: Text('Item 1')),
                ListTile(title: Text('Item 2')),
              ],
            ),
            ExpansionTile(
              title: Text('Clothing'),
              children: [
                ListTile(title: Text('Item 1')),
                ListTile(title: Text('Item 2')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, String title, String detail1Title, String detail1Value, String detail2Title, String detail2Value, String subCategory) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/$subCategory.jpg'), // Replace with your item image
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('sold by XY Motors'),
                    Text('chat with owner'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetailChip(detail1Title, detail1Value),
                _buildDetailChip(detail2Title, detail2Value),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailChip(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Colors.grey)),
        Chip(
          label: Text(value),
        ),
      ],
    );
  }
}
