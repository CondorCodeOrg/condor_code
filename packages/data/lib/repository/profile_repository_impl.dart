import 'package:domain/domain.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  @override
  Future<List<Friend>> getFriends() async => [
    Friend(
      imageUrl: 'https://upload.wikimedia.org/wikipedia/en/9/90/HeathJoker.png',
      name: 'Joker',
      description: 'jbvbsbvsbfvhjsbvjhbfvsdfvsebsb',
    ),
    Friend(
      imageUrl: '',
      name: 'Batman',
      description: 'jbvbsbvsbfvhjsbvjhbfvsdfvsebsb',
    ),
    Friend(
      imageUrl: '',
      name: 'Lox',
      description: 'jbvbsbvsbfvhjsbvjhbfvsdfvsebsb',
    ),
    Friend(
      imageUrl: '',
      name: 'Valera',
      description: 'jbvbsbvsbfvhjsbvjhbfvsdfvsebsb',
    ),
    Friend(
      imageUrl: '',
      name: 'Nikita',
      description: 'jbvbsbvsbfvhjsbvjhbfvsdfvsebsb',
    ),
    Friend(
      imageUrl: '',
      name: 'Roma',
      description: 'jbvbsbvsbfvhjsbvjhbfvsdfvsebsb',
    ),
    Friend(
      imageUrl: '',
      name: 'Miha',
      description: 'jbvbsbvsbfvhjsbvjhbfvsdfvsebsb',
    ),
    Friend(
      imageUrl: '',
      name: 'Oleh',
      description: 'jbvbsbvsbfvhjsbvjhbfvsdfvsebsb',
    ),
    Friend(
      imageUrl: '',
      name: 'Alexandr',
      description: 'jbvbsbvsbfvhjsbvjhbfvsdfvsebsb',
    ),
    Friend(
      imageUrl: '',
      name: 'Lena',
      description: 'jbvbsbvsbfvhjsbvjhbfvsdfvsebsb',
    ),
    Friend(
      imageUrl: '',
      name: 'Ola',
      description: 'jbvbsbvsbfvhjsbvjhbfvsdfvsebsb',
    ),
    Friend(
      imageUrl: '',
      name: 'Vlad',
      description: 'jbvbsbvsbfvhjsbvjhbfvsdfvsebsb',
    ),
    Friend(
      imageUrl: '',
      name: 'Max',
      description: 'jbvbsbvsbfvhjsbvjhbfvsdfvsebsb',
    ),
  ];

  @override
  Future<List<Statistic>> getStatistic() async => [
    Statistic(
      value: '147',
      description: '-Daily segment',
      image: 'assets/images/fire-svgrepo-com (5).svg',
    ),
    Statistic(
      value: '5908',
      description: 'All points',
      image: 'assets/images/lightning-svgrepo-com (3).svg',
    ),
    Statistic(
      value: 'Ruby',
      description: 'Current league',
      image: 'assets/images/rubygems-svgrepo-com.svg',
    ),
    Statistic(
      value: '2',
      description: 'In the top three',
      image: 'assets/images/medal-gold-svgrepo-com.svg',
    ),
  ];

  @override
  Future<List<Achievement>> getAchievements() async => [
    Achievement(image: 'assets/images/cartoon-child-girl-svgrepo-com.svg'),
    Achievement(image: 'assets/images/archeologist-svgrepo-com.svg'),
    Achievement(image: 'assets/images/archer-svgrepo-com.svg'),
    Achievement(image: ''),
    Achievement(image: ''),
    Achievement(image: ''),
  ];

  @override
  Future<User> getUser() async => User(
    id: '1',
    fullName: 'Ellis Peters',
    email: 'peters@gmail.com',
    role: UserRole.user,
  );
}
