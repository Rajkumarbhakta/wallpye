import 'package:wallpye/models/photos.dart';

class CuratedImage {
  int? page;
  int? perPage;
  List<Photos>? photos;
  int? totalResults;
  String? nextPage;

  CuratedImage(
      {this.page, this.perPage, this.photos, this.totalResults, this.nextPage});

  CuratedImage.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(new Photos.fromJson(v));
      });
    }
    totalResults = json['total_results'];
    nextPage = json['next_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['per_page'] = this.perPage;
    if (this.photos != null) {
      data['photos'] = this.photos!.map((v) => v.toJson()).toList();
    }
    data['total_results'] = this.totalResults;
    data['next_page'] = this.nextPage;
    return data;
  }
}