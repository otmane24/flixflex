import 'package:flixflex/assistant_methode/size_config.dart';
import 'package:flixflex/businnes_logic/bloc/detail/detail_bloc.dart';
import 'package:flixflex/constants/extensions/stringto_money.dart';
import 'package:flixflex/data/repository/detail.dart';
import 'package:flixflex/data/web_services/detail.dart';
import 'package:flixflex/presentation/laungaes/main.dart';
import 'package:flixflex/screen/home/components/image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../constants/strings/constants_strings.dart';
import '../../presentation/colors/color_manager.dart';
import 'components/duration.dart';
import 'components/item_detail_movie.dart';
import 'components/sub_title.dart';

class MovieDetail extends StatefulWidget {
  int id;
  MovieDetail({required this.id, super.key});

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  String backdropPathImagePopularity = '';
  DetailBloc detailBloc =
      DetailBloc(detailRepository: DetailRepository(DetailWebService()));
  DetailBloc tagsBloc =
      DetailBloc(detailRepository: DetailRepository(DetailWebService()));
  DetailBloc videoBloc =
      DetailBloc(detailRepository: DetailRepository(DetailWebService()));
  late YoutubePlayerController _controller;
  @override
  void initState() {
    detailBloc.add(GetMovieDetail(id: widget.id));
    tagsBloc.add(GetTagsMovie(id: widget.id));
    videoBloc.add(GetVideoMovie(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailState>(
      bloc: detailBloc,
      builder: (context, state) {
        if (state is MovieDetailLoading) {
          return const Scaffold(
            backgroundColor: Color(0xFF0c0f3b),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is MovieDetailLoaded) {
          backdropPathImagePopularity = state.movieDetail.backdrop_path!;
          return Scaffold(
            backgroundColor: ColorManager.primary,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: ColorManager.primary,
              title: Text(
                state.movieDetail.title!,
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 2 * SizeConfig.blockSizeVertical!),
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    children: [
                      backdropPathImagePopularity != ''
                          ? imageMovie(
                              imageName: backdropPathImagePopularity,
                              height: 25 * SizeConfig.blockSizeVertical!,
                              width: MediaQuery.of(context).size.width,
                            )
                          : SizedBox(
                              height: 25 * SizeConfig.blockSizeVertical!,
                              width: MediaQuery.of(context).size.width,
                            ),
                      if (backdropPathImagePopularity != '')
                        Column(
                          children: [
                            SizedBox(
                              height: 16 * SizeConfig.blockSizeVertical!,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                    Color.fromARGB(37, 0, 0, 0),
                                    Colors.black
                                  ])),
                              width: double.infinity,
                              height: 9 * SizeConfig.blockSizeVertical!,
                            )
                          ],
                        ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 16 * SizeConfig.blockSizeVertical!,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 16 * SizeConfig.blockSizeVertical!,
                                width: 28 * SizeConfig.blockSizeHorizontal!,
                                margin: EdgeInsets.only(
                                    left: 2 * SizeConfig.blockSizeVertical!),
                                padding: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                // height: 35 * SizeConfig.blockSizeVertical!,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: imageMovie(
                                      imageName:
                                          state.movieDetail.poster_path!),
                                ),
                              ),
                              SizedBox(
                                width: 2 * SizeConfig.blockSizeVertical!,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          2 * SizeConfig.blockSizeVertical!),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.movieDetail.title!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 2.2 *
                                                SizeConfig.blockSizeVertical!),
                                      ),
                                      SizedBox(
                                        height:
                                            .2 * SizeConfig.blockSizeVertical!,
                                      ),
                                      Text(
                                        state.movieDetail.tagline!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.grey[500],
                                            fontWeight: FontWeight.w600,
                                            fontSize: 1.6 *
                                                SizeConfig.blockSizeVertical!),
                                      ),
                                      SizedBox(
                                        height: SizeConfig.blockSizeVertical!,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          Text(
                                            durationToString(
                                                state.movieDetail.runtime),
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                overflow: TextOverflow.fade,
                                                fontSize: 1.8 *
                                                    SizeConfig
                                                        .blockSizeVertical!),
                                          ),
                                          SizedBox(
                                            width:
                                                SizeConfig.blockSizeVertical!,
                                          ),
                                          Text(
                                            '(${state.movieDetail.release_date!.split('-')[0]})',
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                overflow: TextOverflow.fade,
                                                fontSize: 1.8 *
                                                    SizeConfig
                                                        .blockSizeVertical!),
                                          ),
                                          SizedBox(
                                            width:
                                                SizeConfig.blockSizeVertical!,
                                          ),
                                          Text(
                                            double.parse(state
                                                    .movieDetail.vote_average
                                                    .toString())
                                                .toStringAsFixed(1)
                                                .toString(),
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                overflow: TextOverflow.fade,
                                                fontSize: 1.8 *
                                                    SizeConfig
                                                        .blockSizeVertical!),
                                          ),
                                          SizedBox(
                                            width: .2 *
                                                SizeConfig.blockSizeVertical!,
                                          ),
                                          Image.asset(
                                            '$pngsPath/star.png',
                                            width: 16,
                                            height: 16,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: SizeConfig.blockSizeVertical!,
                                      ),
                                      Wrap(
                                        spacing:
                                            1.2 * SizeConfig.blockSizeVertical!,
                                        children: state.movieDetail.genres!
                                            .map((genre) {
                                          return Text(
                                            genre.name!,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 1.8 *
                                                    SizeConfig
                                                        .blockSizeVertical!),
                                          );
                                        }).toList(),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2 * SizeConfig.blockSizeVertical!,
                          ),
                          BlocBuilder<DetailBloc, DetailState>(
                            bloc: videoBloc,
                            builder: (context, state) {
                              if (state is VideoMovieLoaded) {
                                _controller = YoutubePlayerController(
                                  initialVideoId: state.videoMovie.key!,
                                  flags: const YoutubePlayerFlags(
                                    autoPlay: false,
                                    mute: false,
                                  ),
                                );
                                return itemDetailMovie(
                                    title: 'Trailer:',
                                    body: YoutubePlayer(
                                      controller: _controller,
                                      showVideoProgressIndicator: true,
                                      liveUIColor: Colors.amber,
                                    ));
                              }
                              return Container();
                            },
                          ),
                          SizedBox(
                            height: 2 * SizeConfig.blockSizeVertical!,
                          ),
                          itemDetailMovie(
                              title: 'Overview:',
                              body: subTitle(state.movieDetail.overview!)),
                          SizedBox(
                            height: 2 * SizeConfig.blockSizeVertical!,
                          ),
                          itemDetailMovie(
                              title: 'Status:',
                              body: subTitle(state.movieDetail.status!)),
                          SizedBox(
                            height: 2 * SizeConfig.blockSizeVertical!,
                          ),
                          itemDetailMovie(
                              title: 'Original Title:',
                              body:
                                  subTitle(state.movieDetail.original_title!)),
                          SizedBox(
                            height: 2 * SizeConfig.blockSizeVertical!,
                          ),
                          itemDetailMovie(
                              title: 'Budget:',
                              body: subTitle(state.movieDetail.budget
                                  .toString()
                                  .formatCurrency())),
                          SizedBox(
                            height: 2 * SizeConfig.blockSizeVertical!,
                          ),
                          itemDetailMovie(
                              title: 'Revenue:',
                              body: subTitle(state.movieDetail.revenue
                                  .toString()
                                  .formatCurrency())),
                          SizedBox(
                            height: 2 * SizeConfig.blockSizeVertical!,
                          ),
                          BlocBuilder<DetailBloc, DetailState>(
                            bloc: tagsBloc,
                            builder: (context, state) {
                              if (state is TagsMovieLoaded) {
                                if (state.tags.isNotEmpty) {
                                  return itemDetailMovie(
                                      title: 'Tags:',
                                      body: Wrap(
                                        children: state.tags.map((tag) {
                                          return Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 2),
                                            child: Text(
                                              tag.name!,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 1.4 *
                                                      SizeConfig
                                                          .blockSizeVertical!),
                                            ),
                                          );
                                        }).toList(),
                                      ));
                                }
                              }
                              return Container();
                            },
                          ),
                          SizedBox(
                            height: 4 * SizeConfig.blockSizeVertical!,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        if (state is MovieDetailError) {
          return Scaffold(
            backgroundColor: ColorManager.primary,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Text(AppLanguage.strings.errorBloc,
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w400,
                            fontSize: 2.2 * SizeConfig.blockSizeVertical!)),
                  ),
                ),
                SizedBox(
                  height: 2 * SizeConfig.blockSizeVertical!,
                ),
                TextButton(
                    onPressed: () {
                      detailBloc.add(GetMovieDetail(id: widget.id));
                      tagsBloc.add(GetTagsMovie(id: widget.id));
                      videoBloc.add(GetVideoMovie(id: widget.id));
                    },
                    child: const Text('Try Again'))
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
