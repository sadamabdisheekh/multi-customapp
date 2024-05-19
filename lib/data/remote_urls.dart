class RemoteUrls {
  static const String rootUrl = 'http://127.0.0.1:3000';
  //"http://160.119.251.252:3000";

  static const login = '$rootUrl/auth/login';
  static const signup = '$rootUrl/users';
  static const modulesList = '$rootUrl/modules';
  static const category = '$rootUrl/category';

  static String subCategory(int categoryId) =>
      '$rootUrl/sub-category/findSubCategory/$categoryId';
}
