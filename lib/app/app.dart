import 'package:flixflex/assistant_methode/hivebase.dart';
import 'package:flixflex/screen/home/home.dart';
import 'package:flixflex/screen/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../businnes_logic/cubit/app_language_cubit.dart';
import '../presentation/colors/color_manager.dart';
import '../presentation/laungaes/main.dart';
import '../routing/router_generator.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppLanguage.setStrings(context.watch<AppLanguageCubit>().state);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppLanguage.strings.nameApp,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorManager.light,
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 23, vertical: 16),
          hintStyle: TextStyle(
            color: ColorManager.darkGrey,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 14.0,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.darkGrey, width: 1),
            borderRadius: BorderRadius.circular(16),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.light, width: 1),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.darkGrey, width: 1),
            borderRadius: BorderRadius.circular(16),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.darkGrey, width: 1),
            borderRadius: BorderRadius.circular(16),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.primary, width: 1),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.primary, width: 1),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      onGenerateRoute: RouterGenerator.getRouter,
      home: HiveBase.hiveBase.getIsLogin() == true
          ? const Home()
          : const LoginPage(),
    );
  }
}
