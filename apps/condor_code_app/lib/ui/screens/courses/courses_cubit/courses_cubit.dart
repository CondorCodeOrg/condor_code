import 'package:condor_code/ui/base/bloc/base_cubit.dart';
import 'package:condor_code/ui/navigation/route_constants.dart';
import 'package:condor_code/ui/screens/courses/courses_cubit/courses_state.dart';
import 'package:domain/domain.dart';

class CoursesCubit extends BaseCubit<CoursesState> {
  CoursesCubit({
    required super.snackBarEventsProvider,
    required this.coursesRepository,
    required this.lessonsRepository,
  }) : super(const CoursesState()) {
    loadCourses();
  }

  final CoursesRepository coursesRepository;
  final LessonsRepository lessonsRepository;

  int _openCourseSeq = 0;

  Future<void> loadCourses() async {
    emit(state.copyWith(isLoading: true));
    await processDataResult(
      fetchAllCourses(),
      onSuccess: (courses) {
        if (courses.isEmpty) {
          emit(state.copyWith(isLoading: false));
        }
        emit(state.copyWith(courses: courses, isLoading: false));
      },
    );
  }

  Future<DataResult<List<Course>>> fetchAllCourses() {
    return coursesRepository.fetchAllCourses();
  }

  Future<void> openCourse(Course course) async {
    if (course.lessonsAmount == 0) {
      _emitOpenCommand(
        RouteConstants.emptyCourseScreen,
        course.name,
        course.id,
      );
      return;
    }

    await processDataResult(
      lessonsRepository.getLessonsItems(course.id),
      onSuccess: (lessons) {
        if (lessons.isEmpty) {
          _emitOpenCommand(
            RouteConstants.emptyCourseScreen,
            course.name,
            course.id,
          );
        } else {
          _emitOpenCommand(
            '${RouteConstants.course}/${course.id}/${lessons.first.id}',
            course.name,
            course.id,
          );
        }
      },
    );
  }

  void consumeOpenCommand() {
    emit(state.copyWith(openCommand: null));
  }

  void _emitOpenCommand(String location, String courseName, String courseId) {
    emit(
      state.copyWith(
        openCommand: CourseOpenCommand(
          seq: ++_openCourseSeq,
          location: location,
          courseNameExtra: courseName,
          courseId: courseId,
        ),
      ),
    );
  }
}
