import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/product_grid_controller.dart';
import '../../core/constant/colors.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class ProductCardRow extends StatelessWidget {
  const ProductCardRow({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.ads,
    required this.onPress,
  }) : super(key: key);

  final double width, aspectRetio;
  final Map ads;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductGridControllerImp>(
      builder: (controller) => Container(
        child: SizedBox(
          //height: 150,
          child: GestureDetector(
            onTap: onPress,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          ads["image"] == null || ads["image"] == false
                              ? "https://aldemashqy.com/wp-content/uploads/2021/09/no_image.png"
                              : ads["image"],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ads['title'] ?? "No title",
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  size: 14, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                ads['location'] ?? "Unknown location",
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          if (ads['condition'] != null &&
                              ads['condition'] != "")
                            Text(
                              "(${ads['condition']})",
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.visibility,
                                  size: 14, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text("${ads['views'] ?? 0} views",
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.comment, size: 14, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text("${ads['comment_count'] ?? 0} comments",
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ((ads['currency'] != null &&
                                        ads['currency'] != "") &&
                                    (ads['price'] != null &&
                                        ads['price'] != ""))
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
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: ColorApp.btnBgColor,
                            ),
                          ),
                          Text(
                            timeago.format(
                                DateFormat("yyyy-MM-dd HH:mm:ss")
                                    .parse(ads['published_date']),
                                locale: 'ar'),
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
