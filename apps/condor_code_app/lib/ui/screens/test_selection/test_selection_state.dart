class TestModel {
  final String id;
  final String title;
  final String difficulty;
  final int durationMinutes;
  final int questionCount;
  final String status;

  const TestModel({
    required this.id,
    required this.title,
    required this.difficulty,
    required this.durationMinutes,
    required this.questionCount,
    required this.status,
  });
}

sealed class TestSelectionState {
  const TestSelectionState();
}

class TestSelectionLoading extends TestSelectionState {
  const TestSelectionLoading();
}

class TestSelectionLoaded extends TestSelectionState {
  final List<TestModel> tests;
  final String? selectedTestId;
  final String lessonName;

  const TestSelectionLoaded({
    required this.tests,
    this.selectedTestId,
    required this.lessonName,
  });

  TestSelectionLoaded copyWith({
    List<TestModel>? tests,
    String? selectedTestId,
    String? lessonName,
  }) {
    return TestSelectionLoaded(
      tests: tests ?? this.tests,
      selectedTestId: selectedTestId ?? this.selectedTestId,
      lessonName: lessonName ?? this.lessonName,
    );
  }
}

class TestSelectionError extends TestSelectionState {
  final String message;
  const TestSelectionError({required this.message});
}
