import 'dart:convert';

import 'package:wallpye/models/curated_image.dart';
import 'package:http/http.dart' as http;
import 'package:wallpye/util/api_const.dart';

class Remote {
  static const BASE_URL = "https://api.pexels.com/v1";

  static Future<CuratedImage> curatedImage({int perPage=30,  int page=1}) async {
    final response = await http.get(
        Uri.parse('$BASE_URL/curated/?page=$page&per_page=$perPage'),
        headers: ApiConst.headers);
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
      return CuratedImage.fromJson(responseJson);
    } else {
      throw Exception("Failed to load curated images.");
    }
  }
}
