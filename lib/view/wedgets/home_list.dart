import 'package:ecommercecourse/core/constant/approutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../core/constant/colors.dart';

class HomeList extends StatelessWidget {
  HomeList({super.key, required this.adsList, required this.type});
  final List adsList;
  final String type;
  Map ads = {};

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 215,
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // make the list horizontal
        itemCount: adsList.length,
        itemBuilder: (context, index) {
          ads = adsList[index];
          return Padding(
            padding: EdgeInsets.only(right: 5), // Spacing between items
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.productdetail, arguments: ads["id"]);
                  },
                  child: Container(
                    height: 215,
                    width: 170,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade100,
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
                            height: 100,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Icon(Icons.broken_image,
                                    size: 50, color: Colors.red),
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
                          children: [
                            Text(
                              ((ads['currency'] != null &&
                                          ads['currency'] != "") &&
                                      (ads['price'] != null &&
                                          ads['price'] != ""))
                                  ? "${ads['currency']} ${ads['price']}"
                                  : "No price".tr,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: ColorApp.btnBgColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.person, size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                                ads['author'] == "" ? "User".tr : ads['author'],
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            type == 'mostviewed'
                                ? Row(
                                    children: [
                                      Icon(Icons.visibility,
                                          size: 14, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Text("${ads['views'] ?? 0} ${"views".tr}",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey)),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      Icon(Icons.date_range,
                                          size: 14, color: Colors.grey),
                                      Text(
                                        timeago.format(
                                            DateFormat("yyyy-MM-dd HH:mm:ss")
                                                .parse(ads['publish_date']),
                                            locale: 'ar'),
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                    ],
                                  )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
