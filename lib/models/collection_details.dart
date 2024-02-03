import 'package:wallpye/models/photos.dart';

class CollectionDetails {
  int? page;
  int? perPage;
  List<Photos>? media;
  int? totalResults;
  String? nextPage;
  String? id;

  CollectionDetails(
      {this.page,
      this.perPage,
      this.media,
      this.totalResults,
      this.nextPage,
      this.id});

  CollectionDetails.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    if (json['media'] != null) {
      media = <Photos>[];
      json['media'].forEach((v) {
        media!.add(Photos.fromJson(v));
      });
    }
    totalResults = json['total_results'];
    nextPage = json['next_page'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['per_page'] = perPage;
    if (media != null) {
      data['media'] = media!.map((v) => v.toJson()).toList();
    }
    data['total_results'] = totalResults;
    data['next_page'] = nextPage;
    data['id'] = id;
    return data;
  }
}