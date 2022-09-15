import 'package:movie/utils/CompleteCallBack.dart';
import 'package:movie/utils/ErrorCallBack.dart';

import '../models/MovieFavouriteResultItem.dart';

abstract class MovieRepository {
  void getPopular(
      CompleteCallBack listener, ErrorCallBack error, String queryValue);

  Future<List<MovieFavouriteResultItem>> getMovieFavouriteList();
  Future<bool> insertMovieFavouriteList(MovieFavouriteResultItem movieFavouriteResultItem);
  Future<bool> deleteMovieFavouriteList(int idMovieFavouriteResultItem);
}
