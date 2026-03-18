class AppRegex {
  const AppRegex._();

  static final RegExp email = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

  static final RegExp password = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*\-]).{8,}$',
  );

  static final RegExp phoneNumber = RegExp(r'^\+(?:\d\s?){6,14}\d$');

  static final RegExp subDomain = RegExp(r'^[a-z0-9-]+$');

  static final RegExp instagramUserName = RegExp(
    r'^(?!.*\.\.)[a-zA-Z0-9_.]{1,30}$',
  );

  static final RegExp facebookUserName = RegExp(
    r'^(?!.*\.\.)[a-zA-Z0-9.]{5,50}$',
  );

  static final RegExp tikTokUserName = RegExp(
    r'^(?!.*\.\.)[a-zA-Z0-9_.]{2,24}$',
  );
}
