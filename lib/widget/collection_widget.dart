import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpye/models/collections.dart';

class CollectionWidget extends StatelessWidget {
  const CollectionWidget({super.key,required this.collection,required this.onTap});
  final Collections collection;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
          onTap();
      },
      child: Container(
        height: 50,
        width: 100,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 0.5,
                offset: const Offset(0, 0))
          ],
          image: const DecorationImage(
              image: AssetImage("assets/images/collection_bg.jpg"),
              fit: BoxFit.cover),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 0.5,
                  offset: const Offset(0, 0))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                collection.title!,
                style: GoogleFonts.lato(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10),
                maxLines: 1,
              ),
              Text(
                "${collection.photosCount}",
                style: GoogleFonts.lato(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
