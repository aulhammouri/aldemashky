import 'package:ecommercecourse/core/constant/imageassets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageViewer extends StatefulWidget {
  final List<dynamic> attachments;

  ImageViewer({required this.attachments});

  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  PageController productImageSlider = PageController();
  double _currentScale = 1.0; // لتخزين مقياس الصورة الحالي

  // دالة تكبير الصورة عند النقر المزدوج
  void _onDoubleTap() {
    setState(() {
      if (_currentScale == 1.0) {
        _currentScale = 4.0; // الحد الأقصى للتكبير
      } else {
        _currentScale = 1.0; // العودة للحجم الطبيعي
      }
    });
  }

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
              widget.attachments.length,
              (index) => GestureDetector(
                onDoubleTap: _onDoubleTap, // إضافة ميزة النقر المزدوج
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: InteractiveViewer(
                    panEnabled: true, // يسمح بالسحب
                    boundaryMargin: EdgeInsets.all(20), // هامش عند التحريك
                    minScale: 0.5, // الحد الأدنى للتصغير
                    maxScale: 4.0, // الحد الأقصى للتكبير
                    scaleEnabled: true,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Image.network(
                        widget.attachments[index]['url'],
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
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
                count: widget.attachments.length,
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
