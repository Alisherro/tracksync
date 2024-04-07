import 'strings.dart';

/// The translations for Russian (`ru`).
class StringsRu extends Strings {
  StringsRu([String locale = 'ru']) : super(locale);

  @override
  String get dashboard => 'Панель управления';

  @override
  String get about => 'О приложении';

  @override
  String get selectDate => 'Выбрать дату';

  @override
  String get selectTime => 'Выбрать время';

  @override
  String get select => 'Выбрать';

  @override
  String get cancel => 'Отмена';

  @override
  String get pleaseWait => 'Пожалуйста, подождите...';

  @override
  String get login => 'Войти';

  @override
  String get email => 'Электронная почта';

  @override
  String get password => 'Пароль';

  @override
  String get register => 'Зарегистрироваться';

  @override
  String get askRegister => 'Нет аккаунта?';

  @override
  String get errorInvalidEmail => 'Электронная почта недействительна';

  @override
  String get errorInvalidName => 'Некорректное имя';

  @override
  String get errorEmptyField => 'Не может быть пустым';

  @override
  String get errorPasswordLength => 'Пароль должен быть не менее 6 символов';

  @override
  String get passwordRepeat => 'Повторите пароль';

  @override
  String get errorPasswordNotMatch => 'Пароли не совпадают';

  @override
  String get settings => 'Настройки';

  @override
  String get themeLight => 'Светлая тема';

  @override
  String get themeDark => 'Темная тема';

  @override
  String get themeSystem => 'Системная тема';

  @override
  String get chooseTheme => 'Выбрать тему';

  @override
  String get chooseLanguage => 'Выбрать язык';

  @override
  String get errorNoData => 'Нет данных';

  @override
  String get logout => 'Выйти';

  @override
  String get logoutDesc => 'Вы хотите выйти из приложения?';

  @override
  String get yes => 'Да';
}
