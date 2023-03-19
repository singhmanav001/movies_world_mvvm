import 'package:manav_movies/app/modules/popular/model/popular_model.dart';

import '../../../core/network/dio_manager.dart';
import '../../../core/network/dio_methods.dart';
import '../../../core/values/app_constants.dart';
import 'popular_remote_data_source.dart';

class PopularRemoteDataSourceImpl extends PopularRemoteDataSource {
  @override
  Future<PopularModel?> getPopularMovieListData(int page, String type) async {
    var query = {'page': page};
    Map<String, dynamic>? rMap = await DioMethod.dioGet(
        DioManager.httpDio, AppEndpoints.movie + type,
        queryParams: query);
    if (rMap == null) {
      return null;
    }
    return PopularModel.fromJSON(rMap);
  }
}
