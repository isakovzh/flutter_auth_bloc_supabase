// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Manas App';

  @override
  String quizTitle(String lessonTitle) {
    return 'Quiz: $lessonTitle';
  }

  @override
  String questionCounter(int current, int total) {
    return 'Question $current/$total';
  }

  @override
  String get quizCompleted => 'Quiz Completed';

  @override
  String quizResults(int correct, int total, int xp) {
    return 'You answered $correct / $total correctly.\nYou earned $xp XP!';
  }

  @override
  String errorQuizResults(int correct, int total, int xp) {
    return 'You answered $correct / $total correctly.\nYou earned $xp XP! (5 XP per correct answer)';
  }

  @override
  String get done => 'Done';

  @override
  String get settings => 'Settings';

  @override
  String get changeTheme => 'Change Theme';

  @override
  String get changeLanguage => 'Change Language';

  @override
  String get logout => 'Logout';

  @override
  String get profile => 'Profile';

  @override
  String get viewAchievements => 'View Achievements';

  @override
  String get achievementsGallery => 'Achievements Gallery';

  @override
  String get ok => 'OK';

  @override
  String get lessons => 'Lessons';

  @override
  String get startQuiz => 'Start Quiz';

  @override
  String get startErrorQuiz => 'Start Error Quiz';

  @override
  String get errorQuiz => 'Error Quiz';

  @override
  String get errorQuizCompleted => 'Error Quiz Completed';

  @override
  String get open => 'Open';

  @override
  String get characters => 'Characters';

  @override
  String error(String message) {
    return 'Error: $message';
  }

  @override
  String xpPoints(String points) {
    return 'XP: $points';
  }

  @override
  String get eposChapters => 'Chapters of Manas Epos';

  @override
  String get errorLoadingChapters => 'Error loading chapters';

  @override
  String get pause => 'Pause';

  @override
  String get listen => 'Listen';

  @override
  String lessonsCompleted(int completed) {
    return 'Lessons Completed: $completed';
  }

  @override
  String get retakeQuiz => 'Retake Quiz';

  @override
  String get takeQuiz => 'Take Quiz';

  @override
  String correctAnswersCount(int correct, int total) {
    return '$correct/$total correct';
  }

  @override
  String charactersUnlocked(int unlocked, int total) {
    return 'Characters Unlocked: $unlocked / $total';
  }

  @override
  String get weeklyXpProgress => 'Weekly XP Progress';

  @override
  String get monday => 'Mon';

  @override
  String get tuesday => 'Tue';

  @override
  String get wednesday => 'Wed';

  @override
  String get thursday => 'Thu';

  @override
  String get friday => 'Fri';

  @override
  String get saturday => 'Sat';

  @override
  String get sunday => 'Sun';

  @override
  String get achievementFirstQuiz => 'You completed your first quiz!';

  @override
  String get achievementPerfectScore => 'Perfect score - all answers correct!';

  @override
  String get achievement100XP => 'You earned 100 XP!';

  @override
  String get achievement5Lessons => 'You completed 5 lessons!';

  @override
  String get achievementNoMistakes => 'You fixed all your mistakes!';

  @override
  String get achievementUnlocked => 'New Achievement!';

  @override
  String get achievementTitle => 'Achievement';

  @override
  String get achievementDescription => 'How to unlock:';

  @override
  String get achievementGalleryTitle => 'Achievements Gallery';

  @override
  String get achievementFirstQuizDesc => 'You completed your first test. Well done!';

  @override
  String get achievementPerfectScoreDesc => 'You completed the test without any mistakes!';

  @override
  String get achievement100XPDesc => 'You earned 100 experience points!';

  @override
  String get achievement5LessonsDesc => 'You completed 5 lessons. Keep it up!';

  @override
  String get achievementNoMistakesDesc => 'You fixed all your mistakes. True hero!';

  @override
  String get achievementUnlockedDesc => 'Achievement unlocked!';

  @override
  String get achievementFirstQuizHint => 'Complete at least one test.';

  @override
  String get achievementPerfectScoreHint => 'Answer all questions correctly in one test.';

  @override
  String get achievement100XPHint => 'Earn at least 100 XP.';

  @override
  String get achievement5LessonsHint => 'Complete 5 different lessons.';

  @override
  String get achievementNoMistakesHint => 'Retake all mistakes without errors.';

  @override
  String get achievementGenericHint => 'Complete the requirements to unlock.';

  @override
  String get achievementHowToUnlock => 'How to unlock?';

  @override
  String get achievementButtonText => 'View achievements';

  @override
  String get errorQuizTitle => 'Error Quiz';

  @override
  String get errorQuizDesc => 'Practice your mistakes to improve!';

  @override
  String get errorQuizStartButton => 'Start Error Quiz';

  @override
  String get login => 'LOGIN';

  @override
  String get registration => 'REGISTRATION';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get username => 'Username';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get enterEmail => 'Enter your email';

  @override
  String get enterPassword => 'Enter your password';

  @override
  String get enterUsername => 'Enter your username';

  @override
  String get reenterPassword => 'Re-enter your password';

  @override
  String get signIn => 'Sign In';

  @override
  String get signUp => 'Sign Up';

  @override
  String get noAccount => 'Don\'t have an account? Sign Up';

  @override
  String get haveAccount => 'Already have an account? Sign In';

  @override
  String get guessCharacterTitle => 'Guess the Character';

  @override
  String get guessCharacterInputLabel => 'Who is this?';

  @override
  String get guessCharacterSubmitButton => 'Answer';

  @override
  String guessCharacterCorrect(String name) {
    return '✅ Correct! This is $name';
  }

  @override
  String get guessCharacterIncorrect => '❌ Incorrect. Try again.';
}
