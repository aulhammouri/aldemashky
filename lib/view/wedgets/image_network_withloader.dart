import 'package:flutter/material.dart';

class ImageNetworkWithloader extends StatelessWidget {
  const ImageNetworkWithloader({super.key, required this.url});
  final String url;
  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
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
          child: Icon(Icons.broken_image, size: 50, color: Colors.red),
        );
      },
    );
  }
}
