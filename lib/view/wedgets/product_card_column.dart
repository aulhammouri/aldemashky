import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/product_grid_controller.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../core/constant/colors.dart';

class ProductCardColumn extends StatelessWidget {
  const ProductCardColumn({
    Key? key,
    required this.ads,
    required this.onPress,
  }) : super(key: key);

  final Map ads;
  final VoidCallback onPress;

  // تحويل الـ String إلى DateTime باستخدام intl

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductGridControllerImp>(
      builder: (controller) => GestureDetector(
        onTap: onPress,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  ads["image"] == null || ads["image"] == false
                      ? "https://aldemashqy.com/wp-content/uploads/2021/09/no_image.png"
                      : ads["image"],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 150,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child:
                          Icon(Icons.broken_image, size: 50, color: Colors.red),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Text(
                ads['title'] ?? "No title",
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(Icons.location_on,
                                    size: 20, color: Colors.grey),
                              ),
                              WidgetSpan(
                                child: SizedBox(width: 4),
                              ),
                              TextSpan(
                                text: ads['location'] ?? "Unknown location",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        //]),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Text(
                    ((ads['currency'] != null && ads['currency'] != "") &&
                            (ads['price'] != null && ads['price'] != ""))
                        ? "${ads['currency']} ${ads['price']}"
                        : ads['price_type'] == 'on_call'
                            ? "On Call".tr
                            : ads['price_type'] == 'Negotiable'
                                ? "Negotiable".tr
                                : ads['price_type'] == 'Fixed'
                                    ? "Fixed".tr
                                    : ads['price_type'] == 'auction'
                                        ? "Auction".tr
                                        : "Free".tr,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorApp.btnBgColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (ads['condition'] != null && ads['condition'] != "")
                    Text(
                      "(${ads['condition']})",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                timeago.format(
                    DateFormat("yyyy-MM-dd HH:mm:ss")
                        .parse(ads['published_date']),
                    locale: 'ar'),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.visibility, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                          "${ads['views'] == '' ? 0 : ads['views']} ${"views".tr}",
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.comment, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text("${ads['comment_count'] ?? 0} ${"comments".tr}",
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
