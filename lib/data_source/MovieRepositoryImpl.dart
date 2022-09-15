import 'package:movie/data_source/database/MovieDatabase.dart';
import 'package:movie/data_source/service/Api.dart';
import 'package:movie/repository/MovieRepository.dart';
import 'package:movie/utils/CompleteCallBack.dart';
import 'package:movie/utils/ErrorCallBack.dart';

import '../models/MovieFavouriteResultItem.dart';

class MovieRepositoryImpl extends MovieRepository {
  final API api = API();

  @override
  void getPopular(
      CompleteCallBack listener, ErrorCallBack error, String queryValue) {
    api.getMovieByPopular(listener, error, queryValue);
  }

  @override
  Future<List<MovieFavouriteResultItem>> getMovieFavouriteList() =>
      MovieDatabase.db.getListMovieFavourite();

  @override
  Future<bool> insertMovieFavouriteList(
          MovieFavouriteResultItem movieFavouriteResultItem) async =>
      (await MovieDatabase.db.insertMovieFavourite(movieFavouriteResultItem)) ==
              movieFavouriteResultItem.id
          ? true
          : false;

  @override
  Future<bool> deleteMovieFavouriteList(
          int idMovieFavouriteResultItem) async =>
      (await MovieDatabase.db.deleteMovieFavourite(idMovieFavouriteResultItem)) >=
              1
          ? true
          : false;
}
