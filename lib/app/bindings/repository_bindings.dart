import 'package:get/get.dart';

import '../data/repository/master/master_data_repo.dart';
import '../data/repository/master/master_data_repo_impl.dart';
import '../data/repository/popular/popular_list_repo_impl.dart';
import '../data/repository/popular/popular_repo.dart';
import '../data/repository/top_rated/top_rated_repo.dart';
import '../data/repository/top_rated/top_rated_repo_impl.dart';

class RepositoryBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopRatedRepo>(() => TopRatedRepoImpl(), tag: (TopRatedRepo).toString(), fenix: true);

    Get.lazyPut<PopularListRepo>(() => PopularListRepoImpl(),
        tag: (PopularListRepo).toString(), fenix: true);

    Get.lazyPut<MasterDataRepo>(
      () => MasterDataRepoImpl(),
      tag: (MasterDataRepo).toString(),
      fenix: true,
    );
  }
}
