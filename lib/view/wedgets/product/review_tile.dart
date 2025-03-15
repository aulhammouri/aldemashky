import 'package:ecommercecourse/core/constant/imageassets.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

//import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../../core/constant/colors.dart';

class ReviewTile extends StatelessWidget {
  final Map review;
  ReviewTile({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Photo
          Container(
            width: 36,
            height: 36,
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(
                image: AssetImage(ImageAssets.person),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Username - Rating - Comments
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Username - Rating
                Container(
                  margin: EdgeInsets.only(bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 8,
                        child: Text(
                          review['author'],
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: ColorApp.p_primary,
                              fontFamily: 'poppins'),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        child: SmoothStarRating(
                          allowHalfRating: false,
                          size: 16,
                          color: Colors.orange[400],
                          rating: double.parse(review['review_stars']),
                          borderColor: ColorApp.p_primarySoft,
                        ),
                      )
                    ],
                  ),
                ),
                // Comments
                Text(
                  review['content'],
                  style: TextStyle(
                      color: const Color.fromRGBO(10, 14, 47, 175),
                      height: 150 / 100),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
