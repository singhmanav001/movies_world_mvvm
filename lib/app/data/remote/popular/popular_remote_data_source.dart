import 'package:manav_movies/app/modules/popular/model/popular_model.dart';

abstract class PopularRemoteDataSource {
  Future<PopularModel?> getPopularMovieListData(int page, String type);
}
