import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpye/theme/colors.dart';

class SearchBarCustom extends StatefulWidget {
  const SearchBarCustom(
      {super.key, required this.onSearch, required this.queryController});
  final Function() onSearch;
  final TextEditingController queryController;
  @override
  State<SearchBarCustom> createState() => _SearchBarCustomState();
}

class _SearchBarCustomState extends State<SearchBarCustom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24), color: searchBarBackground),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                widget.onSearch();
              },
              icon: const Icon(Icons.search)),
          Expanded(
            child: TextField(
              controller: widget.queryController,
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                widget.onSearch();
              },
              decoration: InputDecoration(
                hintText: "search wallpaper",
                border: InputBorder.none,
                hintStyle: GoogleFonts.lato(),
              ),
              keyboardType: TextInputType.name,
            ),
          )
        ],
      ),
    );
  }
}
