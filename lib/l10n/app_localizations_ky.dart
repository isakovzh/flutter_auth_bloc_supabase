// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kirghiz Kyrgyz (`ky`).
class AppLocalizationsKy extends AppLocalizations {
  AppLocalizationsKy([String locale = 'ky']) : super(locale);

  @override
  String get appTitle => 'Манас колдонмосу';

  @override
  String quizTitle(String lessonTitle) {
    return 'Тест: $lessonTitle';
  }

  @override
  String questionCounter(int current, int total) {
    return 'Суроо $current/$total';
  }

  @override
  String get quizCompleted => 'Тест аяктады';

  @override
  String quizResults(int correct, int total, int xp) {
    return 'Сиз $correct / $total туура жооп бердиңиз.\nСиз $xp XP утуп алдыңыз!';
  }

  @override
  String errorQuizResults(int correct, int total, int xp) {
    return 'Сиз $correct / $total туура жооп бердиңиз.\nСиз $xp XP утуп алдыңыз! (ар бир туура жооп үчүн 5 XP)';
  }

  @override
  String get done => 'Бүттү';

  @override
  String get settings => 'Орнотуулар';

  @override
  String get changeTheme => 'Теманы өзгөртүү';

  @override
  String get changeLanguage => 'Тилди өзгөртүү';

  @override
  String get logout => 'Чыгуу';

  @override
  String get profile => 'Профиль';

  @override
  String get viewAchievements => 'Жетишкендиктерди көрүү';

  @override
  String get achievementsGallery => 'Жетишкендиктер галереясы';

  @override
  String get ok => 'Макул';

  @override
  String get lessons => 'Сабактар';

  @override
  String get startQuiz => 'Тестти баштоо';

  @override
  String get startErrorQuiz => 'Ката тестин баштоо';

  @override
  String get errorQuiz => 'Ката тести';

  @override
  String get errorQuizCompleted => 'Ката тести аяктады';

  @override
  String get open => 'Ачуу';

  @override
  String get characters => 'Каармандар';

  @override
  String error(String message) {
    return 'Ката: $message';
  }

  @override
  String xpPoints(String points) {
    return 'XP: $points';
  }

  @override
  String get eposChapters => 'Манас эпосунун бөлүмдөрү';

  @override
  String get errorLoadingChapters => 'Бөлүмдөрдү жүктөөдө ката кетти';

  @override
  String get pause => 'Тыныгуу';

  @override
  String get listen => 'Угуу';

  @override
  String lessonsCompleted(int completed) {
    return 'Аяктаган сабактар: $completed';
  }

  @override
  String get retakeQuiz => 'Тестти кайра тапшыруу';

  @override
  String get takeQuiz => 'Тестти тапшыруу';

  @override
  String correctAnswersCount(int correct, int total) {
    return '$correct/$total туура';
  }

  @override
  String charactersUnlocked(int unlocked, int total) {
    return 'Ачылган каармандар: $unlocked / $total';
  }

  @override
  String get weeklyXpProgress => 'Апталык XP прогресси';

  @override
  String get monday => 'Дүй';

  @override
  String get tuesday => 'Шей';

  @override
  String get wednesday => 'Шар';

  @override
  String get thursday => 'Бей';

  @override
  String get friday => 'Жум';

  @override
  String get saturday => 'Ишм';

  @override
  String get sunday => 'Жек';

  @override
  String get achievementFirstQuiz => 'Сиз биринчи тестти өттүңүз!';

  @override
  String get achievementPerfectScore => 'Мыкты жыйынтык - бардык жооптор туура!';

  @override
  String get achievement100XP => 'Сиз 100 XP топтодуңуз!';

  @override
  String get achievement5Lessons => 'Сиз 5 сабакты аяктадыңыз!';

  @override
  String get achievementNoMistakes => 'Сиз бардык каталарды оңдодуңуз!';

  @override
  String get achievementUnlocked => 'Жаңы жетишкендик!';

  @override
  String get achievementTitle => 'Жетишкендик';

  @override
  String get achievementDescription => 'Кантип ачса болот:';

  @override
  String get achievementGalleryTitle => 'Жетишкендиктер галереясы';

  @override
  String get achievementFirstQuizDesc => 'Сиз биринчи тестти өттүңүз. Азаматсыз!';

  @override
  String get achievementPerfectScoreDesc => 'Сиз тестти бир да катасыз өттүңүз!';

  @override
  String get achievement100XPDesc => 'Сиз 100 тажрыйба упайын топтодуңуз!';

  @override
  String get achievement5LessonsDesc => 'Сиз 5 сабакты аяктадыңыз. Алга!';

  @override
  String get achievementNoMistakesDesc => 'Сиз бардык каталарды оңдодуңуз. Чыныгы баатыр!';

  @override
  String get achievementUnlockedDesc => 'Жетишкендик ачылды!';

  @override
  String get achievementFirstQuizHint => 'Жок дегенде бир тестти өтүңүз.';

  @override
  String get achievementPerfectScoreHint => 'Бир тесттин бардык суроолоруна туура жооп бериңиз.';

  @override
  String get achievement100XPHint => '100 XP топтоңуз.';

  @override
  String get achievement5LessonsHint => '5 ар башка сабакты аяктаңыз.';

  @override
  String get achievementNoMistakesHint => 'Бардык каталарды кайра катасыз өтүңүз.';

  @override
  String get achievementGenericHint => 'Ачуу үчүн талаптарды аткарыңыз.';

  @override
  String get achievementHowToUnlock => 'Кантип ачса болот?';

  @override
  String get achievementButtonText => 'Жетишкендиктерди көрүү';

  @override
  String get errorQuizTitle => 'Ката сынагы';

  @override
  String get errorQuizDesc => 'Жакшыртуу үчүн каталарыңызды көнүгүңүз!';

  @override
  String get errorQuizStartButton => 'Ката тестин баштоо';

  @override
  String get login => 'КИРҮҮ';

  @override
  String get registration => 'КАТТОО';

  @override
  String get email => 'Электрондук почта';

  @override
  String get password => 'Сырсөз';

  @override
  String get username => 'Колдонуучунун аты';

  @override
  String get confirmPassword => 'Сырсөздү ырастаңыз';

  @override
  String get enterEmail => 'Электрондук почтаңызды киргизиңиз';

  @override
  String get enterPassword => 'Сырсөзүңүздү киргизиңиз';

  @override
  String get enterUsername => 'Колдонуучу атыңызды киргизиңиз';

  @override
  String get reenterPassword => 'Сырсөзүңүздү кайра киргизиңиз';

  @override
  String get signIn => 'Кирүү';

  @override
  String get signUp => 'Катталуу';

  @override
  String get noAccount => 'Аккаунтуңуз жокпу? Катталыңыз';

  @override
  String get haveAccount => 'Аккаунтуңуз барбы? Кириңиз';

  @override
  String get guessCharacterTitle => 'Каарманды тап';

  @override
  String get guessCharacterInputLabel => 'Бул ким?';

  @override
  String get guessCharacterSubmitButton => 'Жооп берүү';

  @override
  String guessCharacterCorrect(String name) {
    return '✅ Туура! Бул $name';
  }

  @override
  String get guessCharacterIncorrect => '❌ Туура эмес. Кайра аракет кылыңыз.';
}
