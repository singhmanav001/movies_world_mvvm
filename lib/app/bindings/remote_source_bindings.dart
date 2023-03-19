import 'package:get/get.dart';

import '../data/remote/master/master_data_source.dart';
import '../data/remote/master/master_data_source_impl.dart';
import '../data/remote/popular/popular_remote_data_source.dart';
import '../data/remote/popular/popular_remote_data_source_impl.dart';
import '../data/remote/top_rated/top_rated_remote_data_source.dart';
import '../data/remote/top_rated/top_rated_remote_data_source_impl.dart';

class RemoteSourceBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopRatedDataSource>(() => TopRatedRemoteDataSourceImpl(),
        tag: (TopRatedDataSource).toString(), fenix: true);

    Get.lazyPut<PopularRemoteDataSource>(() => PopularRemoteDataSourceImpl(),
        tag: (PopularRemoteDataSource).toString(), fenix: true);

    Get.lazyPut<MasterDataSource>(
      () => MasterDataSourceImpl(),
      tag: (MasterDataSource).toString(),
      fenix: true,
    );
  }
}
