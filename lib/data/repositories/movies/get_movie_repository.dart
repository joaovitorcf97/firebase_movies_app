import 'package:firebase_movies_app/data/repositories/api_respository/i_api_repository.dart';

import '../../models/api_response_model.dart';
import '../../models/video_model.dart';

class GetMovieRepository {
  final IApiRepository api;

  GetMovieRepository(this.api);

  Future<(String? error, VideoModel? video)> getMovieVideo(int movieId) async {
    final (String? error, ApiResponseModel<Map>? response) = await api.get(
      '/3/movie/$movieId/videos?language=pt-BR',
    );

    if (response != null) {
      final results = response.data['results'] as List;

      if (results.isNotEmpty) {
        ((results.first) as Map)['movieId'] = movieId;
        final video = VideoModel.fromJson(results.first);

        return (null, video);
      }

      return ('Trailer não disponível', null);
    }

    return (error, null);
  }
}
