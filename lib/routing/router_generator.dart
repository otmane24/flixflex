import 'package:flixflex/screen/detail/movie_detail.dart';
import 'package:flixflex/screen/detail/serie_detail.dart';
import 'package:flixflex/screen/login/login.dart';

import 'package:flixflex/screen/search/search.dart';
import 'package:flixflex/screen/signup/signup_page.dart';
import 'package:flutter/material.dart';

import '../app/app.dart';

import '../screen/home/home.dart';
import 'app_routing.dart';

class RouterGenerator {
  static Route<dynamic> getRouter(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRouter.homeRouter:
        return MaterialPageRoute(
          builder: (_) => const Home(),
        );
      case AppRouter.searchRouter:
        return MaterialPageRoute(
          builder: (_) => const Search(),
        );
      case AppRouter.loginRouter:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
      case AppRouter.signupRouter:
        return MaterialPageRoute(
          builder: (_) => const SignUpPage(),
        );
      case AppRouter.movieDetailRouter:
        int id = routeSettings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => MovieDetail(id: id),
        );
      case AppRouter.serieDetailRouter:
        int id = routeSettings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => SerieDetail(id: id),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const MyApp(),
        );
    }
  }

  static Route<dynamic> unDefindedRouter() {
    return MaterialPageRoute(
        builder: ((context) => Scaffold(
              appBar: AppBar(
                title: const Text('Route Not Found'),
              ),
              body: const Center(
                child: Text('Route Not Found'),
              ),
            )));
  }
}
