import 'package:firebase_core/firebase_core.dart';
import 'package:flixflex/businnes_logic/cubit/login/login_cubit.dart';
import 'package:flixflex/businnes_logic/cubit/signup/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app.dart';
import 'assistant_methode/hivebase.dart';

import 'businnes_logic/cubit/app_language_cubit.dart';
import 'data/repository/auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await HiveBase.init();
  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AppLanguageCubit>(
          create: (context) =>
              AppLanguageCubit(HiveBase.hiveBase.getLanguage() ?? "En"),
        ),
        BlocProvider<SignUpCubit>(
          create: (context) => SignUpCubit(authenticationRepository),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(authenticationRepository),
        )
      ],
      child: const MyApp(),
    ),
  );
}
