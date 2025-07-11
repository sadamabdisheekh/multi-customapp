class RemoteUrls {
  static const String rootUrl = 'http://192.168.100.28:3000';
  //"http://160.119.251.252:3000"; 192.168.75.67

  static const login = '$rootUrl/auth/login';
  static const signup = '$rootUrl/customers/create';
  static const modulesList = '$rootUrl/modules/get-modules';
  static String category(categoryId,moduleId) =>
      '$rootUrl/item/getcategoryhierarchy?categoryId=$categoryId&moduleId=$moduleId';

  static String subCategory(int categoryId) =>
      '$rootUrl/sub-category/findSubCategory/$categoryId';
  static const items = '$rootUrl/item/getitemsbyfilter';
  static const itemAttributes = '$rootUrl/item/getitemattributes';

  static String getItemDetails(int storeItemId) =>
      '$rootUrl/item/getitemdetailsbyfilter?storeItemId=$storeItemId';

  static const addToCart = '$rootUrl/cart/addtocart';

  static const getCartItems = '$rootUrl/cart/getcartitems';

  static String incrementquantity(int storeItemId) => '$rootUrl/cart/incrementquantity/$storeItemId';
  static String decrementquantity(int storeItemId) => '$rootUrl/cart/decrementquantity/$storeItemId';
  static String removecartitem(int storeItemId) => '$rootUrl/cart/removecartitem/$storeItemId';

  static const getPaymentMethods = '$rootUrl/order/paymentmethods';
  static const getUserOrders = '$rootUrl/order/userorders';
  static String getOrderDetails(int orderId) => '$rootUrl/order/userorderdetails?orderId=$orderId';


  static const createOrder = '$rootUrl/order/createorder';

  
  static const getAddress = '$rootUrl/address/get-addreses';
  static const getParcelTypes = '$rootUrl/parcel/get-parcel-types';


}
