import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ecommerce App"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              child: Image(
                image: AssetImage("assets/images/slider.jpg"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: GridView(
                shrinkWrap: true,
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: .9,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                children: const [
                  CategoryTile(
                    iconData: Icons.fastfood,
                    name: "Food",
                  ),
                  CategoryTile(
                    iconData: Icons.fastfood,
                    name: "Food",
                  ),
                  CategoryTile(
                    iconData: Icons.fastfood,
                    name: "Food",
                  ),
                  CategoryTile(
                    iconData: Icons.fastfood,
                    name: "Food",
                  ),
                  CategoryTile(
                    iconData: Icons.fastfood,
                    name: "Food",
                  ),
                  CategoryTile(
                    iconData: Icons.fastfood,
                    name: "Food",
                  ),
                ],
              ),
            ),
            SectionHeading(
              title: "Featured Products",
              button_title: "View All",
              onTap: () {},
            ),
            SizedBox(
              height: 250,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                itemBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    width: 150,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: ProductTile(
                        title: "Chanel Paris Perfume",
                        price: 'USD 100.0',
                        image: "assets/images/product1.jpg",
                      ),
                    ),
                  );
                },
              ),
            ),
            SectionHeading(
              title: "Popular Products",
              button_title: "View All",
              onTap: () {},
            ),
            SizedBox(
              height: 250,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                itemBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    width: 150,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: ProductTile(
                        title: "Chanel Paris Perfume",
                        price: 'USD 100.0',
                        image: "assets/images/product1.jpg",
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
    required this.title,
    required this.price,
    required this.image,
  });
  final String title;
  final String price;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              child: Image(
                image: AssetImage(image),
                fit: BoxFit.cover,
                width: double.maxFinite,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
            child: Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
            child: Text(price),
          ),
        ],
      ),
    );
  }
}

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.title,
    required this.button_title,
    required this.onTap,
  });
  final String title;
  final String button_title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 25),
          ),
          InkWell(
            onTap: onTap(),
            child: Text(
              button_title,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.iconData,
    required this.name,
  });
  final IconData iconData;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData),
          Text(name),
        ],
      ),
    );
  }
}
