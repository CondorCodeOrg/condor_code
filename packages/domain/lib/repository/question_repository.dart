import 'package:domain/data_result/data_result.dart';
import 'package:domain/models/question.dart';

abstract class QuestionRepository {
  Future<DataResult<List<Question>>> getQuestions(String quizId);
}
