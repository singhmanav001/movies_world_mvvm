import 'package:manav_movies/app/core/values/app_constants.dart';

import '../../../core/utils/utils.dart';

class Movies {
  final bool adult;
  final String backdropPath;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Movies.fromJson(Map<String, dynamic> json)
      : id = getMapCheckedInt(json, 'id', defaultValue: 0),
        backdropPath = getMapCheckedString(json, "backdrop_path", defaultValue: ''),
        adult = getMapCheckedBool(json, "adult", defaultValue: false),
        originalLanguage = getMapCheckedString(json, "original_language", defaultValue: ''),
        originalTitle = getMapCheckedString(json, 'original_title', defaultValue: ''),
        overview = getMapCheckedString(json, 'overview', defaultValue: ''),
        popularity = getMapCheckedDouble(json, "popularity", defaultValue: 0),
        posterPath = AppEndpoints.imageBaseUrl + getMapCheckedString(json, "poster_path", defaultValue: ''),
        releaseDate = getMapCheckedString(json, "release_date", defaultValue: ''),
        title = getMapCheckedString(json, "title", defaultValue: ''),
        video = getMapCheckedBool(json, 'video', defaultValue: false),
        voteAverage = getMapCheckedDouble(json, "vote_average", defaultValue: 0),
        voteCount = getMapCheckedInt(json, "vote_count", defaultValue: 0);
}
