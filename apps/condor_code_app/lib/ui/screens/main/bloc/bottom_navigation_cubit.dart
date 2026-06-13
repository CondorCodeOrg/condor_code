import 'package:flutter_bloc/flutter_bloc.dart';

/// A Cubit to manage the state of bottom navigation, emitting integer states.
/// state is bottom navigation index
class BottomNavigationCubit extends Cubit<BottomNavigationItem> {
  BottomNavigationCubit() : super(BottomNavigationItem.courses);

  void switchTab(int index) {
    emit(BottomNavigationItem.values[index]);
  }
}

enum BottomNavigationItem { courses, profile }
