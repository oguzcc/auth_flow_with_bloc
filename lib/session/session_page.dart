import '../data/auth_repository.dart';
import 'session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../util/components/app_bar.dart';

class SessionPage extends StatelessWidget {
  const SessionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SessionView();
  }
}

class SessionView extends StatelessWidget {
  const SessionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: 'Session Page'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Session View'),
            _signOutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _signOutButton(BuildContext context) {
    return TextButton(
      onPressed: context.read<SessionCubit>().signOut,
      child: const Text('Sign Out'),
    );
  }
}
