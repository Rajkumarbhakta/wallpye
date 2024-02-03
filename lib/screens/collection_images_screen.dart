import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wallpye/data/remote.dart';
import 'package:wallpye/models/collections.dart';
import 'package:wallpye/models/photos.dart';
import 'package:wallpye/screens/image_preview_screen.dart';
import 'package:wallpye/widget/image_widget.dart';

class CollectionImagesScreen extends StatefulWidget {
  const CollectionImagesScreen(this.collection, {super.key});
  final Collections collection;

  @override
  State<CollectionImagesScreen> createState() => _CollectionImagesScreenState();
}

class _CollectionImagesScreenState extends State<CollectionImagesScreen> {
  static const _pageSize = 30;

  final PagingController<int, Photos> _pagingController =
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
          await Remote.collectionMedia(widget.collection.id!, page: pageKey,perPage: _pageSize);
      final isLastPage = newItems.media!.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems.media!);
      } else {
        final int nextPageKey = pageKey + newItems.media!.length;
        _pagingController.appendPage(newItems.media!, nextPageKey);
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
          widget.collection.title!,
          style: GoogleFonts.rubik(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: PagedGridView(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Photos>(
            itemBuilder: (context, item, index) => ImageWidget(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ImagePreviewScreen(item)));
              },
              photo: item,
            ),
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 3,
              crossAxisSpacing: 4,
              childAspectRatio: 0.6),
        ),
      ),
    );
  }
}
