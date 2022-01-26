import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_cubit.dart';
import '../confirm/confirmation_page.dart';
import '../login/login_page.dart';
import '../signup/sign_up_page.dart';
import '../../welcome/welcome_cubit.dart';
import '../../welcome/welcome_navigator.dart';

class AuthNavigator extends StatelessWidget {
  const AuthNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            if (state == AuthState.welcome)
              MaterialPage(
                child: BlocProvider(
                  create: (context) =>
                      WelcomeCubit(authCubit: context.read<AuthCubit>()),
                  child: const WelcomeNavigator(),
                ),
              ),
            if (state == AuthState.login)
              const MaterialPage(child: LoginPage()),
            if (state == AuthState.signUp || state == AuthState.confirm) ...[
              const MaterialPage(child: SignUpPage()),
              if (state == AuthState.confirm)
                const MaterialPage(child: ConfirmationPage()),
            ],
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
