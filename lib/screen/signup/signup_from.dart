import 'package:flixflex/assistant_methode/hivebase.dart';
import 'package:flixflex/routing/app_routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:formz/formz.dart';

import '../../assistant_methode/size_config.dart';
import '../../businnes_logic/cubit/signup/sign_up_cubit.dart';
import '../../constants/strings/constants_strings.dart';
import '../../presentation/colors/color_manager.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          HiveBase.hiveBase.setIsLogin(true);
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRouter.homeRouter, (route) => false);
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Sign Up Failure')),
            );
        }
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top +
                  2 * SizeConfig.blockSizeVertical!,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: BackButton(
                color: Colors.white,
              ),
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
              height: 2 * SizeConfig.blockSizeVertical!,
            ),
            _ConfirmPasswordInput(),
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
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
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
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<SignUpCubit>().passwordChanged(password),
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

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_confirmedPasswordInput_textField'),
          onChanged: (confirmPassword) => context
              .read<SignUpCubit>()
              .confirmedPasswordChanged(confirmPassword),
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Confirm password ...',
            helperText: '',
            errorText: state.confirmedPassword.displayError != null
                ? 'passwords do not match'
                : null,
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('signUpForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: ColorManager.secondary,
                ),
                onPressed: state.isValid
                    ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                    : null,
                child: const Text(
                  ' Sign Up ',
                  style: TextStyle(color: Colors.white),
                ),
              );
      },
    );
  }
}
