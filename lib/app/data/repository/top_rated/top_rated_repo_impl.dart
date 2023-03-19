import 'package:get/get.dart';
import 'package:manav_movies/app/data/remote/top_rated/top_rated_remote_data_source.dart';

import '../../../modules/top_rated/model/top_rated_model.dart';
import 'top_rated_repo.dart';

class TopRatedRepoImpl extends TopRatedRepo {
  final TopRatedDataSource homeRemoteDataSource =
      Get.find(tag: (TopRatedDataSource).toString());

  @override
  Future<TopRatedModel?> getTopRatedMovieListData(int page, String type) {
    return homeRemoteDataSource.getTopRatedMovieListData(page, type);
  }
}
