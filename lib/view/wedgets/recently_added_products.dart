import 'package:flutter/material.dart';

import '../../data/datasource/static/product_data.dart';
import 'product_card.dart';
import 'section_title.dart';

class RecentlyAddedProducts extends StatelessWidget {
  const RecentlyAddedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Recently Added",
            press: () {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: demoProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 20,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              return ProductCard(
                product: demoProducts[index],
                onPress: () {},
              );
            },
          ),
        ),
      ],
    );
  }
}
