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
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 0.4,
              offset: const Offset(0, 0))
        ],
        image: DecorationImage(
          fit: BoxFit.cover,
          image: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: photo.src!.portrait!,
          ).image,
        ),
      ),
    );
  }
}
