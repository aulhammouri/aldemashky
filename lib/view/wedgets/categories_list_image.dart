import 'package:flutter/material.dart';

class CategoriesListImage extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {
      "title": "ملابس",
      "image": "https://aldemashqy.com/wp-content/uploads/2021/09/55-17.png"
    },
    {
      "title": "أحذية",
      "image": "https://aldemashqy.com/wp-content/uploads/2021/09/55-17.png"
    },
    {
      "title": "إلكترونيات",
      "image": "https://aldemashqy.com/wp-content/uploads/2021/09/55-17.png"
    },
    {
      "title": "ساعات",
      "image": "https://aldemashqy.com/wp-content/uploads/2021/09/55-17.png"
    },
    {
      "title": "أثاث",
      "image": "https://aldemashqy.com/wp-content/uploads/2021/09/55-17.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120, // ارتفاع القائمة
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // تحديد الاتجاه الأفقي
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8), // تدوير الزوايا
                  child: Image.network(
                    categories[index]["image"]!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover, // جعل الصورة تغطي المربع بالكامل
                  ),
                ),
                const SizedBox(height: 5), // مسافة بين الصورة والنص
                Text(
                  categories[index]["title"]!,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
