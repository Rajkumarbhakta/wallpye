import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wallpye/data/remote.dart';
import 'package:wallpye/models/photos.dart';
import 'package:wallpye/theme/colors.dart';

class ImagePreviewScreen extends StatelessWidget {
  const ImagePreviewScreen(this.photos, {super.key});
  final Photos photos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor(photos.avgColor!),
        title: Text(
          photos.alt == null || photos.alt!.isEmpty ? "Preview" : photos.alt!,
          style: GoogleFonts.rubik(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Hero(
              tag: photos.id!,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: photos.src!.original!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              child: OutlinedButton(
                onPressed: () async {
                  await Remote.saveImage(
                      url: photos.src!.original!,
                      fileName: photos.alt!.isEmpty || photos.alt == null
                          ? "Image"
                          : photos.alt!);

                  //Fluttertoast.showToast(msg: "Downloaded.");
                },
                child: Text(
                  "Save",
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
