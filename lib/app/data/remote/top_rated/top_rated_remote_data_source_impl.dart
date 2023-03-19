import '../../../core/network/dio_manager.dart';
import '../../../core/network/dio_methods.dart';
import '../../../core/values/app_constants.dart';
import '../../../modules/top_rated/model/top_rated_model.dart';
import 'top_rated_remote_data_source.dart';

class TopRatedRemoteDataSourceImpl extends TopRatedDataSource {
  @override
  Future<TopRatedModel?> getTopRatedMovieListData(int page, String type) async {
    var query = {'page': page};
    Map<String, dynamic>? rMap = await DioMethod.dioGet(
        DioManager.httpDio, AppEndpoints.movie + type,
        queryParams: query);
    if (rMap == null) {
      return null;
    }
    return TopRatedModel.fromJSON(rMap);
  }
}
