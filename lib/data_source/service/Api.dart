import 'package:movie/data_source/service/HttpRequest.dart';
import 'package:movie/models/MovieItem.dart';
import 'package:movie/utils/CompleteCallBack.dart';
import 'package:movie/utils/ErrorCallBack.dart';

class API {
  /// BASE_URL
  static const String BASE_URL = 'api.themoviedb.org';

  /// KEY
  static const String KEY = 'e7631ffcb8e766993e5ec0c1f4245f93';

  /// POPULAR
  static const String POPULAR = '/3/movie/popular';

  /// TOP_RATED
  static const String TOP_RATED = '/3/movie/top_rated';

  /// UP_COMING
  static const String UP_COMING = '/3/movie/upcoming';

  /// NOW_PLAYING
  static const String NOW_PLAYING = '/3/movie/now_playing';

  /// DETAIL
  static const String DETAIL = '/3/movie/{movieID}';

  /// CAST_CREW
  static const String CAST_CREW = '/3/movie/{movieID}/credits';

  /// SEARCH ex: &query={queryString}
  static const String SEARCH = '/3/search/movie/credits';

  /// GET_IMAGE
  static const String GET_IMAGE = 'image.tmdb.org/t/p/{size}/{id_image}';

  static final API _api = API._internal();

  // factory constructor
  factory API() {
    return _api;
  }

  API._internal();

  final _request = HttpRequest(API.BASE_URL);

  void getMovieByPopular(
      CompleteCallBack listener, ErrorCallBack error, String queryValue) async {
    final Map result = await _request
        .query(POPULAR, queryParameters: {'api_key': KEY, 'page': queryValue});
    if (result is Exception) {
      error(result);
      return;
    }
    MovieItem movieItem = MovieItem.fromJson(result);
    listener(movieItem.results);
  }
}
