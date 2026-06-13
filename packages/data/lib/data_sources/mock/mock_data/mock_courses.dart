import 'package:data/data_sources/remote/models/course_remote.dart';

final mockCourses = <CourseRemote>[
  CourseRemote(
    id: '1',
    name: 'Dart',
    imageUrl:
        'https://uxwing.com/wp-content/themes/uxwing/download/brands-and-social-media/dart-programming-language-icon.png',
    lessonsAmount: 6,
  ),
  CourseRemote(
    id: '2',
    name: 'Flutter',
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/7/79/Flutter_logo.svg',
    lessonsAmount: 0,
  ),
];
