import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../auth/auth/auth_cubit.dart';
import '../auth/auth/auth_navigator.dart';
import '../session/session_cubit.dart';
import '../session/session_page.dart';
import '../util/components/loading_view.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            if (state is SessionUnknown)
              const MaterialPage(child: LoadingView()),
            if (state is Unauthenticated)
              MaterialPage(
                child: BlocProvider(
                  create: (context) =>
                      AuthCubit(sessionCubit: context.read<SessionCubit>()),
                  child: const AuthNavigator(),
                ),
              ),
            if (state is Authenticated)
              const MaterialPage(child: SessionPage()),
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
