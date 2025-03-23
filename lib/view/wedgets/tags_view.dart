import 'package:flutter/material.dart';

class TagsView extends StatelessWidget {
  final List<dynamic> tags;

  const TagsView({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50, // ارتفاع مناسب للعناصر
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // تمرير أفقي
        itemCount: tags.length,
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Chip(
              label: Text(tags[index], style: TextStyle(fontSize: 14)),
              backgroundColor: Colors.blue.shade100, // لون خفيف
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Colors.blue.shade400), // حدود خفيفة
              ),
            ),
          );
        },
      ),
    );
  }
}
