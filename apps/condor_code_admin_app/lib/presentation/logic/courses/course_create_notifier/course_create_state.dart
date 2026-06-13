const Object _unset = Object();

class CourseCreateState {
  final bool isProcessing;
  final String name;
  final String imageUrl;

  final bool nameError;

  final String? nameErrorMessage;

  final String? commonErrorMessage;
  final String? successMessage;

  const CourseCreateState({
    this.isProcessing = false,
    this.name = '',
    this.imageUrl = '',
    this.nameError = false,
    this.nameErrorMessage,
    this.commonErrorMessage,
    this.successMessage,
  });

  CourseCreateState copyWith({
    bool? isProcessing,
    String? name,
    String? imageUrl,
    bool? nameError,
    Object? nameErrorMessage = _unset,
    Object? commonErrorMessage = _unset,
    Object? successMessage = _unset,
  }) {
    return CourseCreateState(
      isProcessing: isProcessing ?? this.isProcessing,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      nameError: nameError ?? this.nameError,
      nameErrorMessage: identical(nameErrorMessage, _unset)
          ? this.nameErrorMessage
          : nameErrorMessage as String?,
      commonErrorMessage: identical(commonErrorMessage, _unset)
          ? this.commonErrorMessage
          : commonErrorMessage as String?,
      successMessage: identical(successMessage, _unset)
          ? this.successMessage
          : successMessage as String?,
    );
  }

  bool get hasErrorMessage => commonErrorMessage?.isNotEmpty == true;
}
