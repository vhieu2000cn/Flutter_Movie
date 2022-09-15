import 'package:flutter/material.dart';

import '../models/MovieFavouriteResultItem.dart';

class MovieListProvider with ChangeNotifier {
    List<MovieFavouriteResultItem> listMovie = [];
}