part of 'test_cubit.dart';

sealed class TestState {}

final class TestLoading extends TestState {}

final class TestLoaded extends TestState {}

final class TestMoving extends TestState {}

final class TestRightAnswer extends TestState {}

final class TestWrongAnswer extends TestState {}

final class TestWorkOnMistakes extends TestState {}

final class TestLoseHearts extends TestState {}

final class TestFinished extends TestState {}

final class TestLoadFailure extends TestState {}
