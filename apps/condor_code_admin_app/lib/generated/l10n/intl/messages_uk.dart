// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a uk locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'uk';

  static String m0(createCourseAction) =>
      "Поки що немає курсів. Натисніть «${createCourseAction}», щоб додати перший.";

  static String m1(topic) => "Тема: ${topic}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "addQuestion": MessageLookupByLibrary.simpleMessage("Додати питання"),
    "addTask": MessageLookupByLibrary.simpleMessage("Додати завдання"),
    "adminLabel": MessageLookupByLibrary.simpleMessage("Адмін"),
    "alreadyHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "Вже є акаунт?",
    ),
    "answerBlockTitle": MessageLookupByLibrary.simpleMessage(
      "Відповідь / розбір",
    ),
    "answerDescriptionLabel": MessageLookupByLibrary.simpleMessage(
      "Текст відповіді",
    ),
    "answerMediaUrlLabel": MessageLookupByLibrary.simpleMessage(
      "Медіа відповіді (URL)",
    ),
    "answerTitleLabel": MessageLookupByLibrary.simpleMessage(
      "Заголовок відповіді",
    ),
    "answerVariant1": MessageLookupByLibrary.simpleMessage("Варіант 1"),
    "answerVariant2": MessageLookupByLibrary.simpleMessage("Варіант 2"),
    "answerVariant3": MessageLookupByLibrary.simpleMessage("Варіант 3"),
    "authSuccess": MessageLookupByLibrary.simpleMessage(
      "Успішна аутентификация",
    ),
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "Підтвердіть пароль",
    ),
    "correctAnswerLabel": MessageLookupByLibrary.simpleMessage(
      "Правильна відповідь",
    ),
    "courseAlgorithmsDescription": MessageLookupByLibrary.simpleMessage(
      "Структури даних і класичні алгоритми.",
    ),
    "courseAlgorithmsTitle": MessageLookupByLibrary.simpleMessage("Алгоритми"),
    "courseCreated": MessageLookupByLibrary.simpleMessage("Курс збережено"),
    "courseDartDescription": MessageLookupByLibrary.simpleMessage(
      "Основи мови, ООП, async і колекції.",
    ),
    "courseDartTitle": MessageLookupByLibrary.simpleMessage("Dart"),
    "courseFlutterBegDescription": MessageLookupByLibrary.simpleMessage(
      "Почніть з нуля і створіть перші застосунки.",
    ),
    "courseFlutterBegTitle": MessageLookupByLibrary.simpleMessage(
      "Flutter для початківців",
    ),
    "courseFlutterDescription": MessageLookupByLibrary.simpleMessage(
      "Віджети, лейаути, стан та архітектура.",
    ),
    "courseFlutterTitle": MessageLookupByLibrary.simpleMessage("Flutter"),
    "courseImageUrlLabel": MessageLookupByLibrary.simpleMessage(
      "URL зображення (необов\'язково)",
    ),
    "courseLessonsEmpty": MessageLookupByLibrary.simpleMessage(
      "Поки що немає уроків у цьому курсі",
    ),
    "courseLessonsLoadError": MessageLookupByLibrary.simpleMessage(
      "Не вдалося завантажити уроки",
    ),
    "courseNameLabel": MessageLookupByLibrary.simpleMessage("Назва курсу"),
    "courseNameRequired": MessageLookupByLibrary.simpleMessage(
      "Вкажіть назву курсу",
    ),
    "coursesEmptyState": m0,
    "coursesSubtitle": MessageLookupByLibrary.simpleMessage(
      "Оберіть курс, щоб керувати його уроками",
    ),
    "coursesTitle": MessageLookupByLibrary.simpleMessage("Курси"),
    "createAccount": MessageLookupByLibrary.simpleMessage("Створити аккаунт"),
    "createCourse": MessageLookupByLibrary.simpleMessage("Створити курс"),
    "createCourseHint": MessageLookupByLibrary.simpleMessage(
      "Вкажіть назву курсу. Зображення — за бажанням. Уроки можна додати на сторінці курсу.",
    ),
    "createCourseTitle": MessageLookupByLibrary.simpleMessage("Новий курс"),
    "createLesson": MessageLookupByLibrary.simpleMessage("Створити урок"),
    "createLessonHint": MessageLookupByLibrary.simpleMessage(
      "Заповніть дані уроку і додайте завдання або питання пізніше",
    ),
    "email": MessageLookupByLibrary.simpleMessage("Електронна пошта"),
    "enterDataToAccessAdmin": MessageLookupByLibrary.simpleMessage(
      "Введіть дані для доступа до адмінки",
    ),
    "enterSecretCode": MessageLookupByLibrary.simpleMessage(
      "Введіть секретний код щоб увійти як адмін",
    ),
    "errorPinAuthentication": MessageLookupByLibrary.simpleMessage(
      "Помилка аутентификации PIN-кода",
    ),
    "home": MessageLookupByLibrary.simpleMessage("Головна"),
    "incorrectEmailOrPassword": MessageLookupByLibrary.simpleMessage(
      "Неправильный email або пароль",
    ),
    "lessonBundleSaved": MessageLookupByLibrary.simpleMessage(
      "Урок і матеріали збережено",
    ),
    "lessonCardTopic": m1,
    "lessonCourseRequired": MessageLookupByLibrary.simpleMessage(
      "Оберіть курс",
    ),
    "lessonDescriptionLabel": MessageLookupByLibrary.simpleMessage("Опис"),
    "lessonDescriptionRequired": MessageLookupByLibrary.simpleMessage(
      "Опис обов\'язковий",
    ),
    "lessonDetailCourseMismatch": MessageLookupByLibrary.simpleMessage(
      "Урок не з цього курсу",
    ),
    "lessonDetailLoadError": MessageLookupByLibrary.simpleMessage(
      "Не вдалося завантажити урок",
    ),
    "lessonDetailNoQuestions": MessageLookupByLibrary.simpleMessage(
      "Немає питань",
    ),
    "lessonDetailNoTasks": MessageLookupByLibrary.simpleMessage(
      "Немає завдань",
    ),
    "lessonDetailsTitle": MessageLookupByLibrary.simpleMessage("Деталі уроку"),
    "lessonReorderHint": MessageLookupByLibrary.simpleMessage(
      "Перетягніть іконку біля уроку, щоб змінити порядок (так само він відображається у застосунку).",
    ),
    "lessonTitleLabel": MessageLookupByLibrary.simpleMessage("Назва"),
    "lessonTitleRequired": MessageLookupByLibrary.simpleMessage(
      "Назва обов\'язкова",
    ),
    "lessonTopicLabel": MessageLookupByLibrary.simpleMessage("Тема"),
    "lessonTopicRequired": MessageLookupByLibrary.simpleMessage(
      "Тема обов\'язкова",
    ),
    "lessonUploaded": MessageLookupByLibrary.simpleMessage(
      "Урок успішно завантажено",
    ),
    "lessonYoutubeUrlRequired": MessageLookupByLibrary.simpleMessage(
      "Посилання на YouTube обов\'язкове",
    ),
    "lessonsPlaceholder": MessageLookupByLibrary.simpleMessage(
      "Список уроків буде додано тут.",
    ),
    "lessonsTitle": MessageLookupByLibrary.simpleMessage("Уроки"),
    "logout": MessageLookupByLibrary.simpleMessage("Вихід"),
    "menuCourses": MessageLookupByLibrary.simpleMessage("Курси"),
    "menuProfile": MessageLookupByLibrary.simpleMessage("Мій профіль"),
    "menuUsers": MessageLookupByLibrary.simpleMessage("Користувачі"),
    "noAccountYet": MessageLookupByLibrary.simpleMessage("Ще немає аккаунта?"),
    "noImageAdded": MessageLookupByLibrary.simpleMessage(
      "Зображення не додано",
    ),
    "openCourse": MessageLookupByLibrary.simpleMessage("Відкрити курс"),
    "or": MessageLookupByLibrary.simpleMessage("або"),
    "password": MessageLookupByLibrary.simpleMessage("Пароль"),
    "pleaseEnterAValidEmail": MessageLookupByLibrary.simpleMessage(
      "Будь ласка, впишіть валідний email",
    ),
    "profileCardTitle": MessageLookupByLibrary.simpleMessage("Профіль"),
    "profilePlaceholder": MessageLookupByLibrary.simpleMessage(
      "UI профілю буде додано тут.",
    ),
    "profileSubtitle": MessageLookupByLibrary.simpleMessage(
      "Базові дані та дії з акаунтом",
    ),
    "profileTitle": MessageLookupByLibrary.simpleMessage("Мій профіль"),
    "questionDescriptionLabel": MessageLookupByLibrary.simpleMessage(
      "Опис (необов\'язково)",
    ),
    "questionImageUrlLabel": MessageLookupByLibrary.simpleMessage(
      "Зображення (URL)",
    ),
    "questionSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Питання з варіантами",
    ),
    "questionTitleLabel": MessageLookupByLibrary.simpleMessage("Текст питання"),
    "questionsAndTasksPlaceholder": MessageLookupByLibrary.simpleMessage(
      "UI для питань і завдань буде додано тут.",
    ),
    "questionsAndTasksTitle": MessageLookupByLibrary.simpleMessage(
      "Питання та завдання",
    ),
    "refreshCoursesList": MessageLookupByLibrary.simpleMessage(
      "Оновити список",
    ),
    "refreshLessons": MessageLookupByLibrary.simpleMessage("Оновити список"),
    "removeItem": MessageLookupByLibrary.simpleMessage("Видалити"),
    "retry": MessageLookupByLibrary.simpleMessage("Повторити"),
    "saveCourse": MessageLookupByLibrary.simpleMessage("Зберегти курс"),
    "saveLessonBundle": MessageLookupByLibrary.simpleMessage(
      "Зберегти урок і матеріали",
    ),
    "signIn": MessageLookupByLibrary.simpleMessage("Вхід"),
    "signInWithGoogle": MessageLookupByLibrary.simpleMessage("Вiйти з Google"),
    "signUp": MessageLookupByLibrary.simpleMessage("Реєстрація"),
    "somethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "Щось пiшло не так. Спробуйте ще раз пізніше",
    ),
    "sorryOnlyAdminCanAccess": MessageLookupByLibrary.simpleMessage(
      "Вибачте, доступ мають лише адміни",
    ),
    "sorryWeCantFindAnAccountWithThisEmail":
        MessageLookupByLibrary.simpleMessage(
          "Вибачте, ми не можемо знайти аккаунт с цим email",
        ),
    "taskDescriptionLabel": MessageLookupByLibrary.simpleMessage(
      "Опис завдання",
    ),
    "taskMediaUrlLabel": MessageLookupByLibrary.simpleMessage("Медіа (URL)"),
    "taskSectionTitle": MessageLookupByLibrary.simpleMessage("Завдання"),
    "taskTitleLabel": MessageLookupByLibrary.simpleMessage("Назва завдання"),
    "testerRequestsApprove": MessageLookupByLibrary.simpleMessage(
      "Схвалити (tester)",
    ),
    "testerRequestsCreatedAt": MessageLookupByLibrary.simpleMessage("Створено"),
    "testerRequestsEmpty": MessageLookupByLibrary.simpleMessage(
      "Немає активних запитів.",
    ),
    "testerRequestsReject": MessageLookupByLibrary.simpleMessage("Відхилити"),
    "testerRequestsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Схвалення видає роль tester у Firestore і відкриває доступ до staging-додатку.",
    ),
    "testerRequestsTitle": MessageLookupByLibrary.simpleMessage(
      "Запити на роль тестувальника",
    ),
    "uploadLesson": MessageLookupByLibrary.simpleMessage("Завантажити урок"),
    "userRolesPlaceholder": MessageLookupByLibrary.simpleMessage(
      "UI керування ролями буде додано тут.",
    ),
    "userRolesTitle": MessageLookupByLibrary.simpleMessage("Ролі користувачів"),
    "username": MessageLookupByLibrary.simpleMessage(" Ім\'я користувача"),
    "usersSubtitle": MessageLookupByLibrary.simpleMessage(
      "Керування користувачами та ролями",
    ),
    "usersTitle": MessageLookupByLibrary.simpleMessage("Користувачі"),
    "youtubeLessonLabel": MessageLookupByLibrary.simpleMessage("YouTube-урок"),
    "youtubeUrlLabel": MessageLookupByLibrary.simpleMessage(
      "Посилання на YouTube",
    ),
  };
}
