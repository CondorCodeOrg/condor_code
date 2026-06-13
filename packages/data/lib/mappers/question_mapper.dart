import 'package:data/data_sources/remote/models/question_remote.dart';
import 'package:domain/models/question.dart';

extension QuestionMapper on Question {
  QuestionRemote toRemote() {
    return QuestionRemote(
      id: id,
      lessonId: lessonId,
      title: title,
      description: description,
      firstAnswer: firstAnswer,
      secondAnswer: secondAnswer,
      thirdAnswer: thirdAnswer,
      rightAnswerNumber: rightAnswerNumber,
      imageUrl: imageUrl,
    );
  }
}

extension QuestionRemoteMapper on QuestionRemote {
  Question toDomain() {
    return Question(
      id: id,
      lessonId: lessonId,
      title: title,
      description: description,
      firstAnswer: firstAnswer,
      secondAnswer: secondAnswer,
      thirdAnswer: thirdAnswer,
      rightAnswerNumber: rightAnswerNumber,
      imageUrl: imageUrl,
    );
  }
}
