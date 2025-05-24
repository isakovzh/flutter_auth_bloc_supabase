import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ky.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ky')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Manas App'**
  String get appTitle;

  /// Title for the quiz page
  ///
  /// In en, this message translates to:
  /// **'Quiz: {lessonTitle}'**
  String quizTitle(String lessonTitle);

  /// Shows current question number and total questions
  ///
  /// In en, this message translates to:
  /// **'Question {current}/{total}'**
  String questionCounter(int current, int total);

  /// Title for quiz completion dialog
  ///
  /// In en, this message translates to:
  /// **'Quiz Completed'**
  String get quizCompleted;

  /// Shows quiz results with correct answers and XP earned
  ///
  /// In en, this message translates to:
  /// **'You answered {correct} / {total} correctly.\nYou earned {xp} XP!'**
  String quizResults(int correct, int total, int xp);

  /// Shows error quiz results with correct answers and XP earned
  ///
  /// In en, this message translates to:
  /// **'You answered {correct} / {total} correctly.\nYou earned {xp} XP! (5 XP per correct answer)'**
  String errorQuizResults(int correct, int total, int xp);

  /// Text for done button
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// Settings title in drawer
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Change theme option in drawer
  ///
  /// In en, this message translates to:
  /// **'Change Theme'**
  String get changeTheme;

  /// Change language option in drawer
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// Logout option in drawer
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Profile page title
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Button to view achievements
  ///
  /// In en, this message translates to:
  /// **'View Achievements'**
  String get viewAchievements;

  /// Title of achievements gallery
  ///
  /// In en, this message translates to:
  /// **'Achievements Gallery'**
  String get achievementsGallery;

  /// OK button text
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Lessons page title
  ///
  /// In en, this message translates to:
  /// **'Lessons'**
  String get lessons;

  /// Button to start quiz
  ///
  /// In en, this message translates to:
  /// **'Start Quiz'**
  String get startQuiz;

  /// Button to start error quiz
  ///
  /// In en, this message translates to:
  /// **'Start Error Quiz'**
  String get startErrorQuiz;

  /// Error quiz title
  ///
  /// In en, this message translates to:
  /// **'Error Quiz'**
  String get errorQuiz;

  /// Error quiz completion title
  ///
  /// In en, this message translates to:
  /// **'Error Quiz Completed'**
  String get errorQuizCompleted;

  /// Open button text
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// Characters page title
  ///
  /// In en, this message translates to:
  /// **'Characters'**
  String get characters;

  /// Error message
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String error(String message);

  /// XP points display
  ///
  /// In en, this message translates to:
  /// **'XP: {points}'**
  String xpPoints(String points);

  /// Title for epos chapters page
  ///
  /// In en, this message translates to:
  /// **'Chapters of Manas Epos'**
  String get eposChapters;

  /// Error message when loading chapters fails
  ///
  /// In en, this message translates to:
  /// **'Error loading chapters'**
  String get errorLoadingChapters;

  /// Pause button text
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// Listen button text
  ///
  /// In en, this message translates to:
  /// **'Listen'**
  String get listen;

  /// Shows completed lessons count
  ///
  /// In en, this message translates to:
  /// **'Lessons Completed: {completed}'**
  String lessonsCompleted(int completed);

  /// Button text for retaking a quiz
  ///
  /// In en, this message translates to:
  /// **'Retake Quiz'**
  String get retakeQuiz;

  /// Button text for taking a quiz for the first time
  ///
  /// In en, this message translates to:
  /// **'Take Quiz'**
  String get takeQuiz;

  /// Shows correct answers count
  ///
  /// In en, this message translates to:
  /// **'{correct}/{total} correct'**
  String correctAnswersCount(int correct, int total);

  /// Shows how many characters are unlocked
  ///
  /// In en, this message translates to:
  /// **'Characters Unlocked: {unlocked} / {total}'**
  String charactersUnlocked(int unlocked, int total);

  /// Text in progress chartBar
  ///
  /// In en, this message translates to:
  /// **'Weekly XP Progress'**
  String get weeklyXpProgress;

  /// Monday abbreviation
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get monday;

  /// Tuesday abbreviation
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get tuesday;

  /// Wednesday abbreviation
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get wednesday;

  /// Thursday abbreviation
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get thursday;

  /// Friday abbreviation
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get friday;

  /// Saturday abbreviation
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get saturday;

  /// Sunday abbreviation
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get sunday;

  /// Achievement message for completing first quiz
  ///
  /// In en, this message translates to:
  /// **'You completed your first quiz!'**
  String get achievementFirstQuiz;

  /// Achievement message for perfect quiz score
  ///
  /// In en, this message translates to:
  /// **'Perfect score - all answers correct!'**
  String get achievementPerfectScore;

  /// Achievement message for earning 100 XP
  ///
  /// In en, this message translates to:
  /// **'You earned 100 XP!'**
  String get achievement100XP;

  /// Achievement message for completing 5 lessons
  ///
  /// In en, this message translates to:
  /// **'You completed 5 lessons!'**
  String get achievement5Lessons;

  /// Achievement message for fixing all mistakes
  ///
  /// In en, this message translates to:
  /// **'You fixed all your mistakes!'**
  String get achievementNoMistakes;

  /// Generic achievement unlocked message
  ///
  /// In en, this message translates to:
  /// **'New Achievement!'**
  String get achievementUnlocked;

  /// Title for achievement dialog
  ///
  /// In en, this message translates to:
  /// **'Achievement'**
  String get achievementTitle;

  /// Label for achievement unlock instructions
  ///
  /// In en, this message translates to:
  /// **'How to unlock:'**
  String get achievementDescription;

  /// Title for achievements gallery page
  ///
  /// In en, this message translates to:
  /// **'Achievements Gallery'**
  String get achievementGalleryTitle;

  /// Detailed description for first quiz achievement
  ///
  /// In en, this message translates to:
  /// **'You completed your first test. Well done!'**
  String get achievementFirstQuizDesc;

  /// Detailed description for perfect score achievement
  ///
  /// In en, this message translates to:
  /// **'You completed the test without any mistakes!'**
  String get achievementPerfectScoreDesc;

  /// Detailed description for 100 XP achievement
  ///
  /// In en, this message translates to:
  /// **'You earned 100 experience points!'**
  String get achievement100XPDesc;

  /// Detailed description for 5 lessons achievement
  ///
  /// In en, this message translates to:
  /// **'You completed 5 lessons. Keep it up!'**
  String get achievement5LessonsDesc;

  /// Detailed description for no mistakes achievement
  ///
  /// In en, this message translates to:
  /// **'You fixed all your mistakes. True hero!'**
  String get achievementNoMistakesDesc;

  /// Generic achievement unlocked description
  ///
  /// In en, this message translates to:
  /// **'Achievement unlocked!'**
  String get achievementUnlockedDesc;

  /// Hint for unlocking first quiz achievement
  ///
  /// In en, this message translates to:
  /// **'Complete at least one test.'**
  String get achievementFirstQuizHint;

  /// Hint for unlocking perfect score achievement
  ///
  /// In en, this message translates to:
  /// **'Answer all questions correctly in one test.'**
  String get achievementPerfectScoreHint;

  /// Hint for unlocking 100 XP achievement
  ///
  /// In en, this message translates to:
  /// **'Earn at least 100 XP.'**
  String get achievement100XPHint;

  /// Hint for unlocking 5 lessons achievement
  ///
  /// In en, this message translates to:
  /// **'Complete 5 different lessons.'**
  String get achievement5LessonsHint;

  /// Hint for unlocking no mistakes achievement
  ///
  /// In en, this message translates to:
  /// **'Retake all mistakes without errors.'**
  String get achievementNoMistakesHint;

  /// Generic hint for unlocking achievements
  ///
  /// In en, this message translates to:
  /// **'Complete the requirements to unlock.'**
  String get achievementGenericHint;

  /// No description provided for @achievementHowToUnlock.
  ///
  /// In en, this message translates to:
  /// **'How to unlock?'**
  String get achievementHowToUnlock;

  /// text in achievement button
  ///
  /// In en, this message translates to:
  /// **'View achievements'**
  String get achievementButtonText;

  /// 123
  ///
  /// In en, this message translates to:
  /// **'Error Quiz'**
  String get errorQuizTitle;

  /// No description provided for @errorQuizDesc.
  ///
  /// In en, this message translates to:
  /// **'Practice your mistakes to improve!'**
  String get errorQuizDesc;

  /// No description provided for @errorQuizStartButton.
  ///
  /// In en, this message translates to:
  /// **'Start Error Quiz'**
  String get errorQuizStartButton;

  /// Login page title
  ///
  /// In en, this message translates to:
  /// **'LOGIN'**
  String get login;

  /// Registration page title
  ///
  /// In en, this message translates to:
  /// **'REGISTRATION'**
  String get registration;

  /// Email field label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Username field label
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// Confirm password field label
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// Email field hint
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterEmail;

  /// Password field hint
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterPassword;

  /// Username field hint
  ///
  /// In en, this message translates to:
  /// **'Enter your username'**
  String get enterUsername;

  /// Confirm password field hint
  ///
  /// In en, this message translates to:
  /// **'Re-enter your password'**
  String get reenterPassword;

  /// Sign in button text
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// Sign up button text
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// Text for signup link
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Sign Up'**
  String get noAccount;

  /// Text for signin link
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign In'**
  String get haveAccount;

  /// Title for the guess character page
  ///
  /// In en, this message translates to:
  /// **'Guess the Character'**
  String get guessCharacterTitle;

  /// Label for the input field in guess character page
  ///
  /// In en, this message translates to:
  /// **'Who is this?'**
  String get guessCharacterInputLabel;

  /// Text for the submit button in guess character page
  ///
  /// In en, this message translates to:
  /// **'Answer'**
  String get guessCharacterSubmitButton;

  /// Message shown when the guess is correct
  ///
  /// In en, this message translates to:
  /// **'✅ Correct! This is {name}'**
  String guessCharacterCorrect(String name);

  /// Message shown when the guess is incorrect
  ///
  /// In en, this message translates to:
  /// **'❌ Incorrect. Try again.'**
  String get guessCharacterIncorrect;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ky'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ky': return AppLocalizationsKy();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
