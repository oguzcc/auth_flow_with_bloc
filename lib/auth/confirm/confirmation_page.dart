import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../util/components/app_bar.dart';
import '../auth/auth_cubit.dart';
import 'confirmation_bloc.dart';
import '../form_submission.dart';
import '../../data/auth_repository.dart';
import '../../util/components/loading_view.dart';
import '../../util/constants.dart';

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConfirmationBloc(
        authCubit: context.read<AuthCubit>(),
        authRepository: context.read<AuthRepository>(),
      ),
      child: ConfirmationView(),
    );
  }
}

class ConfirmationView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  ConfirmationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: 'Confirmation Page'),
      body: Padding(
        padding: paddingVertical48,
        child: Center(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _confirmationForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _confirmationForm() {
    return BlocListener<ConfirmationBloc, ConfirmationState>(
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
                _confirmationCodeField(),
                const SizedBox(height: 32),
                _confirmationButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _confirmationCodeField() {
    return BlocBuilder<ConfirmationBloc, ConfirmationState>(
        builder: (context, state) => TextFormField(
              decoration: const InputDecoration(
                  icon: Icon(Icons.confirmation_num),
                  hintText: 'confirmation code'),
              validator: (value) => state.isValidConfirmationCode
                  ? null
                  : 'confirmation code must be 6 digits',
              onChanged: (value) => context
                  .read<ConfirmationBloc>()
                  .add(ConfirmationCodeChanged(confirmationCode: value)),
            ));
  }

  Widget _confirmationButton() {
    return BlocBuilder<ConfirmationBloc, ConfirmationState>(
      builder: (context, state) => state.formStatus is FormSubmissionSubmitting
          ? const LoadingView()
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<ConfirmationBloc>().add(ConfirmationSubmitted());
                }
              },
              child: const Text('Confirm'),
            ),
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
