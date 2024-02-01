import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpye/theme/colors.dart';

class AppBarTittle extends StatelessWidget {
  const AppBarTittle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Text("Wall",style: GoogleFonts.rubik(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),),
      Text("Pye",style: GoogleFonts.rubik(fontWeight: FontWeight.bold,fontSize: 20,color: chryslerBlue),)
    ],);
  }
}