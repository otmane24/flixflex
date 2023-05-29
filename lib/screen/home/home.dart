import 'dart:ui';

import 'package:flixflex/assistant_methode/size_config.dart';
import 'package:flixflex/businnes_logic/bloc/discover/discover_bloc.dart';
import 'package:flixflex/businnes_logic/bloc/genre/genre_bloc.dart';
import 'package:flixflex/businnes_logic/cubit/state_cubit.dart';
import 'package:flixflex/data/repository/auth.dart';
import 'package:flixflex/data/repository/discover.dart';
import 'package:flixflex/data/repository/genre.dart';
import 'package:flixflex/data/web_services/discover.dart';
import 'package:flixflex/data/web_services/genre.dart';
import 'package:flixflex/models/genre.dart';
import 'package:flixflex/models/movie.dart';
import 'package:flixflex/presentation/colors/color_manager.dart';
import 'package:flixflex/routing/app_routing.dart';
import 'package:flixflex/screen/home/components/card_pageview.dart';
import 'package:flixflex/screen/home/components/genre_title.dart';
import 'package:flixflex/screen/home/components/grid_movie.dart';
import 'package:flixflex/screen/home/components/shimmer.dart';
import 'package:flixflex/screen/home/components/title_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../assistant_methode/hivebase.dart';
import '../../businnes_logic/bloc/auth/auth_bloc.dart';
import '../../models/serie.dart';
import 'components/image_network.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> keyScaffold = GlobalKey<ScaffoldState>();
  late final ScrollController _scrollController;
  final StateCubit _stateMovieCubit = StateCubit(false);
  final StateCubit _stateTypeCubit = StateCubit(false);
  final StateCubit _stateSelecteGenre = StateCubit(false);
  final AppBloc authBloc =
      AppBloc(authenticationRepository: AuthenticationRepository());
  final DiscoverBloc _discoverBloc = DiscoverBloc(
      discoverRepository: DiscoverRepository(DiscoverWebService()));
  final DiscoverBloc _discoverPopularityBloc = DiscoverBloc(
      discoverRepository: DiscoverRepository(DiscoverWebService()));
  final GenreBloc _genreBloc =
      GenreBloc(genreRepository: GenreRepository(GenreWebService()));
  List<Movie> moviesList = [];
  List<Serie> seriesList = [];
  List<Genre> nameGenre = [];
  int nextpage = 1;
  bool isFilm = true;
  int currentIndex = 0;
  String pathImagePopularity = '';
  Genre selectedGenre = Genre(id: null, name: 'All');
  String nameMovie = '';
  String vote_average = '';
  final PageController controller =
      PageController(viewportFraction: .55, initialPage: 0);
  @override
  void initState() {
    _discoverBloc.add(GetMovies(nextPage: 1));
    _discoverPopularityBloc.add(const GetPopularityMovies());
    _genreBloc.add(const GetGenreMovies());
    _scrollController = ScrollController()..addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      nextpage++;

      isFilm
          ? _discoverBloc.add(RefreshMovies(
              nextPage: nextpage, genreId: selectedGenre.id.toString()))
          : _discoverBloc.add(RefreshSerie(
              nextPage: nextpage, genreId: selectedGenre.id.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return RefreshIndicator(
      onRefresh: () async {
        if (isFilm) {
          _discoverBloc.add(GetMovies(nextPage: 1));
          _discoverPopularityBloc.add(const GetPopularityMovies());
          _genreBloc.add(const GetGenreMovies());
          _scrollController = ScrollController()..addListener(_onScroll);
        } else {
          _discoverBloc.add(GetSeries(nextPage: 1));
          _discoverPopularityBloc.add(const GetPopularitySerie());
          _genreBloc.add(const GetGenreSeries());
          _scrollController = ScrollController()..addListener(_onScroll);
        }
      },
      child: Scaffold(
        key: keyScaffold,
        backgroundColor: ColorManager.primary,
        body: BlocListener<AppBloc, AppState>(
          bloc: authBloc,
          listener: (context, state) {
            if (state.user.isEmpty) {
              HiveBase.removeAllData();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRouter.loginRouter, (route) => false);
            }
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Stack(
                  children: [
                    BlocBuilder<StateCubit, bool>(
                      bloc: _stateMovieCubit,
                      builder: (context, state) {
                        return ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: pathImagePopularity != ''
                              ? imageMovie(
                                  imageName: pathImagePopularity,
                                  height: 38 * SizeConfig.blockSizeVertical!,
                                  width: MediaQuery.of(context).size.width,
                                )
                              : SizedBox(
                                  height: 38 * SizeConfig.blockSizeVertical!,
                                  width: MediaQuery.of(context).size.width,
                                ),
                        );
                      },
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BlocBuilder<StateCubit, bool>(
                          bloc: _stateTypeCubit,
                          builder: (context, statetype) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).padding.top +
                                      1.2 * SizeConfig.blockSizeVertical!),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: .2 * SizeConfig.blockSizeVertical!,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed(AppRouter.searchRouter);
                                      },
                                      icon: Icon(
                                        Icons.search,
                                        size: 3 * SizeConfig.blockSizeVertical!,
                                        color: Colors.white,
                                      )),
                                  SizedBox(
                                    width: 2 * SizeConfig.blockSizeVertical!,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (!isFilm) {
                                        isFilm = true;
                                        pathImagePopularity = '';
                                        nameMovie = '';
                                        vote_average = '';
                                        selectedGenre =
                                            Genre(id: null, name: 'All');
                                        _genreBloc.add(const GetGenreMovies());
                                        _discoverBloc.add(GetMovies(
                                          nextPage: 1,
                                          genreId: selectedGenre.id.toString(),
                                        ));
                                        _discoverPopularityBloc
                                            .add(const GetPopularityMovies());
                                        _stateTypeCubit.setBlocState(
                                            newState: !statetype);
                                        _stateMovieCubit.setBlocState(
                                            newState: !_stateMovieCubit.state);
                                      }
                                    },
                                    child: Text(
                                      'Films',
                                      style: !isFilm
                                          ? TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 1.6 *
                                                  SizeConfig.blockSizeVertical!)
                                          : TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 5 *
                                                  SizeConfig
                                                      .blockSizeVertical!),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (isFilm) {
                                        isFilm = false;
                                        pathImagePopularity = '';
                                        nameMovie = '';
                                        vote_average = '';
                                        selectedGenre =
                                            Genre(id: null, name: 'All');
                                        _genreBloc.add(const GetGenreSeries());
                                        _discoverBloc.add(GetSeries(
                                          nextPage: 1,
                                          genreId: selectedGenre.id.toString(),
                                        ));
                                        _discoverPopularityBloc
                                            .add(const GetPopularitySerie());
                                        _stateTypeCubit.setBlocState(
                                            newState: !statetype);
                                        _stateMovieCubit.setBlocState(
                                            newState: !_stateMovieCubit.state);
                                      }
                                    },
                                    child: Text(
                                      'Series',
                                      style: isFilm
                                          ? TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 1.6 *
                                                  SizeConfig.blockSizeVertical!)
                                          : TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 5 *
                                                  SizeConfig
                                                      .blockSizeVertical!),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2 * SizeConfig.blockSizeVertical!,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        authBloc
                                            .add(const AppLogoutRequested());
                                      },
                                      icon: Icon(
                                        Icons.logout,
                                        size: 3 * SizeConfig.blockSizeVertical!,
                                        color: Colors.white,
                                      )),
                                  SizedBox(
                                    width: .2 * SizeConfig.blockSizeVertical!,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 1.6 * SizeConfig.blockSizeVertical!,
                        ),
                        BlocBuilder<DiscoverBloc, DiscoverState>(
                          bloc: _discoverPopularityBloc,
                          builder: (context, state) {
                            if (state is PopularityLoading) {
                              return ShimmerUI().pageViewShimmer(controller);
                            }
                            if (state is MoviesPopularityLoaded) {
                              pathImagePopularity =
                                  state.moviesList[0].poster_path!;
                              nameMovie = state.moviesList[0].title!;
                              currentIndex = 0;
                              vote_average =
                                  state.moviesList[0].vote_average.toString();
                              _stateMovieCubit.setBlocState(
                                  newState: !_stateMovieCubit.state);
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            2 * SizeConfig.blockSizeVertical!),
                                    child: Text('5 Top Rating:',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 2 *
                                                SizeConfig.blockSizeVertical!)),
                                  ),
                                  SizedBox(
                                    height: 1.8 * SizeConfig.blockSizeVertical!,
                                  ),
                                  SizedBox(
                                      height:
                                          32 * SizeConfig.blockSizeVertical!,
                                      child: BlocBuilder<StateCubit, bool>(
                                        bloc: _stateMovieCubit,
                                        builder: (context, stateBool) {
                                          return PageView.builder(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            controller: controller,
                                            pageSnapping: true,
                                            allowImplicitScrolling: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: 5,
                                            onPageChanged: (value) {
                                              pathImagePopularity = state
                                                  .moviesList[value]
                                                  .poster_path!;
                                              currentIndex = value;
                                              vote_average = state
                                                  .moviesList[value]
                                                  .vote_average
                                                  .toString();
                                              nameMovie = state
                                                  .moviesList[value].title!;
                                              _stateMovieCubit.setBlocState(
                                                  newState: !stateBool);
                                            },
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () => Navigator.of(
                                                        context)
                                                    .pushNamed(
                                                        AppRouter
                                                            .movieDetailRouter,
                                                        arguments: state
                                                            .moviesList[index]
                                                            .id),
                                                child: cardPageView(
                                                    image: state
                                                        .moviesList[index]
                                                        .poster_path!,
                                                    currentIndex:
                                                        currentIndex == index),
                                              );
                                            },
                                          );
                                        },
                                      )),
                                ],
                              );
                            }
                            if (state is SeriePopularityLoaded) {
                              List<Serie> seriesList = state.seriesList;
                              pathImagePopularity = seriesList[0].poster_path!;
                              nameMovie = seriesList[0].title!;
                              vote_average =
                                  state.seriesList[0].vote_average.toString();
                              currentIndex = 0;
                              _stateMovieCubit.setBlocState(
                                  newState: !_stateMovieCubit.state);

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            2 * SizeConfig.blockSizeVertical!),
                                    child: Text(
                                      '5 Top Rating:',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            2 * SizeConfig.blockSizeVertical!,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.8 * SizeConfig.blockSizeVertical!,
                                  ),
                                  Container(
                                      constraints: BoxConstraints(
                                        minHeight:
                                            25 * SizeConfig.blockSizeVertical!,
                                        maxHeight:
                                            30 * SizeConfig.blockSizeVertical!,
                                      ),
                                      height:
                                          30 * SizeConfig.blockSizeVertical!,
                                      child: BlocBuilder<StateCubit, bool>(
                                        bloc: _stateMovieCubit,
                                        builder: (context, stateBool) {
                                          return PageView.builder(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            controller: controller,
                                            pageSnapping: true,
                                            allowImplicitScrolling: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: 5,
                                            onPageChanged: (value) {
                                              nameMovie =
                                                  seriesList[value].title!;
                                              pathImagePopularity =
                                                  seriesList[value]
                                                      .poster_path!;
                                              currentIndex = value;

                                              _stateMovieCubit.setBlocState(
                                                  newState: !stateBool);
                                            },
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          AppRouter
                                                              .serieDetailRouter,
                                                          arguments: state
                                                              .seriesList[index]
                                                              .id);
                                                },
                                                child: cardPageView(
                                                    image: state
                                                        .seriesList[index]
                                                        .poster_path!,
                                                    currentIndex:
                                                        currentIndex == index),
                                              );
                                            },
                                          );
                                        },
                                      )),
                                ],
                              );
                            }
                            if (state is DiscoverError) {
                              return Center(
                                child: Text(state.message),
                              );
                            }
                            return Container();
                          },
                        ),
                        SizedBox(
                          height: 2 * SizeConfig.blockSizeVertical!,
                        ),
                        BlocBuilder<StateCubit, bool>(
                          bloc: _stateMovieCubit,
                          builder: (context, state) {
                            return titleMovie(
                                name: nameMovie, vote: vote_average);
                          },
                        ),
                        SizedBox(
                          height: 2 * SizeConfig.blockSizeVertical!,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 4 * SizeConfig.blockSizeVertical!),
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.pink, Colors.purple])),
                          height: 2,
                        ),
                        SizedBox(
                          height: 2 * SizeConfig.blockSizeVertical!,
                        ),
                        BlocBuilder<GenreBloc, GenreState>(
                          bloc: _genreBloc,
                          builder: (context, state) {
                            if (state is GenreLoading) {
                              return ShimmerUI().listGenreShimmer();
                            }
                            if (state is GenreLoaded) {
                              nameGenre.clear();
                              nameGenre.add(Genre(id: null, name: 'All'));
                              for (Genre genre in state.genres) {
                                nameGenre.add(genre);
                              }
                              return SizedBox(
                                height: 42,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 42),
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: state.genres.length + 1,
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      width:
                                          2.6 * SizeConfig.blockSizeVertical!,
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    return BlocBuilder<StateCubit, bool>(
                                      bloc: _stateSelecteGenre,
                                      builder: (context, newGenre) {
                                        return InkWell(
                                            onTap: () {
                                              selectedGenre.id =
                                                  nameGenre[index].id;
                                              _stateSelecteGenre.setBlocState(
                                                  newState: !newGenre);
                                              moviesList.clear();
                                              seriesList.clear();
                                              isFilm
                                                  ? _discoverBloc.add(GetMovies(
                                                      nextPage: 1,
                                                      genreId: selectedGenre.id
                                                          .toString()))
                                                  : _discoverBloc.add(GetSeries(
                                                      nextPage: 1,
                                                      genreId: selectedGenre.id
                                                          .toString()));
                                            },
                                            child: genreTitle(
                                                name: nameGenre[index].name!,
                                                isGenre: selectedGenre.id ==
                                                    nameGenre[index].id));
                                      },
                                    );
                                  },
                                ),
                              );
                            }
                            if (state is GenreError) {
                              return Text(
                                state.message,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.fade,
                                    fontSize:
                                        2.4 * SizeConfig.blockSizeVertical!),
                              );
                            }
                            return Container();
                          },
                        ),
                        SizedBox(
                          height: 1 * SizeConfig.blockSizeVertical!,
                        ),
                        BlocConsumer<DiscoverBloc, DiscoverState>(
                          bloc: _discoverBloc,
                          listener: (context, state) {
                            if (state is RefreshMoviesLoaded) {
                              for (var movie in state.moviesList) {
                                moviesList.add(movie);
                              }
                            }
                            if (state is RefreshSerieLoaded) {
                              for (var serie in state.seriesList) {
                                seriesList.add(serie);
                              }
                            }
                          },
                          builder: (context, state) {
                            if (state is DiscoverLoading) {
                              return ShimmerUI().gridMovieShimmer();
                            }
                            if (state is RefreshMoviesLoaded) {
                              return gridMovie(movieList: moviesList);
                            }
                            if (state is RefreshSerieLoaded) {
                              return gridMovie(movieList: seriesList);
                            }
                            if (state is MoviesLoaded) {
                              moviesList.clear();
                              for (var movie in state.moviesList) {
                                moviesList.add(movie);
                              }

                              return gridMovie(movieList: moviesList);
                            }
                            if (state is SeriesLoaded) {
                              seriesList.clear();
                              for (var serie in state.seriesList) {
                                seriesList.add(serie);
                              }
                              return gridMovie(movieList: seriesList);
                            }

                            if (state is DiscoverError) {
                              return Center(
                                child: Text(
                                  state.message,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.fade,
                                      fontSize:
                                          2.4 * SizeConfig.blockSizeVertical!),
                                ),
                              );
                            }
                            return Container();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
