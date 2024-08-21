import 'package:firebase_movies_app/data/models/movie_model.dart';
import 'package:firebase_movies_app/data/models/video_model.dart';
import 'package:firebase_movies_app/data/repositories/api_respository/i_api_repository.dart';
import 'package:firebase_movies_app/data/repositories/movies/get_movie_repository.dart';

import '../../models/api_response_model.dart';

class GetMoviesRepository {
  final IApiRepository _api;
  final GetMovieRepository _getMovieRepository;

  GetMoviesRepository(this._api, this._getMovieRepository);

  Future<(String? error, List<MovieModel> movies)> getMovies() async {
    final (String? getMoviesError, ApiResponseModel<Map>? moviesResponse) =
        await _api.get(
      '/3/discover/movie?include_adult=true&include_video=true&language=en-BR&page=1&sort_by=popularity.desc',
    );

    final moviesToReturn = <MovieModel>[];

    if (moviesResponse != null) {
      final moviesResults = moviesResponse.data['results'] as List;

      final List<Future<(String?, VideoModel?)>> moviesFuturesList =
          moviesResults
              .map<Future<(String?, VideoModel?)>>(
                (movie) =>
                    _getMovieRepository.getMovieVideo(movie['id'] as int),
              )
              .toList();

      final videosResponse = await Future.wait(moviesFuturesList);

      for (final movie in moviesResults) {
        final int videoIndex = videosResponse.indexWhere(
          (video) => video.$2?.movieId == movie['id'],
        );

        if (videoIndex != -1) {
          movie['videoKey'] = videosResponse[videoIndex].$2?.videoKey;
        }
      }

      final movies =
          moviesResults.map((movie) => MovieModel.fromJson(movie)).toList();

      moviesToReturn.addAll(movies);
    }

    return (getMoviesError, moviesToReturn);
  }
}
