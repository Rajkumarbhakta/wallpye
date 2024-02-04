import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallpye/models/collection.dart';
import 'package:wallpye/models/collection_details.dart';
import 'package:wallpye/models/curated_image.dart';
import 'package:http/http.dart' as http;
import 'package:wallpye/models/photos.dart';
import 'package:wallpye/models/search_result.dart';
import 'package:wallpye/util/api_const.dart';

class Remote {
  static const _BASE_URL = "https://api.pexels.com/v1";

  static Future<CuratedImage> curatedImage(
      {int perPage = 30, int page = 1}) async {
    final response = await http.get(
        Uri.parse('$_BASE_URL/curated/?page=$page&per_page=$perPage'),
        headers: ApiConst.headers);
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
      return CuratedImage.fromJson(responseJson);
    } else {
      throw Exception("Failed to load curated images.");
    }
  }

  static Future<Collection> collectionList(
      {int perPage = 5, int page = 1}) async {
    final response = await http.get(
        Uri.parse(
            "$_BASE_URL/collections/featured?page=$page&&per_page=$perPage"),
        headers: ApiConst.headers);
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
      return Collection.fromJson(responseJson);
    } else {
      throw Exception("Failed to load collections.");
    }
  }

  static Future<CollectionDetails> collectionMedia(String id,
      {int perPage = 5, int page = 1}) async {
    final response = await http.get(
        Uri.parse(
            "$_BASE_URL/collections/$id?per_page=$perPage&type=photos&page=$page"),
        headers: ApiConst.headers);
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
      return CollectionDetails.fromJson(responseJson);
    } else {
      throw Exception("Failed to load collection media.");
    }
  }

  static Future<SearchResult> search(
      {int page = 1, int perPage = 20, required String query}) async {
    final response = await http.get(
        Uri.parse(
            "$_BASE_URL/search?query=$query&per_page=$perPage&page=$page"),
        headers: ApiConst.headers);

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
      return SearchResult.fromJson(responseJson);
    } else {
      throw Exception("Failed to load collection media.");
    }
  }

  static Future<void> saveImage(
      {required String url, required String fileName}) async {
    try {
      final http.Response response = await http.get(Uri.parse(url));
      final dir = await getDownloadsDirectory();
      var filePath = '${dir?.path}/$fileName.png';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final finalPath = await FlutterFileDialog.saveFile(params: params);
      //print("FINAL PATH : $finalPath");
      if (finalPath != null) {
        Fluttertoast.showToast(msg: "Saved successfully.");
      } else {
        Fluttertoast.showToast(msg: "Canceled by the user.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong!");
    }
  }
}
