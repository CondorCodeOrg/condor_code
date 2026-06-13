import 'package:domain/models/achievement.dart';
import 'package:domain/models/friend.dart';
import 'package:domain/models/statistic.dart';
import 'package:domain/models/user.dart';

abstract class ProfileRepository {
  Future<User> getUser();

  Future<List<Friend>> getFriends();

  Future<List<Statistic>> getStatistic();

  Future<List<Achievement>> getAchievements();
}
