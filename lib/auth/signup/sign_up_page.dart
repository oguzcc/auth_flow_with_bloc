import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../util/components/app_bar.dart';
import '../auth/auth_cubit.dart';
import '../form_submission.dart';
import 'sign_up_bloc.dart';
import '../../data/auth_repository.dart';
import '../../util/components/loading_view.dart';
import '../../util/constants.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(
        authCubit: context.read<AuthCubit>(),
        authRepository: context.read<AuthRepository>(),
      ),
      child: SignUpView(),
    );
  }
}

class SignUpView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: 'Sign Up Page'),
      body: Padding(
        padding: paddingVertical48,
        child: Center(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _signUpForm(),
              _haveAnAccount(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signUpForm() {
    return BlocListener<SignUpBloc, SignUpState>(
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
                _emailField(),
                _passwordField(),
                const SizedBox(height: 32),
                _signUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _usernameField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) => TextFormField(
              decoration: const InputDecoration(
                  icon: Icon(Icons.person), hintText: 'username'),
              validator: (value) =>
                  state.isValidUsername ? null : 'username is too short',
              onChanged: (value) => context
                  .read<SignUpBloc>()
                  .add(SignUpUsernameChanged(username: value)),
            ));
  }

  Widget _emailField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) => TextFormField(
              decoration: const InputDecoration(
                  icon: Icon(Icons.mail), hintText: 'email'),
              validator: (value) => state.isValidEmail
                  ? null
                  : 'email must contains @, length > 6',
              onChanged: (value) => context
                  .read<SignUpBloc>()
                  .add(SignUpEmailChanged(email: value)),
            ));
  }

  Widget _passwordField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) => TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                  icon: Icon(Icons.security), hintText: 'password'),
              validator: (value) =>
                  state.isValidPassword ? null : 'password is too short',
              onChanged: (value) => context
                  .read<SignUpBloc>()
                  .add(SignUpPasswordChanged(password: value)),
            ));
  }

  Widget _signUpButton() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) => state.formStatus is FormSubmissionSubmitting
          ? const LoadingView()
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<SignUpBloc>().add(SignUpSubmitted());
                }
              },
              child: const Text('Sign Up'),
            ),
    );
  }

  Widget _haveAnAccount(BuildContext context) {
    return TextButton(
      onPressed: () => context.read<AuthCubit>().showLogin(),
      child: const Text('Have an account?'),
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
