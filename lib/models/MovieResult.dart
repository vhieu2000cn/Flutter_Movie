class MovieResult {
  MovieResult({
    bool? adult,
    String? backdropPath,
    List<int>? genreIds,
    int? id,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    num? popularity,
    String? posterPath,
    String? releaseDate,
    String? title,
    bool? video,
    num? voteAverage,
    int? voteCount,
  }) {
    _adult = adult;
    _backdropPath = backdropPath;
    _genreIds = genreIds;
    _id = id;
    _originalLanguage = originalLanguage;
    _originalTitle = originalTitle;
    _overview = overview;
    _popularity = popularity;
    _posterPath = posterPath;
    _releaseDate = releaseDate;
    _title = title;
    _video = video;
    _voteAverage = voteAverage;
    _voteCount = voteCount;
  }

  MovieResult.movieResult(MovieResult movieResult){
    _adult = movieResult.adult;
    _backdropPath = movieResult.backdropPath;
    _genreIds = movieResult.genreIds;
    _id = movieResult.id;
    _originalLanguage = movieResult.originalLanguage;
    _originalTitle = movieResult.originalTitle;
    _overview = movieResult.overview;
    _popularity = movieResult.popularity;
    _posterPath = movieResult.posterPath;
    _releaseDate = movieResult.releaseDate;
    _title = movieResult.title;
    _video = movieResult.video;
    _voteAverage = movieResult.voteAverage;
    _voteCount = movieResult.voteCount;
  }

  MovieResult.fromJson(dynamic json) {
    _adult = json['adult'];
    _backdropPath = json['backdrop_path'];
    _genreIds = json['genre_ids'] != null ? json['genre_ids'].cast<int>() : [];
    _id = json['id'];
    _originalLanguage = json['original_language'];
    _originalTitle = json['original_title'];
    _overview = json['overview'];
    _popularity = json['popularity'];
    _posterPath = json['poster_path'];
    _releaseDate = json['release_date'];
    _title = json['title'];
    _video = json['video'];
    _voteAverage = json['vote_average'];
    _voteCount = json['vote_count'];
  }

  bool? _adult;
  String? _backdropPath;
  List<int>? _genreIds;
  int? _id;
  String? _originalLanguage;
  String? _originalTitle;
  String? _overview;
  num? _popularity;
  String? _posterPath;
  String? _releaseDate;
  String? _title;
  bool? _video;
  num? _voteAverage;
  int? _voteCount;

  bool? get adult => _adult;

  String? get backdropPath => _backdropPath;

  List<int>? get genreIds => _genreIds;

  int? get id => _id;

  String? get originalLanguage => _originalLanguage;

  String? get originalTitle => _originalTitle;

  String? get overview => _overview;

  num? get popularity => _popularity;

  String? get posterPath => _posterPath;

  String? get releaseDate => _releaseDate;

  String? get title => _title;

  bool? get video => _video;

  num? get voteAverage => _voteAverage;

  int? get voteCount => _voteCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['adult'] = _adult;
    map['backdrop_path'] = _backdropPath;
    map['genre_ids'] = _genreIds;
    map['id'] = _id;
    map['original_language'] = _originalLanguage;
    map['original_title'] = _originalTitle;
    map['overview'] = _overview;
    map['popularity'] = _popularity;
    map['poster_path'] = _posterPath;
    map['release_date'] = _releaseDate;
    map['title'] = _title;
    map['video'] = _video;
    map['vote_average'] = _voteAverage;
    map['vote_count'] = _voteCount;
    return map;
  }

  // @override
  // String toString() {
  //   return '''{'adult': $adult,
  //       'backdrop_path': $backdropPath,
  //       'genre_ids': $genreIds,
  //       'original_language': $originalLanguage,
  //       'original_title': $originalTitle,
  //       'overview': $overview,
  //       'popularity': $popularity,
  //       'poster_path': $posterPath,
  //       'release_date': $releaseDate,
  //       'title': $title,
  //       'video': $video,
  //       'vote_average': $voteAverage,
  //       'vote_count": $voteCount
  //   }''';
  // }
}
