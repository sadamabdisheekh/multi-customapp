class RemoteUrls {
  static const String rootUrl = 'http://192.168.100.28:3000';
  //"http://160.119.251.252:3000";

  static const login = '$rootUrl/auth/login';
  static const signup = '$rootUrl/users';
  static const modulesList = '$rootUrl/modules';
  static String category(categoryId) => '$rootUrl/item/getcategoryhierarchy?categoryId=$categoryId';

  static String subCategory(int categoryId) =>
      '$rootUrl/sub-category/findSubCategory/$categoryId';
  static const items = '$rootUrl/item/getitemsbyfilter';

  static String getItemDetails(int storeItemId) =>
      '$rootUrl/item/getItemDetailsForMobile?storeItemId=$storeItemId';

  static const addToCart = '$rootUrl/cart/addtocart';

  static const getCartItems = '$rootUrl/cart/getcartitems';

}
