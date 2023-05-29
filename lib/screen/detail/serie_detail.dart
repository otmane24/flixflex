import 'package:flixflex/assistant_methode/size_config.dart';
import 'package:flixflex/businnes_logic/bloc/detail/detail_bloc.dart';
import 'package:flixflex/data/repository/detail.dart';
import 'package:flixflex/data/web_services/detail.dart';
import 'package:flixflex/presentation/laungaes/main.dart';
import 'package:flixflex/screen/home/components/image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../constants/strings/constants_strings.dart';
import '../../presentation/colors/color_manager.dart';
import 'components/item_detail_movie.dart';
import 'components/sub_title.dart';

class SerieDetail extends StatefulWidget {
  int id;
  SerieDetail({required this.id, super.key});

  @override
  State<SerieDetail> createState() => _SerieDetailState();
}

class _SerieDetailState extends State<SerieDetail> {
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
    detailBloc.add(GetSerieDetail(id: widget.id));
    tagsBloc.add(GetTagsSerie(id: widget.id));
    videoBloc.add(GetVideoSerie(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailState>(
      bloc: detailBloc,
      builder: (context, state) {
        if (state is SerieDetailLoading) {
          return Scaffold(
            backgroundColor: ColorManager.primary,
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is SerieDetailLoaded) {
          backdropPathImagePopularity = state.serieDetail.backdrop_path!;
          return Scaffold(
            backgroundColor: ColorManager.primary,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: ColorManager.primary,
              title: Text(
                state.serieDetail.name!,
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
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: imageMovie(
                                      imageName:
                                          state.serieDetail.poster_path!),
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
                                        state.serieDetail.name!,
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
                                        state.serieDetail.tagline!,
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
                                            double.parse(state
                                                    .serieDetail.vote_average
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
                                        children: state.serieDetail.genres!
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
                              if (state is VideoSerieLoaded) {
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
                              body: subTitle(state.serieDetail.overview!)),
                          SizedBox(
                            height: 2 * SizeConfig.blockSizeVertical!,
                          ),
                          itemDetailMovie(
                              title: 'Status:',
                              body: subTitle(state.serieDetail.status!)),
                          SizedBox(
                            height: 2 * SizeConfig.blockSizeVertical!,
                          ),
                          itemDetailMovie(
                              title: 'Type:',
                              body: subTitle(state.serieDetail.type!)),
                          SizedBox(
                            height: 2 * SizeConfig.blockSizeVertical!,
                          ),
                          itemDetailMovie(
                              title: 'Original Title:',
                              body: subTitle(state.serieDetail.original_name!)),
                          SizedBox(
                            height: 2 * SizeConfig.blockSizeVertical!,
                          ),
                          BlocBuilder<DetailBloc, DetailState>(
                            bloc: tagsBloc,
                            builder: (context, state) {
                              if (state is TagsSerieLoaded) {
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
                      detailBloc.add(GetSerieDetail(id: widget.id));
                      tagsBloc.add(GetTagsSerie(id: widget.id));
                      videoBloc.add(GetVideoSerie(id: widget.id));
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
