abstract class AppColors {
  //应用主题色
  static const APP_THEME = 0xff63ca6c;
  static const APPBAR = 0xffffffff;
}

abstract class AppInfos {
  static const String CLIENT_ID = 'hNfx6TZiF1BQoj8ankap';
  static const String CLIENT_SECRET = '3a8JFtfc5rsKn3Qu4tWU71BKKCDW7M5S';
  static const String REDIRECT_URI = 'https://www.baidu.com/';
}

abstract class AppUrls {
  static const String HOST = 'https://www.baidu.com/';

  static const String OAUTH2_AUTHORIZE = HOST + "action/oauth2/authorize";
  static const String OAUTH2_TOKEN = HOST + 'action/openapi/token';
}
