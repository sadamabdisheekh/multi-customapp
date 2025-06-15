class RemoteUrls {
  static const String rootUrl = 'http://192.168.218.67:3000';
  //"http://160.119.251.252:3000"; 192.168.75.67

  static const login = '$rootUrl/auth/login';
  static const signup = '$rootUrl/customers/create';
  static const modulesList = '$rootUrl/modules/get-modules';
  static String category(categoryId) =>
      '$rootUrl/item/getcategoryhierarchy?categoryId=$categoryId';

  static String subCategory(int categoryId) =>
      '$rootUrl/sub-category/findSubCategory/$categoryId';
  static const items = '$rootUrl/item/getitemsbyfilter';
  static const itemAttributes = '$rootUrl/item/getitemattributes';

  static String getItemDetails(int storeItemId) =>
      '$rootUrl/item/getItemDetailsForMobile?storeItemId=$storeItemId';

  static const addToCart = '$rootUrl/cart/addtocart';

  static const getCartItems = '$rootUrl/cart/getcartitems';

  static String incrementquantity(int storeItemId) => '$rootUrl/cart/incrementquantity/$storeItemId';
  static String decrementquantity(int storeItemId) => '$rootUrl/cart/decrementquantity/$storeItemId';
  static String removecartitem(int storeItemId) => '$rootUrl/cart/removecartitem/$storeItemId';

  static const getPaymentMethods = '$rootUrl/order/paymentmethods';

  static const createOrder = '$rootUrl/order/createorder';

}
