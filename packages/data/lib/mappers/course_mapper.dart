import 'package:data/data_sources/remote/models/course_remote.dart';
import 'package:domain/models/course.dart';

extension CourseMapper on Course {
  CourseRemote toRemote() {
    return CourseRemote(
      id: id,
      name: name,
      imageUrl: imageUrl,
      lessonsAmount: lessonsAmount,
    );
  }
}

extension CourseRemoteMapper on CourseRemote {
  Course toDomain() {
    return Course(
      id: id,
      name: name,
      imageUrl: imageUrl,
      lessonsAmount: lessonsAmount,
    );
  }
}
