import 'strings.dart';

/// The translations for Kazakh (`kk`).
class StringsKk extends Strings {
  StringsKk([String locale = 'kk']) : super(locale);

  @override
  String get dashboard => 'Басқару тақтасы';

  @override
  String get about => 'Қосымша туралы';

  @override
  String get selectDate => 'Күнді таңдаңыз';

  @override
  String get selectTime => 'Уақытты таңдаңыз';

  @override
  String get select => 'Таңдау';

  @override
  String get cancel => 'Бас тарту';

  @override
  String get pleaseWait => 'Күте тұрыңыз...';

  @override
  String get login => 'Кіру';

  @override
  String get email => 'Электрондық пошта';

  @override
  String get password => 'Құпия сөз';

  @override
  String get register => 'Тіркелу';

  @override
  String get askRegister => 'Тіркелгіңіз жоқ па?';

  @override
  String get errorInvalidEmail => 'Электрондық пошта жарамсыз';

  @override
  String get errorInvalidName => 'Жарамсыз ат';

  @override
  String get errorEmptyField => 'Бос болмауы керек';

  @override
  String get errorPasswordLength => 'Құпия сөз кемінде 6 таңбадан тұруы керек';

  @override
  String get passwordRepeat => 'Құпия сөзді қайталаңыз';

  @override
  String get errorPasswordNotMatch => 'Құпия сөздер сәйкес келмейді';

  @override
  String get settings => 'Баптаулар';

  @override
  String get themeLight => 'Жарық тақырып';

  @override
  String get themeDark => 'Қараңғы тақырып';

  @override
  String get themeSystem => 'Жүйелік тақырып';

  @override
  String get chooseTheme => 'Тақырып таңдаңыз';

  @override
  String get chooseLanguage => 'Тілді таңдаңыз';

  @override
  String get errorNoData => 'Деректер жоқ';

  @override
  String get logout => 'Шығу';

  @override
  String get logoutDesc => 'Қосымшадан шығғыңыз келе ме?';

  @override
  String get yes => 'Иә';
}
