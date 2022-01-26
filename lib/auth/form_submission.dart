abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class FormSubmissionInitial extends FormSubmissionStatus {
  const FormSubmissionInitial();
}

class FormSubmissionSubmitting extends FormSubmissionStatus {}

class FormSubmissionSuccess extends FormSubmissionStatus {}

class FormSubmissionFailed extends FormSubmissionStatus {
  Exception exception;

  FormSubmissionFailed({required this.exception});
}
