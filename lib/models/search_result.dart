import 'package:wallpye/models/photos.dart';

class SearchResult {
  int? page;
  int? perPage;
  List<Photos>? photos;
  int? totalResults;
  String? nextPage;

  SearchResult(
      {this.page, this.perPage, this.photos, this.totalResults, this.nextPage});

  SearchResult.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(Photos.fromJson(v));
      });
    }
    totalResults = json['total_results'];
    nextPage = json['next_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['per_page'] = perPage;
    if (photos != null) {
      data['photos'] = photos!.map((v) => v.toJson()).toList();
    }
    data['total_results'] = totalResults;
    data['next_page'] = nextPage;
    return data;
  }
}