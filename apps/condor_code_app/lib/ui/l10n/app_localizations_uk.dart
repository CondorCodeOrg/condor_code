// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get courses => 'Курси';

  @override
  String lessonsAmount(int count) {
    return 'Уроків: $count';
  }

  @override
  String informationWhereCoursesLocated(String courseName) {
    return 'Курс $courseName зараз перебуває в розробці. \nПовідомте нас, якщо ви ним зацікавлені!';
  }

  @override
  String informationWhereLessonsLocated(String lessonName) {
    return 'Уроки $lessonName зараз перебувають у розробці. \nПовідомте нас, якщо ви ними зацікавлені!';
  }

  @override
  String lessonsName(String lessonsName) {
    return 'Уроки $lessonsName';
  }

  @override
  String canNotOpenUrl(String url) {
    return 'Ми не можемо відкрити $url';
  }

  @override
  String checkKnowledgeAppBar(String coursesName) {
    return '$coursesName. Перевірка знань';
  }

  @override
  String informationWhereTasksLocated(String coursesName) {
    return 'Завдання $coursesName зараз перебувають у розробці. \nПовідомте нас, якщо ви ними зацікавлені!';
  }

  @override
  String get emptyCoursesList =>
      'Курси наразі перебувають у розробці. \nПовідомте нас, якщо ви зацікавлені!';

  @override
  String get answer => 'Відповідь';

  @override
  String get task => 'Завдання';

  @override
  String get profile => 'Профіль';

  @override
  String get registration => 'Реєстрація';

  @override
  String get subscriptions => 'підписок';

  @override
  String get subscribers => 'підписників';

  @override
  String get addFriends => 'Додати друзів';

  @override
  String get statistics => 'Статистика';

  @override
  String get recommendedFriends => 'Рекомендовані друзі';

  @override
  String get viewAll => 'переглянути все';

  @override
  String get achievements => 'Досягнення';

  @override
  String get letUsKnow => 'Повідомте нас';

  @override
  String get noCoursesInformation => 'Тут ще немає курсів';

  @override
  String get noLessonsInformation => 'Тут ще немає уроків';

  @override
  String get watchOnYouTube => 'Дивіться на YouTube';

  @override
  String get checkMyKnowledge => 'Перевір мої знання';

  @override
  String get summary => 'Конспект';

  @override
  String get invalidYouTubeLink => 'Помилка: Недійсне посилання на YouTube';

  @override
  String get noTasksInformation => 'Тут ще немає завдань';

  @override
  String get checkMyCode => 'Перевір мій код';

  @override
  String get contactsScreen => 'Контакти';

  @override
  String get home => 'Головна';

  @override
  String get subscribeToUs => 'Підписуйся на всі наші соцмережі та YouTube!';

  @override
  String get youTube => 'Ютуб';

  @override
  String get telegram => 'Telegram';

  @override
  String get instagram => 'Instagram';

  @override
  String get linkedIn => 'LinkedIn';

  @override
  String get tiktok => 'ТікТок';

  @override
  String get welcomeTo => 'Друзі, всіх вітаємо на ';

  @override
  String get condorCodeBrand => 'CondorCode!';

  @override
  String get homeIntro =>
      'Цю платформу створили учні Олега Савенка - розробника-ментора з 7-річним стажем. Тут ви зможете легко навчитися програмувати будь-які застосунки, використовуючи Flutter та Dart! Ми з радістю допоможемо вам у цьому, а також надамо всі необхідні матеріали для навчання та практики:';

  @override
  String get featureLessonsTitle => 'Уроки з Flutter та Dart';

  @override
  String get featureLessonsDesc =>
      'Структуровані матеріали для поступового вивчення мови Dart та фреймворку Flutter.';

  @override
  String get featureHomeworkTitle => 'Домашні завдання з відповідями';

  @override
  String get featureHomeworkDesc =>
      'Практичні завдання до кожного уроку з можливістю перегляду відповідей та самоперевірки.';

  @override
  String get featureCheckTitle => 'Перевірка результатів';

  @override
  String get featureCheckDesc =>
      'Зручна перевірка своїх рішень та відстеження прогресу в навчанні.';

  @override
  String get startLearning => 'Погнали Вчитися!';

  @override
  String get youtubeCtaText =>
      '\"Подкаст з Нуля\" та інший необхідний контент для новачків — на YouTube-каналі \"Олег Савенко - «Мобільна розробка  від А до Я»\"';

  @override
  String get goToYouTubeChannel => 'Перейти на YouTube-канал';

  @override
  String get footerDescription =>
      'Condor Code — платформа для вивчення Flutter та Dart від учнів ментора Олега Савенка.';

  @override
  String copyright(int year) {
    return '© $year Condor Code. Усі права захищені.';
  }

  @override
  String get mentorName => 'Олег Савенко';

  @override
  String get youtubeBlockDesc =>
      '\"Подкаст з Нуля\", корисні відео та додаткові уроки — основний контент тут.';

  @override
  String get telegramChannel => '— канал';

  @override
  String get telegramGroup => '— група';

  @override
  String get telegramChannelDesc =>
      'Блог, новини розробки, анонси нових відео та подкастів.';

  @override
  String get telegramGroupDesc =>
      'Група програмістів: допомагаємо один одному з кодом та спілкуємося.';

  @override
  String get goTo => 'Перейти';

  @override
  String get createNewLesson => 'Створити новий урок';

  @override
  String get viewLessons => 'Переглянути уроки';

  @override
  String get lessonCreationComingSoon =>
      'Створення уроків буде доступне незабаром.';

  @override
  String get addVideoPlaceholder => 'Додай відео (mainVideo з thumbnail)';

  @override
  String get knowledgeBase => 'База знань';

  @override
  String get knowledgeBaseOpen => 'Відкрити базу знань';

  @override
  String get knowledgeBaseNavDashboard => 'Головна';

  @override
  String get knowledgeBaseNavRoadmap => 'Роадмап';

  @override
  String get knowledgeBaseNavLibrary => 'Бібліотека';

  @override
  String get knowledgeBaseNavSearch => 'Пошук';

  @override
  String get knowledgeBaseUpgradePro => 'Оновити до Pro';

  @override
  String get knowledgeBaseSettings => 'Налаштування';

  @override
  String get knowledgeBaseLogout => 'Вийти';

  @override
  String get knowledgeBaseSearchSoon => 'Пошук з’явиться незабаром.';

  @override
  String get knowledgeBaseHeroTitlePrefix => 'Твій шлях до ';

  @override
  String get knowledgeBaseHeroTitleHighlight => 'Flutter майстерності';

  @override
  String get knowledgeBaseHeroSubtitle =>
      'Слідкуй за новинами та занурюйся в добіркові матеріали. Професійний маршрут для сучасного розробника.';

  @override
  String get knowledgeBaseTagPopular => 'НАЙПОПУЛЯРНІШЕ';

  @override
  String get knowledgeBaseTagInteractive => 'ІНТЕРАКТИВНО';

  @override
  String get knowledgeBaseRoadmapCardTitle => 'Інтерактивний роадмап';

  @override
  String get knowledgeBaseRoadmapCardDesc =>
      'Опануй архітектуру від Junior до Principal з візуальним трекером прогресу.';

  @override
  String get knowledgeBaseStartLearning => 'Почати навчання';

  @override
  String get knowledgeBaseFlutterBasics => 'Основи Flutter';

  @override
  String get knowledgeBaseDartDeepDive => 'Dart глибше';

  @override
  String knowledgeBaseLessonCount(int count) {
    return '$count уроків';
  }

  @override
  String knowledgeBaseModuleCount(int count) {
    return '$count модулів';
  }

  @override
  String get knowledgeBaseLatestUpdates => 'Останні оновлення';

  @override
  String get knowledgeBaseViewAllActivity => 'Уся активність';

  @override
  String get knowledgeBaseLearningPillars => 'Опори навчання';

  @override
  String get knowledgeBaseNewsCategoryArticle => 'СТАТТЯ';

  @override
  String get knowledgeBaseNewsCategoryRoadmap => 'ROADMAP';

  @override
  String get knowledgeBaseNewsCategoryAnnouncement => 'АНОНС';

  @override
  String get knowledgeBaseRoadmapPlaceholder =>
      'Тут з’явиться великий інтерактивний роадмап Flutter та Dart для новачків.';

  @override
  String get knowledgeBaseRoadmapGraphHint =>
      'Віхи зліва направо; підтеми та уроки — вкладені гілки.';

  @override
  String get courseLessons => 'Уроки';

  @override
  String get courseActions => 'Дії';

  @override
  String get knowledgeCheckTasks => 'Завдання';

  @override
  String get knowledgeCheckActions => 'Дії';

  @override
  String knowledgeCheckTitle(String courseName) {
    return '$courseName. Перевірка знань';
  }

  @override
  String get checkAnswer => 'Перевірити відповідь';

  @override
  String get goBack => 'Назад';

  @override
  String get knowledgeBaseResourcesPlaceholder =>
      'Тут будуть структуровані статті, відео та посилання для новачків.';

  @override
  String get knowledgeBasePillarBasicsTitle => 'БАЗА';

  @override
  String get knowledgeBasePillarBasicsItems =>
      'Вступ до віджетів\nКерування станом: основи\nНавігація та маршрутизація\nВведення даних і форми';

  @override
  String get knowledgeBasePillarAdvancedTitle => 'СКЛАДНА ЛОГІКА';

  @override
  String get knowledgeBasePillarAdvancedItems =>
      'Ізоляти та потоки\nMethod channels\nCustom painters\nІнтеграція з платформою';

  @override
  String get knowledgeBasePillarArchTitle => 'АРХІТЕКТУРА';

  @override
  String get knowledgeBasePillarArchItems =>
      'Чиста архітектура\nПатерни MVVM\nМодульність\nЗалежності (DI)';

  @override
  String get knowledgeBasePillarProdTitle => 'ПРОДАКШН';

  @override
  String get knowledgeBasePillarProdItems =>
      'Unit та інтеграційні тести\nCI/CD пайплайни\nПублікація в сторах\nПрофілювання продуктивності';

  @override
  String get onlyTestersTitle => 'Доступ до staging';

  @override
  String get onlyTestersBody =>
      'Цю збірку staging можуть використовувати лише облікові записи з ролями тестувальника або адміністратора. Увійдіть уповноваженим акаунтом або скористайтеся продакшн-додатком.';

  @override
  String get onlyTestersRequestAccessButton => 'Запросити доступ тестувальника';

  @override
  String get onlyTestersRequestPendingButton => 'Запит надіслано';

  @override
  String get onlyTestersRequestPendingHint =>
      'Ваш запит очікує розгляду. Адміністратор незабаром його перевірить.';

  @override
  String get onlyTestersRequestSent => 'Запит надіслано адміністраторам.';

  @override
  String get onlyTestersRequestAlreadyPending => 'У вас уже є активний запит.';

  @override
  String get stagingSignInTitle => 'Вхід';

  @override
  String get stagingSignInSubtitle =>
      'Увійдіть обліковим записом тестувальника або адміністратора, виданим для цього середовища.';

  @override
  String get stagingSignInEmailLabel => 'Електронна пошта';

  @override
  String get stagingSignInPasswordLabel => 'Пароль';

  @override
  String get stagingSignInButton => 'Увійти';

  @override
  String get stagingSignInMissingCredentials =>
      'Введіть електронну пошту та пароль';

  @override
  String get stagingSignInErrorWrongCredentials => 'Невірна пошта або пароль.';

  @override
  String get stagingSignInErrorAccountNotFound =>
      'Облікового запису з такою адресою не існує.';

  @override
  String get stagingSignInErrorInvalidEmail => 'Введіть коректну адресу пошти.';

  @override
  String get stagingSignInErrorUserDisabled => 'Цей обліковий запис вимкнено.';

  @override
  String get stagingSignInErrorGeneric =>
      'Не вдалося увійти. Спробуйте ще раз.';

  @override
  String get stagingSignUpSubtitle =>
      'Створіть обліковий запис. Цим середовищем можуть користуватися лише ролі тестувальника та адміністратора.';

  @override
  String get stagingSignUpConfirmPasswordLabel => 'Підтвердіть пароль';

  @override
  String get stagingSignUpButton => 'Створити обліковий запис';

  @override
  String get stagingSignUpPasswordsMismatch => 'Паролі не збігаються.';

  @override
  String get stagingSignUpErrorEmailInUse =>
      'Обліковий запис з такою поштою вже існує.';

  @override
  String get stagingSignUpErrorWeakPassword =>
      'Пароль занадто слабкий. Використайте щонайменше 6 символів.';

  @override
  String get stagingSignUpErrorGeneric =>
      'Не вдалося створити обліковий запис. Спробуйте ще раз.';

  @override
  String get stagingSwitchToSignUp =>
      'Немає облікового запису? Зареєструватися';

  @override
  String get stagingSwitchToSignIn => 'Вже є обліковий запис? Увійти';

  @override
  String get stagingProfileTitle => 'Акаунт';

  @override
  String get stagingProfileSignOut => 'Вийти';

  @override
  String get stagingProfileSignOutConfirmTitle => 'Вийти з акаунту';

  @override
  String get stagingProfileSignOutConfirm => 'Ви впевнені, що хочете вийти?';

  @override
  String get stagingProfileCancel => 'Скасувати';

  @override
  String get stagingRoleAdmin => 'Адмін';

  @override
  String get stagingRoleTester => 'Тестер';

  @override
  String get stagingRoleUser => 'Користувач';

  @override
  String get stagingRoleDeveloper => 'Розробник';

  @override
  String get stagingRolePatron => 'Патрон';

  @override
  String get stagingRolePatronDeveloper => 'Патрон + Розробник';
}
