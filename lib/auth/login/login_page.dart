import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../util/components/app_bar.dart';
import '../auth/auth_cubit.dart';
import '../form_submission.dart';
import 'login_bloc.dart';
import '../../data/auth_repository.dart';
import '../../util/components/loading_view.dart';
import '../../util/constants.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authCubit: context.read<AuthCubit>(),
        authRepository: context.read<AuthRepository>(),
      ),
      child: LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: 'Login Page'),
      body: Padding(
        padding: paddingVertical48,
        child: Center(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _loginForm(),
              _dontHaveAnAccount(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginForm() {
    return BlocListener<LoginBloc, SignUpState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is FormSubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        }
      },
      child: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: paddingHorizontal48,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _usernameField(),
                _passwordField(),
                const SizedBox(height: 32),
                _loginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _usernameField() {
    return BlocBuilder<LoginBloc, SignUpState>(
        builder: (context, state) => TextFormField(
              decoration: const InputDecoration(
                  icon: Icon(Icons.person), hintText: 'username'),
              validator: (value) =>
                  state.isValidUsername ? null : 'username is too short',
              onChanged: (value) => context
                  .read<LoginBloc>()
                  .add(LoginUsernameChanged(username: value)),
            ));
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, SignUpState>(
        builder: (context, state) => TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                  icon: Icon(Icons.security), hintText: 'password'),
              validator: (value) =>
                  state.isValidPassword ? null : 'password is too short',
              onChanged: (value) => context
                  .read<LoginBloc>()
                  .add(LoginPasswordChanged(password: value)),
            ));
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, SignUpState>(
      builder: (context, state) => state.formStatus is FormSubmissionSubmitting
          ? const LoadingView()
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<LoginBloc>().add(LoginSubmitted());
                }
              },
              child: const Text('Login'),
            ),
    );
  }

  Widget _dontHaveAnAccount(BuildContext context) {
    return TextButton(
      onPressed: () => context.read<AuthCubit>().showSignUp(),
      child: const Text('Don\'t have an account?'),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: duration05,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
