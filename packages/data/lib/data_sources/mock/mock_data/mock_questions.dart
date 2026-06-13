import 'package:data/data_sources/remote/models/question_remote.dart';

final mockQuestions = <QuestionRemote>[
  QuestionRemote(
    id: 'mock-q1',
    lessonId: '2',
    title: 'What is Dart?',
    description: 'Choose the correct definition of Dart.',
    firstAnswer: 'A programming language developed by Google.',
    secondAnswer: 'A database management system.',
    thirdAnswer: 'A web browser.',
    rightAnswerNumber: 1,
  ),
  QuestionRemote(
    id: 'mock-q2',
    lessonId: '2',
    title: 'Which keyword is used to declare a variable in Dart?',
    description: 'Select the correct keyword for variable declaration.',
    firstAnswer: 'var',
    secondAnswer: 'int',
    thirdAnswer: 'let',
    rightAnswerNumber: 1,
  ),
  QuestionRemote(
    id: 'mock-q3',
    lessonId: '2',
    title: 'How do you define a function in Dart?',
    description: 'Pick the correct syntax for a Dart function.',
    firstAnswer: 'function myFunc() {}',
    secondAnswer: 'void myFunc() {}',
    thirdAnswer: 'def myFunc() {}',
    rightAnswerNumber: 2,
  ),
];
