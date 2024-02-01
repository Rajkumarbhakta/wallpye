import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wallpye/models/photos.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget(this.photo, {super.key});
  final Photos photo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 0.2,
              offset: const Offset(0, 0))
        ],
      ),
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: photo.src!.medium!,
      ),
    );
  }
}
