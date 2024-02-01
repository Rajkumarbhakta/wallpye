import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wallpye/data/remote.dart';
import 'package:wallpye/models/photos.dart';
import 'package:wallpye/widget/image_widget.dart';

class ImageGrid extends StatefulWidget {
  const ImageGrid({super.key});
  @override
  State<ImageGrid> createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
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
      final newItems = await Remote.curatedImage(page: pageKey);
      final isLastPage = newItems.photos!.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems.photos!);
      } else {
        final nextPageKey = pageKey + newItems.photos!.length;
        _pagingController.appendPage(newItems.photos!, nextPageKey);
      }
    } catch (e) {
      _pagingController.error = e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: PagedGridView(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Photos>(
          itemBuilder: (context, item, index) => ImageWidget(item),
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 4, crossAxisSpacing: 8),
      ),
    );
  }
}
