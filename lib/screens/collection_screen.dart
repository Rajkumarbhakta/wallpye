import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wallpye/data/remote.dart';
import 'package:wallpye/models/collections.dart';
import 'package:wallpye/screens/collection_images_screen.dart';
import 'package:wallpye/widget/collection_widget.dart';


class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  static const _pageSize = 30;

  final PagingController<int, Collections> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchImages(pageKey);
    });
  }

  Future<void> _fetchImages(int pageKey) async {
    try {
      final newItems =
          await Remote.collectionList(page: pageKey, perPage: _pageSize);
      final isLastPage = newItems.collections!.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems.collections!);
      } else {
        final int nextPageKey = pageKey + newItems.collections!.length;
        _pagingController.appendPage(newItems.collections!, nextPageKey);
      }
    } catch (e) {
      _pagingController.error = e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Collections",
          style: GoogleFonts.rubik(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: PagedGridView(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Collections>(
            itemBuilder: (context, item, index) => CollectionWidget(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CollectionImagesScreen(item)));
              },
              collection: item,
            ),
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 3,
            crossAxisSpacing: 4,
          ),
        ),
      ),
    );
  }
}
