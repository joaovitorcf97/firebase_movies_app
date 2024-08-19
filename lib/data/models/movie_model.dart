class MovieModel {
  final int id;
  final String title;
  final String imagePath;
  final String overview;
  final DateTime releaseDate;
  final num voteAverage;
  final String? videoId;

  MovieModel({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    this.videoId,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] as int,
      title: json['title'] as String,
      imagePath: json['poster_path'] as String,
      overview: json['overview'] as String,
      releaseDate: DateTime.parse(json['release_date'] as String),
      voteAverage: json['vote_average'] as num,
      videoId: json['videoKey'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'poster_path': imagePath,
      'overview': overview,
      'release_date': releaseDate.toIso8601String(),
      'vote_average': voteAverage,
      'videoKey': videoId,
    };
  }
}
