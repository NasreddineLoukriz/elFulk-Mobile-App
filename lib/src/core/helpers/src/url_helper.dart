import 'utils/extensions.dart';

class UrlHelper {
  const UrlHelper._();

  static String getUserNameFacebookUrl(String userName) =>
      'https://facebook.com/${userName.trim()}';

  static String getUserNameInstagramUrl(String userName) =>
      'https://instagram.com/${userName.trim()}';

  static String getUserNameTiktokUrl(String userName) =>
      'https://tiktok.com/@${userName.trim()}';

  static String getUserNameFromUrl(String? url) {
    if (url.isNullOrEmpty()) {
      return '';
    }

    final List<String> urlParts = url!.split('/');
    return urlParts.isEmpty ? '' : urlParts.last;
  }

  static String getUserNameFromTiktokUrl(String? url) {
    if (url.isNullOrEmpty()) {
      return '';
    }

    final List<String> urlParts = url!.split('/');
    return urlParts.isEmpty ? '' : urlParts.last.replaceFirst('@', '');
  }
}
