import 'package:flutter/material.dart';

class CategoriesTab extends StatelessWidget {
  final Function(CategoryDM) onCategoryClick;
  CategoriesTab({super.key, required this.onCategoryClick});

  List<CategoryDM> categories = [
    CategoryDM(id: "sports", title: "Sports", imagePath: "News App/assets/ball.png", backgroundColor: Color(0xFFC91C22)),
    CategoryDM(id: "general", title: "Politics", imagePath: "News App/assets/Politics.png", backgroundColor: Color(0xFF003E90)),
    CategoryDM(id: "health", title: "Health", imagePath: "News App/assets/health.png", backgroundColor: Color(0xFFED1E79)),
    CategoryDM(id: "business", title: "Business", imagePath: "News App/assets/bussines.png", backgroundColor: Color(0xFFCF7E48)),
    CategoryDM(id: "science", title: "Environment", imagePath: "News App/assets/environment.png", backgroundColor: Color(0xFF4882CF)), // Mapped to science
    CategoryDM(id: "science", title: "Science", imagePath: "News App/assets/science.png", backgroundColor: Color(0xFFF2D352)),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              "Pick your category \n of interest",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF4F5A69)),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.only(left: 30, right: 30),
              itemCount: categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 25, // Increased spacing for comfort
                mainAxisSpacing: 20, // Increased spacing for comfort
                childAspectRatio: 1 / 1.1,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    onCategoryClick(categories[index]);
                  },
                  child: CategoryWidget(category: categories[index], index: index),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final CategoryDM category;
  final int index;
  const CategoryWidget({super.key, required this.category, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: category.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25), // More rounded corners
          topRight: Radius.circular(25),
          bottomLeft: index % 2 == 0 ? Radius.circular(25) : Radius.circular(0),
          bottomRight: index % 2 != 0 ? Radius.circular(25) : Radius.circular(0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(category.imagePath, height: 110), // Slightly larger image
          SizedBox(height: 10),
          Text(
            category.title,
            style: TextStyle(color: Colors.white, fontSize: 22),
          )
        ],
      ),
    );
  }
}

class CategoryDM {
  String id;
  String title;
  String imagePath;
  Color backgroundColor;

  CategoryDM({required this.id, required this.title, required this.imagePath, required this.backgroundColor});
}
