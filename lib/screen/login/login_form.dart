import 'package:flixflex/assistant_methode/size_config.dart';
import 'package:flixflex/constants/strings/constants_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:formz/formz.dart';

import '../../assistant_methode/hivebase.dart';
import '../../businnes_logic/cubit/login/login_cubit.dart';
import '../../presentation/colors/color_manager.dart';
import '../../routing/app_routing.dart';
import '../signup/signup_page.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          HiveBase.hiveBase.setIsLogin(true);

          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRouter.homeRouter, (route) => false);
        }
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        }
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top +
                  4 * SizeConfig.blockSizeVertical!,
            ),
            Image.asset(
              '$pngsPath/logoapp.png',
              width: 20 * SizeConfig.blockSizeVertical!,
              height: 20 * SizeConfig.blockSizeVertical!,
              fit: BoxFit.fill,
            ),
            Image.asset(
              '$pngsPath/logoname.png',
              width: 18 * SizeConfig.blockSizeVertical!,
              height: 18 * SizeConfig.blockSizeVertical!,
              fit: BoxFit.fill,
            ),
            _EmailInput(),
            SizedBox(
              height: 2 * SizeConfig.blockSizeVertical!,
            ),
            _PasswordInput(),
            SizedBox(
              height: SizeConfig.blockSizeVertical!,
            ),
            _LoginButton(),
            SizedBox(
              height: 2 * SizeConfig.blockSizeVertical!,
            ),
            _SignUpButton(),
            SizedBox(
              height: 10 * SizeConfig.blockSizeVertical!,
            ),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'E-mail ...',
            helperText: '',
            errorText:
                state.email.displayError != null ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Password ...',
            helperText: '',
            errorText:
                state.password.displayError != null ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: ColorManager.secondary,
                ),
                onPressed: state.isValid
                    ? () => context.read<LoginCubit>().logInWithCredentials()
                    : () {},
                child: const Text(' Login '),
              );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'You do not have an account? ',
          style: TextStyle(color: Colors.white),
        ),
        TextButton(
          key: const Key('loginForm_createAccount_flatButton'),
          onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
          child: const Text(
            'Register now',
            style: TextStyle(
                color: Color.fromARGB(255, 140, 46, 202),
                fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}
