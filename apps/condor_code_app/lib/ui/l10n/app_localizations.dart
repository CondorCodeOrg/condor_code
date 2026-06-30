import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('uk'),
  ];

  /// No description provided for @courses.
  ///
  /// In en, this message translates to:
  /// **'Courses'**
  String get courses;

  /// No description provided for @lessonsAmount.
  ///
  /// In en, this message translates to:
  /// **'{count} lessons'**
  String lessonsAmount(int count);

  /// No description provided for @informationWhereCoursesLocated.
  ///
  /// In en, this message translates to:
  /// **'{courseName} course currently is under development. \nLet us know if you\'re interested in it!'**
  String informationWhereCoursesLocated(String courseName);

  /// No description provided for @informationWhereLessonsLocated.
  ///
  /// In en, this message translates to:
  /// **'{lessonName} lessons currently is under development. \nLet us know if you\'re interested in it!'**
  String informationWhereLessonsLocated(String lessonName);

  /// No description provided for @lessonsName.
  ///
  /// In en, this message translates to:
  /// **'{lessonsName} Lessons'**
  String lessonsName(String lessonsName);

  /// No description provided for @canNotOpenUrl.
  ///
  /// In en, this message translates to:
  /// **'We can not open {url}'**
  String canNotOpenUrl(String url);

  /// No description provided for @checkKnowledgeAppBar.
  ///
  /// In en, this message translates to:
  /// **'{coursesName}. Check knowledge'**
  String checkKnowledgeAppBar(String coursesName);

  /// No description provided for @informationWhereTasksLocated.
  ///
  /// In en, this message translates to:
  /// **'{coursesName} tasks currently is under development. \nLet us know if you\'re interested in it!'**
  String informationWhereTasksLocated(String coursesName);

  /// No description provided for @emptyCoursesList.
  ///
  /// In en, this message translates to:
  /// **'Courses currently is under development. \nLet us know if you\'re interested in it!'**
  String get emptyCoursesList;

  /// No description provided for @answer.
  ///
  /// In en, this message translates to:
  /// **'Answer'**
  String get answer;

  /// No description provided for @task.
  ///
  /// In en, this message translates to:
  /// **'Task'**
  String get task;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @registration.
  ///
  /// In en, this message translates to:
  /// **'Registration'**
  String get registration;

  /// No description provided for @subscriptions.
  ///
  /// In en, this message translates to:
  /// **'subscriptions'**
  String get subscriptions;

  /// No description provided for @subscribers.
  ///
  /// In en, this message translates to:
  /// **'subscribers'**
  String get subscribers;

  /// No description provided for @addFriends.
  ///
  /// In en, this message translates to:
  /// **'Add Friends'**
  String get addFriends;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @recommendedFriends.
  ///
  /// In en, this message translates to:
  /// **'Recommended friends'**
  String get recommendedFriends;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'view all'**
  String get viewAll;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// No description provided for @letUsKnow.
  ///
  /// In en, this message translates to:
  /// **'Let us know'**
  String get letUsKnow;

  /// No description provided for @noCoursesInformation.
  ///
  /// In en, this message translates to:
  /// **'No courses here yet'**
  String get noCoursesInformation;

  /// No description provided for @noLessonsInformation.
  ///
  /// In en, this message translates to:
  /// **'No lessons here yet'**
  String get noLessonsInformation;

  /// No description provided for @watchOnYouTube.
  ///
  /// In en, this message translates to:
  /// **'Watch on YouTube'**
  String get watchOnYouTube;

  /// No description provided for @checkMyKnowledge.
  ///
  /// In en, this message translates to:
  /// **'Check my knowledge'**
  String get checkMyKnowledge;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @noSummaryAvailable.
  ///
  /// In en, this message translates to:
  /// **'No summary available'**
  String get noSummaryAvailable;

  /// No description provided for @invalidYouTubeLink.
  ///
  /// In en, this message translates to:
  /// **'Error: Invalid YouTube link'**
  String get invalidYouTubeLink;

  /// No description provided for @noTasksInformation.
  ///
  /// In en, this message translates to:
  /// **'No tasks here yet'**
  String get noTasksInformation;

  /// No description provided for @checkMyCode.
  ///
  /// In en, this message translates to:
  /// **'Check my code'**
  String get checkMyCode;

  /// No description provided for @contactsScreen.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get contactsScreen;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @subscribeToUs.
  ///
  /// In en, this message translates to:
  /// **'Subscribe to all our social networks and YouTube!'**
  String get subscribeToUs;

  /// No description provided for @youTube.
  ///
  /// In en, this message translates to:
  /// **'YouTube'**
  String get youTube;

  /// No description provided for @telegram.
  ///
  /// In en, this message translates to:
  /// **'Telegram'**
  String get telegram;

  /// No description provided for @instagram.
  ///
  /// In en, this message translates to:
  /// **'Instagram'**
  String get instagram;

  /// No description provided for @linkedIn.
  ///
  /// In en, this message translates to:
  /// **'LinkedIn'**
  String get linkedIn;

  /// No description provided for @tiktok.
  ///
  /// In en, this message translates to:
  /// **'TikTok'**
  String get tiktok;

  /// No description provided for @welcomeTo.
  ///
  /// In en, this message translates to:
  /// **'Welcome to '**
  String get welcomeTo;

  /// No description provided for @condorCodeBrand.
  ///
  /// In en, this message translates to:
  /// **'Condor Code!'**
  String get condorCodeBrand;

  /// No description provided for @homeIntro.
  ///
  /// In en, this message translates to:
  /// **'You are on the Condor Code website — a platform created by students of individual mentor Oleh Savenko. Here you can learn Flutter and Dart, find lessons and homework with answers, and check your results.'**
  String get homeIntro;

  /// No description provided for @featureLessonsTitle.
  ///
  /// In en, this message translates to:
  /// **'Flutter and Dart Lessons'**
  String get featureLessonsTitle;

  /// No description provided for @featureLessonsDesc.
  ///
  /// In en, this message translates to:
  /// **'Structured materials for gradual learning of Dart and the Flutter framework.'**
  String get featureLessonsDesc;

  /// No description provided for @featureHomeworkTitle.
  ///
  /// In en, this message translates to:
  /// **'Homework with Answers'**
  String get featureHomeworkTitle;

  /// No description provided for @featureHomeworkDesc.
  ///
  /// In en, this message translates to:
  /// **'Practical tasks for each lesson with the ability to view answers and self-check.'**
  String get featureHomeworkDesc;

  /// No description provided for @featureCheckTitle.
  ///
  /// In en, this message translates to:
  /// **'Result Verification'**
  String get featureCheckTitle;

  /// No description provided for @featureCheckDesc.
  ///
  /// In en, this message translates to:
  /// **'Convenient verification of your solutions and progress tracking.'**
  String get featureCheckDesc;

  /// No description provided for @startLearning.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Start Learning!'**
  String get startLearning;

  /// No description provided for @youtubeCtaText.
  ///
  /// In en, this message translates to:
  /// **'Main video materials are on Oleh Savenko\'s YouTube channel'**
  String get youtubeCtaText;

  /// No description provided for @goToYouTubeChannel.
  ///
  /// In en, this message translates to:
  /// **'Go to YouTube channel'**
  String get goToYouTubeChannel;

  /// No description provided for @footerDescription.
  ///
  /// In en, this message translates to:
  /// **'Condor Code — a platform for learning Flutter and Dart from students of mentor Oleh Savenko.'**
  String get footerDescription;

  /// No description provided for @copyright.
  ///
  /// In en, this message translates to:
  /// **'© {year} Condor Code. All rights reserved.'**
  String copyright(int year);

  /// No description provided for @mentorName.
  ///
  /// In en, this message translates to:
  /// **'Oleh Savenko'**
  String get mentorName;

  /// No description provided for @youtubeBlockDesc.
  ///
  /// In en, this message translates to:
  /// **'Flutter and Dart video lessons, tutorials and code reviews — main content is here.'**
  String get youtubeBlockDesc;

  /// No description provided for @telegramChannel.
  ///
  /// In en, this message translates to:
  /// **'— channel'**
  String get telegramChannel;

  /// No description provided for @telegramGroup.
  ///
  /// In en, this message translates to:
  /// **'— group'**
  String get telegramGroup;

  /// No description provided for @telegramChannelDesc.
  ///
  /// In en, this message translates to:
  /// **'Blog, dev news, announcements of new videos and podcasts.'**
  String get telegramChannelDesc;

  /// No description provided for @telegramGroupDesc.
  ///
  /// In en, this message translates to:
  /// **'Programmers group: we help each other with code and difficulties.'**
  String get telegramGroupDesc;

  /// No description provided for @goTo.
  ///
  /// In en, this message translates to:
  /// **'Go'**
  String get goTo;

  /// No description provided for @createNewLesson.
  ///
  /// In en, this message translates to:
  /// **'Create new lesson'**
  String get createNewLesson;

  /// No description provided for @viewLessons.
  ///
  /// In en, this message translates to:
  /// **'View lessons'**
  String get viewLessons;

  /// No description provided for @lessonCreationComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Lesson creation will be available soon.'**
  String get lessonCreationComingSoon;

  /// No description provided for @addVideoPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Add video (mainVideo with thumbnail)'**
  String get addVideoPlaceholder;

  /// No description provided for @knowledgeBase.
  ///
  /// In en, this message translates to:
  /// **'Knowledge base'**
  String get knowledgeBase;

  /// No description provided for @knowledgeBaseOpen.
  ///
  /// In en, this message translates to:
  /// **'Open knowledge base'**
  String get knowledgeBaseOpen;

  /// No description provided for @knowledgeBaseNavDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get knowledgeBaseNavDashboard;

  /// No description provided for @knowledgeBaseNavRoadmap.
  ///
  /// In en, this message translates to:
  /// **'Roadmap'**
  String get knowledgeBaseNavRoadmap;

  /// No description provided for @knowledgeBaseNavLibrary.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get knowledgeBaseNavLibrary;

  /// No description provided for @knowledgeBaseNavSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get knowledgeBaseNavSearch;

  /// No description provided for @knowledgeBaseUpgradePro.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro'**
  String get knowledgeBaseUpgradePro;

  /// No description provided for @knowledgeBaseSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get knowledgeBaseSettings;

  /// No description provided for @knowledgeBaseLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get knowledgeBaseLogout;

  /// No description provided for @knowledgeBaseSearchSoon.
  ///
  /// In en, this message translates to:
  /// **'Search is coming soon.'**
  String get knowledgeBaseSearchSoon;

  /// No description provided for @knowledgeBaseHeroTitlePrefix.
  ///
  /// In en, this message translates to:
  /// **'Your journey to '**
  String get knowledgeBaseHeroTitlePrefix;

  /// No description provided for @knowledgeBaseHeroTitleHighlight.
  ///
  /// In en, this message translates to:
  /// **'Flutter mastery'**
  String get knowledgeBaseHeroTitleHighlight;

  /// No description provided for @knowledgeBaseHeroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Stay updated with the latest news and explore curated learning resources. A professional path for the modern developer.'**
  String get knowledgeBaseHeroSubtitle;

  /// No description provided for @knowledgeBaseTagPopular.
  ///
  /// In en, this message translates to:
  /// **'MOST POPULAR'**
  String get knowledgeBaseTagPopular;

  /// No description provided for @knowledgeBaseTagInteractive.
  ///
  /// In en, this message translates to:
  /// **'INTERACTIVE'**
  String get knowledgeBaseTagInteractive;

  /// No description provided for @knowledgeBaseRoadmapCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Interactive roadmap'**
  String get knowledgeBaseRoadmapCardTitle;

  /// No description provided for @knowledgeBaseRoadmapCardDesc.
  ///
  /// In en, this message translates to:
  /// **'Master architecture from Junior to Principal engineer with our visual progress tracker.'**
  String get knowledgeBaseRoadmapCardDesc;

  /// No description provided for @knowledgeBaseStartLearning.
  ///
  /// In en, this message translates to:
  /// **'Start learning'**
  String get knowledgeBaseStartLearning;

  /// No description provided for @knowledgeBaseFlutterBasics.
  ///
  /// In en, this message translates to:
  /// **'Flutter basics'**
  String get knowledgeBaseFlutterBasics;

  /// No description provided for @knowledgeBaseDartDeepDive.
  ///
  /// In en, this message translates to:
  /// **'Dart deep dive'**
  String get knowledgeBaseDartDeepDive;

  /// No description provided for @knowledgeBaseLessonCount.
  ///
  /// In en, this message translates to:
  /// **'{count} lessons'**
  String knowledgeBaseLessonCount(int count);

  /// No description provided for @knowledgeBaseModuleCount.
  ///
  /// In en, this message translates to:
  /// **'{count} modules'**
  String knowledgeBaseModuleCount(int count);

  /// No description provided for @knowledgeBaseLatestUpdates.
  ///
  /// In en, this message translates to:
  /// **'Latest updates'**
  String get knowledgeBaseLatestUpdates;

  /// No description provided for @knowledgeBaseViewAllActivity.
  ///
  /// In en, this message translates to:
  /// **'View all activity'**
  String get knowledgeBaseViewAllActivity;

  /// No description provided for @knowledgeBaseLearningPillars.
  ///
  /// In en, this message translates to:
  /// **'Learning pillars'**
  String get knowledgeBaseLearningPillars;

  /// No description provided for @knowledgeBaseNewsCategoryArticle.
  ///
  /// In en, this message translates to:
  /// **'ARTICLE'**
  String get knowledgeBaseNewsCategoryArticle;

  /// No description provided for @knowledgeBaseNewsCategoryRoadmap.
  ///
  /// In en, this message translates to:
  /// **'ROADMAP'**
  String get knowledgeBaseNewsCategoryRoadmap;

  /// No description provided for @knowledgeBaseNewsCategoryAnnouncement.
  ///
  /// In en, this message translates to:
  /// **'ANNOUNCEMENT'**
  String get knowledgeBaseNewsCategoryAnnouncement;

  /// No description provided for @knowledgeBaseRoadmapPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'The interactive Flutter & Dart roadmap for beginners will appear here.'**
  String get knowledgeBaseRoadmapPlaceholder;

  /// No description provided for @knowledgeBaseRoadmapGraphHint.
  ///
  /// In en, this message translates to:
  /// **'Milestones flow left to right; subtopics and lessons branch out.'**
  String get knowledgeBaseRoadmapGraphHint;

  /// No description provided for @courseLessons.
  ///
  /// In en, this message translates to:
  /// **'Lessons'**
  String get courseLessons;

  /// No description provided for @courseActions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get courseActions;

  /// No description provided for @knowledgeCheckTasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get knowledgeCheckTasks;

  /// No description provided for @knowledgeCheckActions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get knowledgeCheckActions;

  /// No description provided for @knowledgeCheckTitle.
  ///
  /// In en, this message translates to:
  /// **'{courseName}. Knowledge check'**
  String knowledgeCheckTitle(String courseName);

  /// No description provided for @checkAnswer.
  ///
  /// In en, this message translates to:
  /// **'Check answer'**
  String get checkAnswer;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get goBack;

  /// No description provided for @knowledgeBaseResourcesPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Structured articles, videos, and links for beginners will appear here.'**
  String get knowledgeBaseResourcesPlaceholder;

  /// No description provided for @knowledgeBasePillarBasicsTitle.
  ///
  /// In en, this message translates to:
  /// **'THE BASICS'**
  String get knowledgeBasePillarBasicsTitle;

  /// No description provided for @knowledgeBasePillarBasicsItems.
  ///
  /// In en, this message translates to:
  /// **'Introduction to widgets\nState management 101\nNavigation & routing\nUser input & forms'**
  String get knowledgeBasePillarBasicsItems;

  /// No description provided for @knowledgeBasePillarAdvancedTitle.
  ///
  /// In en, this message translates to:
  /// **'ADVANCED LOGIC'**
  String get knowledgeBasePillarAdvancedTitle;

  /// No description provided for @knowledgeBasePillarAdvancedItems.
  ///
  /// In en, this message translates to:
  /// **'Isolates & threading\nMethod channels\nCustom painters\nPlatform integration'**
  String get knowledgeBasePillarAdvancedItems;

  /// No description provided for @knowledgeBasePillarArchTitle.
  ///
  /// In en, this message translates to:
  /// **'ARCHITECTURE'**
  String get knowledgeBasePillarArchTitle;

  /// No description provided for @knowledgeBasePillarArchItems.
  ///
  /// In en, this message translates to:
  /// **'Clean architecture\nMVVM patterns\nModularization\nDependency injection'**
  String get knowledgeBasePillarArchItems;

  /// No description provided for @knowledgeBasePillarProdTitle.
  ///
  /// In en, this message translates to:
  /// **'PRODUCTION'**
  String get knowledgeBasePillarProdTitle;

  /// No description provided for @knowledgeBasePillarProdItems.
  ///
  /// In en, this message translates to:
  /// **'Unit & integration tests\nCI/CD pipelines\nApp store deployment\nPerformance profiling'**
  String get knowledgeBasePillarProdItems;

  /// No description provided for @onlyTestersTitle.
  ///
  /// In en, this message translates to:
  /// **'Staging access'**
  String get onlyTestersTitle;

  /// No description provided for @onlyTestersBody.
  ///
  /// In en, this message translates to:
  /// **'This staging build is available only to accounts with tester or admin roles. Sign in with an authorized account or use the production app.'**
  String get onlyTestersBody;

  /// No description provided for @onlyTestersRequestAccessButton.
  ///
  /// In en, this message translates to:
  /// **'Request tester access'**
  String get onlyTestersRequestAccessButton;

  /// No description provided for @onlyTestersRequestPendingButton.
  ///
  /// In en, this message translates to:
  /// **'Request sent'**
  String get onlyTestersRequestPendingButton;

  /// No description provided for @onlyTestersRequestPendingHint.
  ///
  /// In en, this message translates to:
  /// **'Your request is pending. An administrator will review it soon.'**
  String get onlyTestersRequestPendingHint;

  /// No description provided for @onlyTestersRequestSent.
  ///
  /// In en, this message translates to:
  /// **'Request sent to administrators.'**
  String get onlyTestersRequestSent;

  /// No description provided for @onlyTestersRequestAlreadyPending.
  ///
  /// In en, this message translates to:
  /// **'You already have a pending request.'**
  String get onlyTestersRequestAlreadyPending;

  /// No description provided for @stagingSignInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get stagingSignInTitle;

  /// No description provided for @stagingSignInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use the tester or administrator account issued for this environment.'**
  String get stagingSignInSubtitle;

  /// No description provided for @stagingSignInEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get stagingSignInEmailLabel;

  /// No description provided for @stagingSignInPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get stagingSignInPasswordLabel;

  /// No description provided for @stagingSignInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get stagingSignInButton;

  /// No description provided for @stagingSignInMissingCredentials.
  ///
  /// In en, this message translates to:
  /// **'Enter email and password'**
  String get stagingSignInMissingCredentials;

  /// No description provided for @stagingSignInErrorWrongCredentials.
  ///
  /// In en, this message translates to:
  /// **'Wrong email or password.'**
  String get stagingSignInErrorWrongCredentials;

  /// No description provided for @stagingSignInErrorAccountNotFound.
  ///
  /// In en, this message translates to:
  /// **'No account exists with this email address.'**
  String get stagingSignInErrorAccountNotFound;

  /// No description provided for @stagingSignInErrorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get stagingSignInErrorInvalidEmail;

  /// No description provided for @stagingSignInErrorUserDisabled.
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled.'**
  String get stagingSignInErrorUserDisabled;

  /// No description provided for @stagingSignInErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Sign-in failed. Please try again.'**
  String get stagingSignInErrorGeneric;

  /// No description provided for @stagingSignUpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create an account. Only tester and administrator roles can use this environment.'**
  String get stagingSignUpSubtitle;

  /// No description provided for @stagingSignUpConfirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get stagingSignUpConfirmPasswordLabel;

  /// No description provided for @stagingSignUpButton.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get stagingSignUpButton;

  /// No description provided for @stagingSignUpPasswordsMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get stagingSignUpPasswordsMismatch;

  /// No description provided for @stagingSignUpErrorEmailInUse.
  ///
  /// In en, this message translates to:
  /// **'An account with this email already exists.'**
  String get stagingSignUpErrorEmailInUse;

  /// No description provided for @stagingSignUpErrorWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'Password is too weak. Use at least 6 characters.'**
  String get stagingSignUpErrorWeakPassword;

  /// No description provided for @stagingSignUpErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Could not create account. Please try again.'**
  String get stagingSignUpErrorGeneric;

  /// No description provided for @stagingSwitchToSignUp.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Sign up'**
  String get stagingSwitchToSignUp;

  /// No description provided for @stagingSwitchToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign in'**
  String get stagingSwitchToSignIn;

  /// No description provided for @stagingProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get stagingProfileTitle;

  /// No description provided for @stagingProfileSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get stagingProfileSignOut;

  /// No description provided for @stagingProfileSignOutConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get stagingProfileSignOutConfirmTitle;

  /// No description provided for @stagingProfileSignOutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get stagingProfileSignOutConfirm;

  /// No description provided for @stagingProfileCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get stagingProfileCancel;

  /// No description provided for @stagingRoleAdmin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get stagingRoleAdmin;

  /// No description provided for @stagingRoleTester.
  ///
  /// In en, this message translates to:
  /// **'Tester'**
  String get stagingRoleTester;

  /// No description provided for @stagingRoleUser.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get stagingRoleUser;

  /// No description provided for @stagingRoleDeveloper.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get stagingRoleDeveloper;

  /// No description provided for @stagingRolePatron.
  ///
  /// In en, this message translates to:
  /// **'Patron'**
  String get stagingRolePatron;

  /// No description provided for @stagingRolePatronDeveloper.
  ///
  /// In en, this message translates to:
  /// **'Patron + Developer'**
  String get stagingRolePatronDeveloper;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'uk':
      return AppLocalizationsUk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
