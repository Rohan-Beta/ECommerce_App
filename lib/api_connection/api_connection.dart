class API {
  // api connection with server
  static const hostConnect = "http://192.168.0.7/api_ecommerce";
  static const hostConnectUser = "$hostConnect/user";
  static const hostConnectAdmin = "$hostConnect/admin";
  static const hostUploadtItem = "$hostConnect/items";
  static const hostCloth = "$hostConnect/clothes";

  // signIn and logIn user
  static const validateEmail = "$hostConnectUser/validate_email.php";
  static const signUp = "$hostConnectUser/signup.php";
  static const login = "$hostConnectUser/login.php";

  // login admin
  static const adminValidateEmail = "$hostConnectAdmin/validate_email.php";
  static const adminSignUp = "$hostConnectAdmin/signup.php";
  static const adminLogin = "$hostConnectAdmin/login.php";

  // upload and save items info
  static const uploadNewItem = "$hostUploadtItem/upload_items.php";

  // clothes
  static const trendingClothes = "$hostCloth/trending.php";
  static const allClothes = "$hostCloth/all_items.php";
}

// static const hostConnect = "http://ipaddress/file name in htdocs";

// to find ipaddress run ipconfig in cmd