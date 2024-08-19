import 'package:firebase_movies_app/data/models/movie_model.dart';

class FavoriteMovieModel extends MovieModel {
  final String favoriteId;

  FavoriteMovieModel({
    required this.favoriteId,
    required super.id,
    required super.title,
    required super.imagePath,
    required super.overview,
    required super.releaseDate,
    required super.voteAverage,
    super.videoId,
  });

  factory FavoriteMovieModel.fromJson(
    Map<String, dynamic> json,
    String favoriteId,
  ) {
    return FavoriteMovieModel(
      favoriteId: favoriteId,
      id: json['id'] as int,
      title: json['title'] as String,
      imagePath: json['poster_path'] as String,
      overview: json['overview'] as String,
      releaseDate: DateTime.parse(json['release_date'] as String),
      voteAverage: json['vote_average'] as num,
      videoId: json['videoKey'],
    );
  }

  @override
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
