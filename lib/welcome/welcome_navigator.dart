import '../auth/login/login_page.dart';
import '../auth/signup/sign_up_page.dart';
import 'welcome_cubit.dart';
import 'welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeNavigator extends StatelessWidget {
  const WelcomeNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WelcomeCubit, WelcomeState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            if (state is WelcomeInitial)
              const MaterialPage(child: WelcomePage()),
            if (state is LoginState) const MaterialPage(child: LoginPage()),
            if (state is SignUpState) const MaterialPage(child: SignUpPage()),
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
