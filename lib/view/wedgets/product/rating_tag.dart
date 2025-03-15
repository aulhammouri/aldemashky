import 'package:ecommercecourse/core/constant/imageassets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constant/colors.dart';

class RatingTag extends StatelessWidget {
  final double value;
  final EdgeInsetsGeometry margin;
  RatingTag({required this.value, required this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      margin: margin,
      padding: EdgeInsets.only(top: 4, bottom: 4, left: 5, right: 8),
      decoration: BoxDecoration(
          color: ColorApp.p_secondary, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            ImageAssets.starActive,
            width: 14,
            height: 14,
          ),
          SizedBox(width: 4),
          Text(
            '$value',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
