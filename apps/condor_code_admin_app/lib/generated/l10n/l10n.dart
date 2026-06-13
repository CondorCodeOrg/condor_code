// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Введіть секретний код щоб увійти як адмін`
  String get enterSecretCode {
    return Intl.message(
      'Введіть секретний код щоб увійти як адмін',
      name: 'enterSecretCode',
      desc: '',
      args: [],
    );
  }

  /// `Головна`
  String get home {
    return Intl.message('Головна', name: 'home', desc: '', args: []);
  }

  /// `Помилка аутентификации PIN-кода`
  String get errorPinAuthentication {
    return Intl.message(
      'Помилка аутентификации PIN-кода',
      name: 'errorPinAuthentication',
      desc: '',
      args: [],
    );
  }

  /// `Успішна аутентификация`
  String get authSuccess {
    return Intl.message(
      'Успішна аутентификация',
      name: 'authSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Вибачте, доступ мають лише адміни`
  String get sorryOnlyAdminCanAccess {
    return Intl.message(
      'Вибачте, доступ мають лише адміни',
      name: 'sorryOnlyAdminCanAccess',
      desc: '',
      args: [],
    );
  }

  /// `Вихід`
  String get logout {
    return Intl.message('Вихід', name: 'logout', desc: '', args: []);
  }

  /// `Вхід`
  String get signIn {
    return Intl.message('Вхід', name: 'signIn', desc: '', args: []);
  }

  /// `Реєстрація`
  String get signUp {
    return Intl.message('Реєстрація', name: 'signUp', desc: '', args: []);
  }

  /// `Створити аккаунт`
  String get createAccount {
    return Intl.message(
      'Створити аккаунт',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Введіть дані для доступа до адмінки`
  String get enterDataToAccessAdmin {
    return Intl.message(
      'Введіть дані для доступа до адмінки',
      name: 'enterDataToAccessAdmin',
      desc: '',
      args: [],
    );
  }

  /// ` Ім'я користувача`
  String get username {
    return Intl.message(
      ' Ім\'я користувача',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Пароль`
  String get password {
    return Intl.message('Пароль', name: 'password', desc: '', args: []);
  }

  /// `Електронна пошта`
  String get email {
    return Intl.message('Електронна пошта', name: 'email', desc: '', args: []);
  }

  /// `Підтвердіть пароль`
  String get confirmPassword {
    return Intl.message(
      'Підтвердіть пароль',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Вибачте, ми не можемо знайти аккаунт с цим email`
  String get sorryWeCantFindAnAccountWithThisEmail {
    return Intl.message(
      'Вибачте, ми не можемо знайти аккаунт с цим email',
      name: 'sorryWeCantFindAnAccountWithThisEmail',
      desc: '',
      args: [],
    );
  }

  /// `Неправильный email або пароль`
  String get incorrectEmailOrPassword {
    return Intl.message(
      'Неправильный email або пароль',
      name: 'incorrectEmailOrPassword',
      desc: '',
      args: [],
    );
  }

  /// `Будь ласка, впишіть валідний email`
  String get pleaseEnterAValidEmail {
    return Intl.message(
      'Будь ласка, впишіть валідний email',
      name: 'pleaseEnterAValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Щось пiшло не так. Спробуйте ще раз пізніше`
  String get somethingWentWrong {
    return Intl.message(
      'Щось пiшло не так. Спробуйте ще раз пізніше',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `або`
  String get or {
    return Intl.message('або', name: 'or', desc: '', args: []);
  }

  /// `Вiйти з Google`
  String get signInWithGoogle {
    return Intl.message(
      'Вiйти з Google',
      name: 'signInWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Ще немає аккаунта?`
  String get noAccountYet {
    return Intl.message(
      'Ще немає аккаунта?',
      name: 'noAccountYet',
      desc: '',
      args: [],
    );
  }

  /// `Вже є акаунт?`
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Вже є акаунт?',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Адмін`
  String get adminLabel {
    return Intl.message('Адмін', name: 'adminLabel', desc: '', args: []);
  }

  /// `Курси`
  String get menuCourses {
    return Intl.message('Курси', name: 'menuCourses', desc: '', args: []);
  }

  /// `Користувачі`
  String get menuUsers {
    return Intl.message('Користувачі', name: 'menuUsers', desc: '', args: []);
  }

  /// `Мій профіль`
  String get menuProfile {
    return Intl.message('Мій профіль', name: 'menuProfile', desc: '', args: []);
  }

  /// `Курси`
  String get coursesTitle {
    return Intl.message('Курси', name: 'coursesTitle', desc: '', args: []);
  }

  /// `Оберіть курс, щоб керувати його уроками`
  String get coursesSubtitle {
    return Intl.message(
      'Оберіть курс, щоб керувати його уроками',
      name: 'coursesSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Відкрити курс`
  String get openCourse {
    return Intl.message(
      'Відкрити курс',
      name: 'openCourse',
      desc: '',
      args: [],
    );
  }

  /// `Створити урок`
  String get createLesson {
    return Intl.message(
      'Створити урок',
      name: 'createLesson',
      desc: '',
      args: [],
    );
  }

  /// `Уроки`
  String get lessonsTitle {
    return Intl.message('Уроки', name: 'lessonsTitle', desc: '', args: []);
  }

  /// `Перетягніть іконку біля уроку, щоб змінити порядок (так само він відображається у застосунку).`
  String get lessonReorderHint {
    return Intl.message(
      'Перетягніть іконку біля уроку, щоб змінити порядок (так само він відображається у застосунку).',
      name: 'lessonReorderHint',
      desc: '',
      args: [],
    );
  }

  /// `Список уроків буде додано тут.`
  String get lessonsPlaceholder {
    return Intl.message(
      'Список уроків буде додано тут.',
      name: 'lessonsPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Заповніть дані уроку і додайте завдання або питання пізніше`
  String get createLessonHint {
    return Intl.message(
      'Заповніть дані уроку і додайте завдання або питання пізніше',
      name: 'createLessonHint',
      desc: '',
      args: [],
    );
  }

  /// `Питання та завдання`
  String get questionsAndTasksTitle {
    return Intl.message(
      'Питання та завдання',
      name: 'questionsAndTasksTitle',
      desc: '',
      args: [],
    );
  }

  /// `UI для питань і завдань буде додано тут.`
  String get questionsAndTasksPlaceholder {
    return Intl.message(
      'UI для питань і завдань буде додано тут.',
      name: 'questionsAndTasksPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Деталі уроку`
  String get lessonDetailsTitle {
    return Intl.message(
      'Деталі уроку',
      name: 'lessonDetailsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Не вдалося завантажити урок`
  String get lessonDetailLoadError {
    return Intl.message(
      'Не вдалося завантажити урок',
      name: 'lessonDetailLoadError',
      desc: '',
      args: [],
    );
  }

  /// `Урок не з цього курсу`
  String get lessonDetailCourseMismatch {
    return Intl.message(
      'Урок не з цього курсу',
      name: 'lessonDetailCourseMismatch',
      desc: '',
      args: [],
    );
  }

  /// `Немає завдань`
  String get lessonDetailNoTasks {
    return Intl.message(
      'Немає завдань',
      name: 'lessonDetailNoTasks',
      desc: '',
      args: [],
    );
  }

  /// `Немає питань`
  String get lessonDetailNoQuestions {
    return Intl.message(
      'Немає питань',
      name: 'lessonDetailNoQuestions',
      desc: '',
      args: [],
    );
  }

  /// `Назва`
  String get lessonTitleLabel {
    return Intl.message('Назва', name: 'lessonTitleLabel', desc: '', args: []);
  }

  /// `Тема`
  String get lessonTopicLabel {
    return Intl.message('Тема', name: 'lessonTopicLabel', desc: '', args: []);
  }

  /// `Опис`
  String get lessonDescriptionLabel {
    return Intl.message(
      'Опис',
      name: 'lessonDescriptionLabel',
      desc: '',
      args: [],
    );
  }

  /// `YouTube-урок`
  String get youtubeLessonLabel {
    return Intl.message(
      'YouTube-урок',
      name: 'youtubeLessonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Посилання на YouTube`
  String get youtubeUrlLabel {
    return Intl.message(
      'Посилання на YouTube',
      name: 'youtubeUrlLabel',
      desc: '',
      args: [],
    );
  }

  /// `Завантажити урок`
  String get uploadLesson {
    return Intl.message(
      'Завантажити урок',
      name: 'uploadLesson',
      desc: '',
      args: [],
    );
  }

  /// `Користувачі`
  String get usersTitle {
    return Intl.message('Користувачі', name: 'usersTitle', desc: '', args: []);
  }

  /// `Керування користувачами та ролями`
  String get usersSubtitle {
    return Intl.message(
      'Керування користувачами та ролями',
      name: 'usersSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Ролі користувачів`
  String get userRolesTitle {
    return Intl.message(
      'Ролі користувачів',
      name: 'userRolesTitle',
      desc: '',
      args: [],
    );
  }

  /// `UI керування ролями буде додано тут.`
  String get userRolesPlaceholder {
    return Intl.message(
      'UI керування ролями буде додано тут.',
      name: 'userRolesPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Запити на роль тестувальника`
  String get testerRequestsTitle {
    return Intl.message(
      'Запити на роль тестувальника',
      name: 'testerRequestsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Схвалення видає роль tester у Firestore і відкриває доступ до staging-додатку.`
  String get testerRequestsSubtitle {
    return Intl.message(
      'Схвалення видає роль tester у Firestore і відкриває доступ до staging-додатку.',
      name: 'testerRequestsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Немає активних запитів.`
  String get testerRequestsEmpty {
    return Intl.message(
      'Немає активних запитів.',
      name: 'testerRequestsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Схвалити (tester)`
  String get testerRequestsApprove {
    return Intl.message(
      'Схвалити (tester)',
      name: 'testerRequestsApprove',
      desc: '',
      args: [],
    );
  }

  /// `Відхилити`
  String get testerRequestsReject {
    return Intl.message(
      'Відхилити',
      name: 'testerRequestsReject',
      desc: '',
      args: [],
    );
  }

  /// `Створено`
  String get testerRequestsCreatedAt {
    return Intl.message(
      'Створено',
      name: 'testerRequestsCreatedAt',
      desc: '',
      args: [],
    );
  }

  /// `Мій профіль`
  String get profileTitle {
    return Intl.message(
      'Мій профіль',
      name: 'profileTitle',
      desc: '',
      args: [],
    );
  }

  /// `Базові дані та дії з акаунтом`
  String get profileSubtitle {
    return Intl.message(
      'Базові дані та дії з акаунтом',
      name: 'profileSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Профіль`
  String get profileCardTitle {
    return Intl.message(
      'Профіль',
      name: 'profileCardTitle',
      desc: '',
      args: [],
    );
  }

  /// `UI профілю буде додано тут.`
  String get profilePlaceholder {
    return Intl.message(
      'UI профілю буде додано тут.',
      name: 'profilePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Dart`
  String get courseDartTitle {
    return Intl.message('Dart', name: 'courseDartTitle', desc: '', args: []);
  }

  /// `Основи мови, ООП, async і колекції.`
  String get courseDartDescription {
    return Intl.message(
      'Основи мови, ООП, async і колекції.',
      name: 'courseDartDescription',
      desc: '',
      args: [],
    );
  }

  /// `Flutter`
  String get courseFlutterTitle {
    return Intl.message(
      'Flutter',
      name: 'courseFlutterTitle',
      desc: '',
      args: [],
    );
  }

  /// `Віджети, лейаути, стан та архітектура.`
  String get courseFlutterDescription {
    return Intl.message(
      'Віджети, лейаути, стан та архітектура.',
      name: 'courseFlutterDescription',
      desc: '',
      args: [],
    );
  }

  /// `Flutter для початківців`
  String get courseFlutterBegTitle {
    return Intl.message(
      'Flutter для початківців',
      name: 'courseFlutterBegTitle',
      desc: '',
      args: [],
    );
  }

  /// `Почніть з нуля і створіть перші застосунки.`
  String get courseFlutterBegDescription {
    return Intl.message(
      'Почніть з нуля і створіть перші застосунки.',
      name: 'courseFlutterBegDescription',
      desc: '',
      args: [],
    );
  }

  /// `Алгоритми`
  String get courseAlgorithmsTitle {
    return Intl.message(
      'Алгоритми',
      name: 'courseAlgorithmsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Структури даних і класичні алгоритми.`
  String get courseAlgorithmsDescription {
    return Intl.message(
      'Структури даних і класичні алгоритми.',
      name: 'courseAlgorithmsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Урок успішно завантажено`
  String get lessonUploaded {
    return Intl.message(
      'Урок успішно завантажено',
      name: 'lessonUploaded',
      desc: '',
      args: [],
    );
  }

  /// `Назва обов'язкова`
  String get lessonTitleRequired {
    return Intl.message(
      'Назва обов\'язкова',
      name: 'lessonTitleRequired',
      desc: '',
      args: [],
    );
  }

  /// `Тема обов'язкова`
  String get lessonTopicRequired {
    return Intl.message(
      'Тема обов\'язкова',
      name: 'lessonTopicRequired',
      desc: '',
      args: [],
    );
  }

  /// `Опис обов'язковий`
  String get lessonDescriptionRequired {
    return Intl.message(
      'Опис обов\'язковий',
      name: 'lessonDescriptionRequired',
      desc: '',
      args: [],
    );
  }

  /// `Посилання на YouTube обов'язкове`
  String get lessonYoutubeUrlRequired {
    return Intl.message(
      'Посилання на YouTube обов\'язкове',
      name: 'lessonYoutubeUrlRequired',
      desc: '',
      args: [],
    );
  }

  /// `Оберіть курс`
  String get lessonCourseRequired {
    return Intl.message(
      'Оберіть курс',
      name: 'lessonCourseRequired',
      desc: '',
      args: [],
    );
  }

  /// `Створити курс`
  String get createCourse {
    return Intl.message(
      'Створити курс',
      name: 'createCourse',
      desc: '',
      args: [],
    );
  }

  /// `Новий курс`
  String get createCourseTitle {
    return Intl.message(
      'Новий курс',
      name: 'createCourseTitle',
      desc: '',
      args: [],
    );
  }

  /// `Вкажіть назву курсу. Зображення — за бажанням. Уроки можна додати на сторінці курсу.`
  String get createCourseHint {
    return Intl.message(
      'Вкажіть назву курсу. Зображення — за бажанням. Уроки можна додати на сторінці курсу.',
      name: 'createCourseHint',
      desc: '',
      args: [],
    );
  }

  /// `Назва курсу`
  String get courseNameLabel {
    return Intl.message(
      'Назва курсу',
      name: 'courseNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `URL зображення (необов'язково)`
  String get courseImageUrlLabel {
    return Intl.message(
      'URL зображення (необов\'язково)',
      name: 'courseImageUrlLabel',
      desc: '',
      args: [],
    );
  }

  /// `Зберегти курс`
  String get saveCourse {
    return Intl.message(
      'Зберегти курс',
      name: 'saveCourse',
      desc: '',
      args: [],
    );
  }

  /// `Вкажіть назву курсу`
  String get courseNameRequired {
    return Intl.message(
      'Вкажіть назву курсу',
      name: 'courseNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Курс збережено`
  String get courseCreated {
    return Intl.message(
      'Курс збережено',
      name: 'courseCreated',
      desc: '',
      args: [],
    );
  }

  /// `Зберегти урок і матеріали`
  String get saveLessonBundle {
    return Intl.message(
      'Зберегти урок і матеріали',
      name: 'saveLessonBundle',
      desc: '',
      args: [],
    );
  }

  /// `Додати завдання`
  String get addTask {
    return Intl.message('Додати завдання', name: 'addTask', desc: '', args: []);
  }

  /// `Додати питання`
  String get addQuestion {
    return Intl.message(
      'Додати питання',
      name: 'addQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Завдання`
  String get taskSectionTitle {
    return Intl.message(
      'Завдання',
      name: 'taskSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Назва завдання`
  String get taskTitleLabel {
    return Intl.message(
      'Назва завдання',
      name: 'taskTitleLabel',
      desc: '',
      args: [],
    );
  }

  /// `Опис завдання`
  String get taskDescriptionLabel {
    return Intl.message(
      'Опис завдання',
      name: 'taskDescriptionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Медіа (URL)`
  String get taskMediaUrlLabel {
    return Intl.message(
      'Медіа (URL)',
      name: 'taskMediaUrlLabel',
      desc: '',
      args: [],
    );
  }

  /// `Відповідь / розбір`
  String get answerBlockTitle {
    return Intl.message(
      'Відповідь / розбір',
      name: 'answerBlockTitle',
      desc: '',
      args: [],
    );
  }

  /// `Заголовок відповіді`
  String get answerTitleLabel {
    return Intl.message(
      'Заголовок відповіді',
      name: 'answerTitleLabel',
      desc: '',
      args: [],
    );
  }

  /// `Текст відповіді`
  String get answerDescriptionLabel {
    return Intl.message(
      'Текст відповіді',
      name: 'answerDescriptionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Медіа відповіді (URL)`
  String get answerMediaUrlLabel {
    return Intl.message(
      'Медіа відповіді (URL)',
      name: 'answerMediaUrlLabel',
      desc: '',
      args: [],
    );
  }

  /// `Питання з варіантами`
  String get questionSectionTitle {
    return Intl.message(
      'Питання з варіантами',
      name: 'questionSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Текст питання`
  String get questionTitleLabel {
    return Intl.message(
      'Текст питання',
      name: 'questionTitleLabel',
      desc: '',
      args: [],
    );
  }

  /// `Опис (необов'язково)`
  String get questionDescriptionLabel {
    return Intl.message(
      'Опис (необов\'язково)',
      name: 'questionDescriptionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Зображення (URL)`
  String get questionImageUrlLabel {
    return Intl.message(
      'Зображення (URL)',
      name: 'questionImageUrlLabel',
      desc: '',
      args: [],
    );
  }

  /// `Варіант 1`
  String get answerVariant1 {
    return Intl.message(
      'Варіант 1',
      name: 'answerVariant1',
      desc: '',
      args: [],
    );
  }

  /// `Варіант 2`
  String get answerVariant2 {
    return Intl.message(
      'Варіант 2',
      name: 'answerVariant2',
      desc: '',
      args: [],
    );
  }

  /// `Варіант 3`
  String get answerVariant3 {
    return Intl.message(
      'Варіант 3',
      name: 'answerVariant3',
      desc: '',
      args: [],
    );
  }

  /// `Правильна відповідь`
  String get correctAnswerLabel {
    return Intl.message(
      'Правильна відповідь',
      name: 'correctAnswerLabel',
      desc: '',
      args: [],
    );
  }

  /// `Видалити`
  String get removeItem {
    return Intl.message('Видалити', name: 'removeItem', desc: '', args: []);
  }

  /// `Урок і матеріали збережено`
  String get lessonBundleSaved {
    return Intl.message(
      'Урок і матеріали збережено',
      name: 'lessonBundleSaved',
      desc: '',
      args: [],
    );
  }

  /// `Не вдалося завантажити уроки`
  String get courseLessonsLoadError {
    return Intl.message(
      'Не вдалося завантажити уроки',
      name: 'courseLessonsLoadError',
      desc: '',
      args: [],
    );
  }

  /// `Поки що немає уроків у цьому курсі`
  String get courseLessonsEmpty {
    return Intl.message(
      'Поки що немає уроків у цьому курсі',
      name: 'courseLessonsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Оновити список`
  String get refreshLessons {
    return Intl.message(
      'Оновити список',
      name: 'refreshLessons',
      desc: '',
      args: [],
    );
  }

  /// `Тема: {topic}`
  String lessonCardTopic(String topic) {
    return Intl.message(
      'Тема: $topic',
      name: 'lessonCardTopic',
      desc: '',
      args: [topic],
    );
  }

  /// `Зображення не додано`
  String get noImageAdded {
    return Intl.message(
      'Зображення не додано',
      name: 'noImageAdded',
      desc: '',
      args: [],
    );
  }

  /// `Оновити список`
  String get refreshCoursesList {
    return Intl.message(
      'Оновити список',
      name: 'refreshCoursesList',
      desc: '',
      args: [],
    );
  }

  /// `Повторити`
  String get retry {
    return Intl.message('Повторити', name: 'retry', desc: '', args: []);
  }

  /// `Поки що немає курсів. Натисніть «{createCourseAction}», щоб додати перший.`
  String coursesEmptyState(String createCourseAction) {
    return Intl.message(
      'Поки що немає курсів. Натисніть «$createCourseAction», щоб додати перший.',
      name: 'coursesEmptyState',
      desc: '',
      args: [createCourseAction],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'uk')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
