class Collections {
  String? id;
  String? title;
  String? description;
  bool? private;
  int? mediaCount;
  int? photosCount;
  int? videosCount;

  Collections(
      {this.id,
      this.title,
      this.description,
      this.private,
      this.mediaCount,
      this.photosCount,
      this.videosCount});

  Collections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    private = json['private'];
    mediaCount = json['media_count'];
    photosCount = json['photos_count'];
    videosCount = json['videos_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['private'] = private;
    data['media_count'] = mediaCount;
    data['photos_count'] = photosCount;
    data['videos_count'] = videosCount;
    return data;
  }
}
