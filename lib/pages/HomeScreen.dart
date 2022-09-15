import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie/data_source/MovieRepositoryImpl.dart';
import 'package:movie/models/MovieFavouriteResultItem.dart';
import 'package:movie/models/MovieResult.dart';
import 'package:movie/repository/MovieRepository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Navigator(
        key: _navigatorKey,
        initialRoute: "Home",
        onGenerateRoute: generateRoute);
  }

  @override
  bool get wantKeepAlive => true;

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "Home":
        return MaterialPageRoute(builder: (context) => const HomePage());
      case "Detail":
        return MaterialPageRoute(
            builder: (context) => Container(
                color: Colors.green,
                child: const Center(child: Text("Detail"))));
      default:
        return MaterialPageRoute(builder: (context) => Container());
    }
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<MovieResult> _listMovieResult = [];
  final List<MovieFavouriteResultItem?> _lisMovieFavouriteResult = [];
  late final ScrollController _scrollController;
  late final MovieRepository _movieRepository;
  bool _isShowError = false;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _movieRepository = MovieRepositoryImpl();
    _scrollController = ScrollController()..addListener(listenerLastPosition);
    loadMoreMovies();
    getMovieFavouriteList();
  }

  void listenerLastPosition() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      loadMoreMovies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: _scrollController,
        itemCount: _listMovieResult.length + 1,
        itemBuilder: (context, index) {
          if (_isShowError) {
            return AlertDialog(
              title: const Text('Error!'),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isShowError = !_isShowError;
                    });
                  },
                  child: const Text(
                    'Ok',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            );
          }
          if (index == _listMovieResult.length) {
            return Center(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: const CircularProgressIndicator(),
              ),
            );
          }
          MovieResult movieResult = _listMovieResult[index];
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movieResult.title ?? 'null',
                      style: const TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  Stack(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                'https://images.tmdb.org/t/p/w92/${movieResult.backdropPath}',
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.fill,
                            height: 100,
                            width: 80,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Release date: ${movieResult.releaseDate ?? 'null'}'),
                                Text(
                                    "Rating: ${movieResult.voteAverage ?? 'null'}/10.0"),
                                const Text("Overview: "),
                                Text(
                                  movieResult.overview ?? 'null',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          getIconAdult(movieResult.adult),
                          InkWell(
                            onTap: () async {
                              if (isFavourite(movieResult.id ?? 0)) {
                                await _movieRepository.deleteMovieFavouriteList(
                                        movieResult.id ?? 0)
                                    ? getMovieFavouriteList()
                                    : null;
                              } else {
                                await _movieRepository.insertMovieFavouriteList(
                                        MovieFavouriteResultItem(
                                            movieResult: movieResult,
                                            isFavourite: true))
                                    ? getMovieFavouriteList()
                                    : null;
                              }
                              getMovieFavouriteList();
                            },
                            customBorder: const CircleBorder(),
                            child: getIconFavourite(movieResult.id ?? 0),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(listenerLastPosition);
  }

  Widget getIconFavourite(int id) {
    Icon iconFavourite = Icon(
      isFavourite(id) ? Icons.favorite : Icons.favorite_outline,
      size: 32,
    );
    return iconFavourite;
  }

  bool isFavourite(int id) => (_lisMovieFavouriteResult
          .where((itemFavouriteResult) => itemFavouriteResult?.id == id)
          .toList()
          .isNotEmpty)
      ? true
      : false;

  Widget getIconAdult(bool? adult) {
    Widget widget = const SizedBox(
      height: 32,
      width: 32,
    );
    if (adult != null && adult) {
      widget = Image.asset(
        'assets/images/adult.jpg',
        height: 32,
        width: 32,
      );
    }
    return widget;
  }

  void loadMoreMovies() {
    currentPage = currentPage + 1;
    _movieRepository.getPopular((value) {
      setState(() {
        _listMovieResult.addAll(value);
      });
    },
        (error) => {
              setState(() {
                _isShowError = true;
              })
            },
        currentPage.toString());
  }

  void getMovieFavouriteList() async {
    _movieRepository.getMovieFavouriteList().then((listMovie) => {
          setState(() {
            _lisMovieFavouriteResult.clear();
            _lisMovieFavouriteResult.addAll(listMovie);
          })
        });
  }
}
