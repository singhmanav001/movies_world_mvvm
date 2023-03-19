import 'package:get/get.dart';
import 'package:manav_movies/app/modules/popular/model/popular_model.dart';

import '../../remote/popular/popular_remote_data_source.dart';
import 'popular_repo.dart';

class PopularListRepoImpl extends PopularListRepo {
  final PopularRemoteDataSource popularRemoteDataSource =
      Get.find(tag: (PopularRemoteDataSource).toString());

  @override
  Future<PopularModel?> getPopularMovieListData(int page, String type) async {
    return popularRemoteDataSource.getPopularMovieListData(page, type);
  }
}
