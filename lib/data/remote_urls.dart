class RemoteUrls {
  static const String rootUrl = 'http://0.0.0.0:3000';
  //"http://160.119.251.252:3000";

  static const login = '$rootUrl/auth/login';
  static const signup = '$rootUrl/users';
  static const modulesList = '$rootUrl/modules';
  static String category(categoryId) => '$rootUrl/item/getcategoryhierarchy?categoryId=$categoryId';

  static String subCategory(int categoryId) =>
      '$rootUrl/sub-category/findSubCategory/$categoryId';
  static const items = '$rootUrl/item/filter';
}
