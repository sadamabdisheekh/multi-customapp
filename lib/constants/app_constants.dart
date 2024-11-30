import 'dart:ui';
import '../data/remote_urls.dart';

class AppConstants {
  static const String appName = "NextShop";
  static const String cachedUserResponseKey = "cachhUserResponse";
  static const String fontFamily = 'Roboto';
  static Color lightGrey = const Color(0xFFF5F5F5);

  // image url links

  static const String modulePath = '${RemoteUrls.rootUrl}/uploads/modules';
  static const String categoryPath = '${RemoteUrls.rootUrl}/uploads/category/';
  static const String itemsPath = '${RemoteUrls.rootUrl}/uploads/items/';

}
