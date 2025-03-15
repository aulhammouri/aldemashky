import 'package:ecommercecourse/core/constant/imageassets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageViewer extends StatelessWidget {
  ImageViewer({required this.attachments});

  PageController productImageSlider = PageController();

  final List<dynamic> attachments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: SvgPicture.asset(
            ImageAssets.arrowleft,
            color: Colors.white,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Stack(
        children: [
          PageView(
            physics: BouncingScrollPhysics(),
            controller: productImageSlider,
            children: List.generate(
              attachments!.length,
              (index) => Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: InteractiveViewer(
                    panEnabled: true, // يسمح بالسحب
                    boundaryMargin: EdgeInsets.all(20), // هامش عند التحريك
                    minScale: 0.5, // الحد الأدنى للتصغير
                    maxScale: 4.0, // الحد الأقصى للتكبير
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Image.network(
                        attachments[index]['url'],
                        fit: BoxFit.contain,
                      ),
                    ),
                  )),
            ),
          ),

          // indicator
          Positioned(
            bottom: 16,
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: SmoothPageIndicator(
                controller: productImageSlider,
                count: attachments!.length,
                effect: ExpandingDotsEffect(
                  dotColor: const Color.fromRGBO(92, 91, 91, 0.4),
                  activeDotColor: const Color.fromRGBO(92, 91, 91, 1),
                  dotHeight: 8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
