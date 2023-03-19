import 'package:manav_movies/app/modules/top_rated/model/top_rated_model.dart';

abstract class TopRatedDataSource {
  Future<TopRatedModel?> getTopRatedMovieListData(int page, String type);
}
