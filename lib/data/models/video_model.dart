class VideoModel {
  final int movieId;
  final String videoKey;

  VideoModel({required this.movieId, required this.videoKey});

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      movieId: json['movieId'] as int,
      videoKey: json['key'] as String,
    );
  }
}
