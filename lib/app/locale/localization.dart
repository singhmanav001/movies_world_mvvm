import 'package:get/get.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en": {
          "home": "Home",
          "popular": "Popular",
          "top_rated": "Top Rated",
          "something_went_wrong": "Something Went Wrong!",
          "no_internet_message": "Please check your internet connection",
          "no_records_found": "Opps!!! No Records Found!",
        },
        "hi": {
          "home": "Home",
        },
      };
}
