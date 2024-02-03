import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallpye/data/remote.dart';
import 'package:wallpye/models/collections.dart';
import 'package:wallpye/screens/collection_images_screen.dart';
import 'package:wallpye/widget/collection_widget.dart';

class CollectionList extends StatefulWidget {
  const CollectionList({super.key});

  @override
  State<CollectionList> createState() => _CollectionListState();
}

class _CollectionListState extends State<CollectionList> {
  List<Collections> collections = [];

  Future<void> _fetchCollections() async {
    try {
      final collectionList = await Remote.collectionList(perPage: 10);
      setState(() {
        collections.addAll(collectionList.collections!);
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCollections();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: ListView.builder(
        itemCount: collections.isEmpty ? 0 : collections.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          return CollectionWidget(
            collection: collections[index],
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      CollectionImagesScreen(collections[index]),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
