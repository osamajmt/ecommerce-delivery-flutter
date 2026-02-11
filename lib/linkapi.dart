
class AppLink {
  // Base Url
  static const baseURL = 'http://10.0.2.2:8000/api';
  // static const baseURL = 'http://192.168.1.105:8000/api';
  // Images
  static const baseImagesURL = 'http://10.0.2.2:8000/images';
  static const categoriesImages = baseImagesURL + '/categories';
  static const itemsImages = baseImagesURL + '/items';
   static const usersImages = baseImagesURL + '/users';
   
  // Auth
  static const loginURL = baseURL + '/delivery/login';
  static const updateUserImage = baseURL + '/image/update';
  static const verifyEmail = baseURL + '/verifyEmail';
  static const sendCode = baseURL + '/sendCode';
  static const resetPassword = baseURL + '/resetPassword';
  static const logoutURL = baseURL + '/logout';

  //settings
   static const settings = baseURL + "/settings";


  //notifications
  static const notifications = baseURL + "/notifications";


 // Home(pending orders)
  static const availableOrders = baseURL + '/delivery/orders/available';
  static const acceptOrder = baseURL + '/delivery/orders/accept';
  static const startOrder = baseURL + '/delivery/orders/start';
  static const currentOrders = baseURL + '/delivery/orders/current';
  static const completeOrder = baseURL + '/delivery/orders/complete';
  static const orderDetails = baseURL + '/orders';
}
