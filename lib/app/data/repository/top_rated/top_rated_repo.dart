import '../../../modules/top_rated/model/top_rated_model.dart';

abstract class TopRatedRepo {
  Future<TopRatedModel?> getTopRatedMovieListData(int page, String type);
}
