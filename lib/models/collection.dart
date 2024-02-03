import 'package:wallpye/models/collections.dart';

class Collection {
  int? page;
  int? perPage;
  List<Collections>? collections;
  int? totalResults;
  String? nextPage;

  Collection(
      {this.page,
      this.perPage,
      this.collections,
      this.totalResults,
      this.nextPage});

  Collection.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    if (json['collections'] != null) {
      collections = <Collections>[];
      json['collections'].forEach((v) {
        collections!.add(Collections.fromJson(v));
      });
    }
    totalResults = json['total_results'];
    nextPage = json['next_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['per_page'] = perPage;
    if (collections != null) {
      data['collections'] = collections!.map((v) => v.toJson()).toList();
    }
    data['total_results'] = totalResults;
    data['next_page'] = nextPage;
    return data;
  }
}