import 'package:flutter/material.dart';

import '../../data/datasource/static/product_data.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Popular Products",
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
              crossAxisCount: 1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 20,
              childAspectRatio: 3,
            ),
            itemBuilder: (context, index) {
              // return ProductCardRow(
              //   product:,
              //   onPress: () {},
              // );
            },
          ),
        ),
      ],
    );
  }
}
