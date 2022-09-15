import 'dart:convert' as Convert;

import 'package:movie/models/MovieResult.dart';

class MovieFavouriteResultItem extends MovieResult {
  bool _isFavourite = false;
  MovieResult _movieResult;

  MovieFavouriteResultItem(
      {required MovieResult movieResult, required bool isFavourite})
      : _movieResult = movieResult,
        _isFavourite = isFavourite,
        super.movieResult(movieResult);

  bool get isFavourite => _isFavourite;

  MovieResult get movieResult => _movieResult;

  set isFavourite(isFavourite) {
    _isFavourite = isFavourite;
  }

  set movieResult(movieResult) {
    _movieResult = movieResult;
  }

  factory MovieFavouriteResultItem.fromMap(Map<String, dynamic> json) =>
      MovieFavouriteResultItem(
        movieResult:
            MovieResult.fromJson(Convert.jsonDecode(json["movieResult"])),
        isFavourite: (json["isFavourite"] == 0) ? false : true,
      );

  Map<String, dynamic> toMap() => {
        "id": _movieResult.id,
        "movieResult": Convert.jsonEncode(_movieResult.toJson()),
        "isFavourite": _isFavourite
      };
}
