import 'package:manav_movies/app/data/model/movie/movies.dart';

import '../../../core/base/base_model.dart';
import '../../../core/utils/utils.dart';

class TopRatedModel extends BaseModel {
  List<Movies> listTopRatedList = [];
  int totalCount = 0;
  int totalPages = 0;
  int page = 0;

  TopRatedModel.fromJSON(Map<String, dynamic> json) : super.fromJSON(json) {
    try {
      List? bListMap = getMapCheckedValue(json, 'results', []);
      totalCount = getMapCheckedInt(json, "total_results");
      totalPages = getMapCheckedInt(json, "total_pages");
      page = getMapCheckedInt(json, "page");
      if (bListMap != null) {
        for (int i = 0; i < bListMap.length; i++) {
          Movies pModel = Movies.fromJson(bListMap[i]);
          listTopRatedList.add(pModel);
        }
      }
    } catch (e) {
      appLog(e);
    }
  }
}
