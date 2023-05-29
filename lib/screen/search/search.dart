import 'package:flixflex/businnes_logic/bloc/search/search_bloc.dart';
import 'package:flixflex/data/repository/search.dart';
import 'package:flixflex/data/web_services/search.dart';
import 'package:flixflex/models/movie.dart';
import 'package:flixflex/presentation/laungaes/main.dart';
import 'package:flixflex/screen/home/components/shimmer.dart';
import 'package:flixflex/screen/search/components/list_view_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../assistant_methode/size_config.dart';
import '../../models/serie.dart';
import '../../presentation/colors/color_manager.dart';
import 'components/not_found.dart';

// ignore: must_be_immutable
class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  FocusNode focusNode = FocusNode();
  late final ScrollController _scrollControllerMovie;
  late final ScrollController _scrollControllerSerie;
  int nextpage = 1;
  String searchKey = '';
  List<Serie> serieResult = [];
  List<Movie> movieResult = [];
  final SearchBloc _searchBloc =
      SearchBloc(searchRepository: SearchRepository(SearchWebService()));

  void _onScrollMovie() {
    if (!_scrollControllerMovie.hasClients) return;
    final maxScroll = _scrollControllerMovie.position.maxScrollExtent;
    final currentScroll = _scrollControllerMovie.position.pixels;
    if (currentScroll == maxScroll) {
      nextpage++;

      _searchBloc
          .add(RefreshSearchMulti(nextPage: nextpage, searchKey: searchKey));
    }
  }

  void _onScrollSerie() {
    if (!_scrollControllerSerie.hasClients) return;
    final maxScroll = _scrollControllerSerie.position.maxScrollExtent;
    final currentScroll = _scrollControllerSerie.position.pixels;
    if (currentScroll == maxScroll) {
      nextpage++;

      _searchBloc
          .add(RefreshSearchMulti(nextPage: nextpage, searchKey: searchKey));
    }
  }

  @override
  void initState() {
    _scrollControllerMovie = ScrollController()..addListener(_onScrollMovie);
    _scrollControllerSerie = ScrollController()..addListener(_onScrollSerie);
    super.initState();
  }

  @override
  void dispose() {
    _scrollControllerMovie
      ..removeListener(_onScrollMovie)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top +
                  SizeConfig.blockSizeVertical!,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeVertical!),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text('Search',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 2.6 * SizeConfig.blockSizeVertical!)),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.transparent,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 4 * SizeConfig.blockSizeVertical!,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 1.6 * SizeConfig.blockSizeVertical!),
              child: TextFormField(
                autofocus: true,
                focusNode: focusNode,
                onFieldSubmitted: (value) {
                  serieResult.clear();
                  movieResult.clear();
                  focusNode.unfocus;
                  searchKey = value;
                  _searchBloc.add(SearchMulti(nextPage: 1, searchKey: value));
                },
                cursorColor: ColorManager.primary,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.search,
                      color: Color.fromARGB(255, 140, 46, 202)),
                  hintText: 'Search ...',
                ),
              ),
            ),
            SizedBox(
              height: 4 * SizeConfig.blockSizeVertical!,
            ),
            BlocConsumer<SearchBloc, SearchState>(
              bloc: _searchBloc,
              listener: (context, state) {
                if (state is RefreshSearchLoaded) {
                  for (var movie in state.searchResult['movie']) {
                    movieResult.add(movie);
                  }
                  for (var serie in state.searchResult['tv']) {
                    serieResult.add(serie);
                  }
                }
              },
              builder: (context, state) {
                if (state is SearchLoading) {
                  return ShimmerUI().listViewShimmer();
                }
                if (state is RefreshSearchLoaded) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Films',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 2.6 * SizeConfig.blockSizeVertical!),
                        ),
                      ),
                      SizedBox(
                        height: 2 * SizeConfig.blockSizeVertical!,
                      ),
                      movieResult.isNotEmpty
                          ? listViewSearch(
                              controller: _scrollControllerSerie,
                              resultSearch: movieResult,
                              isFilm: true)
                          : notFound(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Series',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 2.6 * SizeConfig.blockSizeVertical!),
                        ),
                      ),
                      SizedBox(
                        height: 2 * SizeConfig.blockSizeVertical!,
                      ),
                      serieResult.isNotEmpty
                          ? listViewSearch(
                              controller: _scrollControllerSerie,
                              resultSearch: serieResult,
                              isFilm: false)
                          : notFound()
                    ],
                  );
                }

                if (state is SearchLoaded) {
                  movieResult.clear();
                  serieResult.clear();
                  for (var movie in state.searchResult['movie']) {
                    movieResult.add(movie);
                  }
                  for (var serie in state.searchResult['tv']) {
                    serieResult.add(serie);
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Films',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 2.6 * SizeConfig.blockSizeVertical!),
                        ),
                      ),
                      SizedBox(
                        height: 2 * SizeConfig.blockSizeVertical!,
                      ),
                      movieResult.isNotEmpty
                          ? listViewSearch(
                              controller: _scrollControllerSerie,
                              resultSearch: movieResult,
                              isFilm: true)
                          : notFound(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Series',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 2.6 * SizeConfig.blockSizeVertical!),
                        ),
                      ),
                      SizedBox(
                        height: 2 * SizeConfig.blockSizeVertical!,
                      ),
                      serieResult.isNotEmpty
                          ? listViewSearch(
                              controller: _scrollControllerSerie,
                              resultSearch: serieResult,
                              isFilm: false)
                          : notFound()
                    ],
                  );
                }
                if (state is SearchError) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: Text(AppLanguage.strings.errorBloc,
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w400,
                              fontSize: 2.2 * SizeConfig.blockSizeVertical!)),
                    ),
                  );
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
