// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get courses => 'Courses';

  @override
  String lessonsAmount(int count) {
    return '$count lessons';
  }

  @override
  String informationWhereCoursesLocated(String courseName) {
    return '$courseName course currently is under development. \nLet us know if you\'re interested in it!';
  }

  @override
  String informationWhereLessonsLocated(String lessonName) {
    return '$lessonName lessons currently is under development. \nLet us know if you\'re interested in it!';
  }

  @override
  String lessonsName(String lessonsName) {
    return '$lessonsName Lessons';
  }

  @override
  String canNotOpenUrl(String url) {
    return 'We can not open $url';
  }

  @override
  String checkKnowledgeAppBar(String coursesName) {
    return '$coursesName. Check knowledge';
  }

  @override
  String informationWhereTasksLocated(String coursesName) {
    return '$coursesName tasks currently is under development. \nLet us know if you\'re interested in it!';
  }

  @override
  String get emptyCoursesList =>
      'Courses currently is under development. \nLet us know if you\'re interested in it!';

  @override
  String get answer => 'Answer';

  @override
  String get task => 'Task';

  @override
  String get profile => 'Profile';

  @override
  String get registration => 'Registration';

  @override
  String get subscriptions => 'subscriptions';

  @override
  String get subscribers => 'subscribers';

  @override
  String get addFriends => 'Add Friends';

  @override
  String get statistics => 'Statistics';

  @override
  String get recommendedFriends => 'Recommended friends';

  @override
  String get viewAll => 'view all';

  @override
  String get achievements => 'Achievements';

  @override
  String get letUsKnow => 'Let us know';

  @override
  String get noCoursesInformation => 'No courses here yet';

  @override
  String get noLessonsInformation => 'No lessons here yet';

  @override
  String get watchOnYouTube => 'Watch on YouTube';

  @override
  String get checkMyKnowledge => 'Check my knowledge';

  @override
  String get summary => 'Summary';

  @override
  String get noSummaryAvailable => 'No summary available';

  @override
  String get invalidYouTubeLink => 'Error: Invalid YouTube link';

  @override
  String get noTasksInformation => 'No tasks here yet';

  @override
  String get checkMyCode => 'Check my code';

  @override
  String get contactsScreen => 'Contacts';

  @override
  String get home => 'Home';

  @override
  String get subscribeToUs =>
      'Subscribe to all our social networks and YouTube!';

  @override
  String get youTube => 'YouTube';

  @override
  String get telegram => 'Telegram';

  @override
  String get instagram => 'Instagram';

  @override
  String get linkedIn => 'LinkedIn';

  @override
  String get tiktok => 'TikTok';

  @override
  String get welcomeTo => 'Welcome to ';

  @override
  String get condorCodeBrand => 'Condor Code!';

  @override
  String get homeIntro =>
      'You are on the Condor Code website — a platform created by students of individual mentor Oleh Savenko. Here you can learn Flutter and Dart, find lessons and homework with answers, and check your results.';

  @override
  String get featureLessonsTitle => 'Flutter and Dart Lessons';

  @override
  String get featureLessonsDesc =>
      'Structured materials for gradual learning of Dart and the Flutter framework.';

  @override
  String get featureHomeworkTitle => 'Homework with Answers';

  @override
  String get featureHomeworkDesc =>
      'Practical tasks for each lesson with the ability to view answers and self-check.';

  @override
  String get featureCheckTitle => 'Result Verification';

  @override
  String get featureCheckDesc =>
      'Convenient verification of your solutions and progress tracking.';

  @override
  String get startLearning => 'Let\'s Start Learning!';

  @override
  String get youtubeCtaText =>
      'Main video materials are on Oleh Savenko\'s YouTube channel';

  @override
  String get goToYouTubeChannel => 'Go to YouTube channel';

  @override
  String get footerDescription =>
      'Condor Code — a platform for learning Flutter and Dart from students of mentor Oleh Savenko.';

  @override
  String copyright(int year) {
    return '© $year Condor Code. All rights reserved.';
  }

  @override
  String get mentorName => 'Oleh Savenko';

  @override
  String get youtubeBlockDesc =>
      'Flutter and Dart video lessons, tutorials and code reviews — main content is here.';

  @override
  String get telegramChannel => '— channel';

  @override
  String get telegramGroup => '— group';

  @override
  String get telegramChannelDesc =>
      'Blog, dev news, announcements of new videos and podcasts.';

  @override
  String get telegramGroupDesc =>
      'Programmers group: we help each other with code and difficulties.';

  @override
  String get goTo => 'Go';

  @override
  String get createNewLesson => 'Create new lesson';

  @override
  String get viewLessons => 'View lessons';

  @override
  String get lessonCreationComingSoon =>
      'Lesson creation will be available soon.';

  @override
  String get addVideoPlaceholder => 'Add video (mainVideo with thumbnail)';

  @override
  String get knowledgeBase => 'Knowledge base';

  @override
  String get knowledgeBaseOpen => 'Open knowledge base';

  @override
  String get knowledgeBaseNavDashboard => 'Dashboard';

  @override
  String get knowledgeBaseNavRoadmap => 'Roadmap';

  @override
  String get knowledgeBaseNavLibrary => 'Library';

  @override
  String get knowledgeBaseNavSearch => 'Search';

  @override
  String get knowledgeBaseUpgradePro => 'Upgrade to Pro';

  @override
  String get knowledgeBaseSettings => 'Settings';

  @override
  String get knowledgeBaseLogout => 'Log out';

  @override
  String get knowledgeBaseSearchSoon => 'Search is coming soon.';

  @override
  String get knowledgeBaseHeroTitlePrefix => 'Your journey to ';

  @override
  String get knowledgeBaseHeroTitleHighlight => 'Flutter mastery';

  @override
  String get knowledgeBaseHeroSubtitle =>
      'Stay updated with the latest news and explore curated learning resources. A professional path for the modern developer.';

  @override
  String get knowledgeBaseTagPopular => 'MOST POPULAR';

  @override
  String get knowledgeBaseTagInteractive => 'INTERACTIVE';

  @override
  String get knowledgeBaseRoadmapCardTitle => 'Interactive roadmap';

  @override
  String get knowledgeBaseRoadmapCardDesc =>
      'Master architecture from Junior to Principal engineer with our visual progress tracker.';

  @override
  String get knowledgeBaseStartLearning => 'Start learning';

  @override
  String get knowledgeBaseFlutterBasics => 'Flutter basics';

  @override
  String get knowledgeBaseDartDeepDive => 'Dart deep dive';

  @override
  String knowledgeBaseLessonCount(int count) {
    return '$count lessons';
  }

  @override
  String knowledgeBaseModuleCount(int count) {
    return '$count modules';
  }

  @override
  String get knowledgeBaseLatestUpdates => 'Latest updates';

  @override
  String get knowledgeBaseViewAllActivity => 'View all activity';

  @override
  String get knowledgeBaseLearningPillars => 'Learning pillars';

  @override
  String get knowledgeBaseNewsCategoryArticle => 'ARTICLE';

  @override
  String get knowledgeBaseNewsCategoryRoadmap => 'ROADMAP';

  @override
  String get knowledgeBaseNewsCategoryAnnouncement => 'ANNOUNCEMENT';

  @override
  String get knowledgeBaseRoadmapPlaceholder =>
      'The interactive Flutter & Dart roadmap for beginners will appear here.';

  @override
  String get knowledgeBaseRoadmapGraphHint =>
      'Milestones flow left to right; subtopics and lessons branch out.';

  @override
  String get courseLessons => 'Lessons';

  @override
  String get courseActions => 'Actions';

  @override
  String get knowledgeCheckTasks => 'Tasks';

  @override
  String get knowledgeCheckActions => 'Actions';

  @override
  String knowledgeCheckTitle(String courseName) {
    return '$courseName. Knowledge check';
  }

  @override
  String get checkAnswer => 'Check answer';

  @override
  String get goBack => 'Back';

  @override
  String get knowledgeBaseResourcesPlaceholder =>
      'Structured articles, videos, and links for beginners will appear here.';

  @override
  String get knowledgeBasePillarBasicsTitle => 'THE BASICS';

  @override
  String get knowledgeBasePillarBasicsItems =>
      'Introduction to widgets\nState management 101\nNavigation & routing\nUser input & forms';

  @override
  String get knowledgeBasePillarAdvancedTitle => 'ADVANCED LOGIC';

  @override
  String get knowledgeBasePillarAdvancedItems =>
      'Isolates & threading\nMethod channels\nCustom painters\nPlatform integration';

  @override
  String get knowledgeBasePillarArchTitle => 'ARCHITECTURE';

  @override
  String get knowledgeBasePillarArchItems =>
      'Clean architecture\nMVVM patterns\nModularization\nDependency injection';

  @override
  String get knowledgeBasePillarProdTitle => 'PRODUCTION';

  @override
  String get knowledgeBasePillarProdItems =>
      'Unit & integration tests\nCI/CD pipelines\nApp store deployment\nPerformance profiling';

  @override
  String get onlyTestersTitle => 'Staging access';

  @override
  String get onlyTestersBody =>
      'This staging build is available only to accounts with tester or admin roles. Sign in with an authorized account or use the production app.';

  @override
  String get onlyTestersRequestAccessButton => 'Request tester access';

  @override
  String get onlyTestersRequestPendingButton => 'Request sent';

  @override
  String get onlyTestersRequestPendingHint =>
      'Your request is pending. An administrator will review it soon.';

  @override
  String get onlyTestersRequestSent => 'Request sent to administrators.';

  @override
  String get onlyTestersRequestAlreadyPending =>
      'You already have a pending request.';

  @override
  String get stagingSignInTitle => 'Sign in';

  @override
  String get stagingSignInSubtitle =>
      'Use the tester or administrator account issued for this environment.';

  @override
  String get stagingSignInEmailLabel => 'Email';

  @override
  String get stagingSignInPasswordLabel => 'Password';

  @override
  String get stagingSignInButton => 'Sign in';

  @override
  String get stagingSignInMissingCredentials => 'Enter email and password';

  @override
  String get stagingSignInErrorWrongCredentials => 'Wrong email or password.';

  @override
  String get stagingSignInErrorAccountNotFound =>
      'No account exists with this email address.';

  @override
  String get stagingSignInErrorInvalidEmail => 'Enter a valid email address.';

  @override
  String get stagingSignInErrorUserDisabled =>
      'This account has been disabled.';

  @override
  String get stagingSignInErrorGeneric => 'Sign-in failed. Please try again.';

  @override
  String get stagingSignUpSubtitle =>
      'Create an account. Only tester and administrator roles can use this environment.';

  @override
  String get stagingSignUpConfirmPasswordLabel => 'Confirm password';

  @override
  String get stagingSignUpButton => 'Create account';

  @override
  String get stagingSignUpPasswordsMismatch => 'Passwords do not match.';

  @override
  String get stagingSignUpErrorEmailInUse =>
      'An account with this email already exists.';

  @override
  String get stagingSignUpErrorWeakPassword =>
      'Password is too weak. Use at least 6 characters.';

  @override
  String get stagingSignUpErrorGeneric =>
      'Could not create account. Please try again.';

  @override
  String get stagingSwitchToSignUp => 'Don\'t have an account? Sign up';

  @override
  String get stagingSwitchToSignIn => 'Already have an account? Sign in';

  @override
  String get stagingProfileTitle => 'Account';

  @override
  String get stagingProfileSignOut => 'Sign out';

  @override
  String get stagingProfileSignOutConfirmTitle => 'Sign out';

  @override
  String get stagingProfileSignOutConfirm =>
      'Are you sure you want to sign out?';

  @override
  String get stagingProfileCancel => 'Cancel';

  @override
  String get stagingRoleAdmin => 'Admin';

  @override
  String get stagingRoleTester => 'Tester';

  @override
  String get stagingRoleUser => 'User';

  @override
  String get stagingRoleDeveloper => 'Developer';

  @override
  String get stagingRolePatron => 'Patron';

  @override
  String get stagingRolePatronDeveloper => 'Patron + Developer';
}
