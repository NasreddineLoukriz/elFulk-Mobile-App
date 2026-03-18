import 'package:url_launcher/url_launcher.dart';

enum UrlLauncherSchemeEnum {
  tel('tel'),
  mailto('mailto'),
  sms('sms');

  const UrlLauncherSchemeEnum(this.value);

  final String value;
}

class UrlLauncherHelper {
  const UrlLauncherHelper._();

  static Future<bool> canLaunchUrlString(String url) async {
    return canLaunchUrl(Uri.parse(url));
  }

  static Future<bool> launchUrlString(String url) async {
    return launchUrl(Uri.parse(url));
  }

  static Future<bool> canLaunchPhoneCall(String phoneNumber) async {
    return canLaunchUrl(
      Uri(scheme: UrlLauncherSchemeEnum.tel.value, path: phoneNumber),
    );
  }

  static Future<bool> launchPhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: UrlLauncherSchemeEnum.tel.value,
      path: phoneNumber,
    );

    return launchUrl(launchUri);
  }

  static Uri _buildEmailUri(String email, {String? subject, String? body}) {
    return Uri(
      scheme: UrlLauncherSchemeEnum.mailto.value,
      path: email,
      queryParameters: <String, String>{
        if (subject != null && subject.trim().isNotEmpty)
          'subject': subject.trim(),
        if (body != null && body.trim().isNotEmpty) 'body': body.trim(),
      },
    );
  }

  static Future<bool> canLaunchEmail(
    String email, [
    String? subject,
    String? body,
  ]) async {
    return canLaunchUrl(_buildEmailUri(email, subject: subject, body: body));
  }

  static Future<bool> launchEmail(
    String email, {
    String? subject,
    String? body,
  }) async {
    return launchUrl(_buildEmailUri(email, subject: subject, body: body));
  }
}
