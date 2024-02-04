import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpye/screens/collection_screen.dart';
import 'package:wallpye/screens/search_result_screen.dart';
import 'package:wallpye/widget/app_bar_tittle.dart';
import 'package:wallpye/widget/collection_list.dart';
import 'package:wallpye/widget/image_grid.dart';
import 'package:wallpye/widget/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _queryController = TextEditingController();

  void onSearch() {
    if (_queryController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Type something.",
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SearchResultScreen(_queryController.text),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTittle(),
      ),
      body: Column(
        children: [
          SearchBarCustom(
            onSearch: onSearch,
            queryController: _queryController,
          ),
          Container(
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Collections",
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const CollectionScreen()),
                      );
                    },
                    child: Text(
                      "see all",
                      style: GoogleFonts.lato(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 100,
            // child: Flexible(child: CollectionList()),
            child: CollectionList(),
          ),
          Container(
            height: 30,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Trending",
              style:
                  GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 15),
              textAlign: TextAlign.start,
            ),
          ),
          const Expanded(
            child: ImageGrid(),
          ),
        ],
      ),
    );
  }
}
