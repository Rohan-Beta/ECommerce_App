class API {
  static const hostConnect = "http://192.168.0.6/api_ecommerce";
  static const hostConnectUser = "$hostConnect/user";

  // sign in user
  static const validateEmail = "$hostConnect/user/validate_email.php";
  static const signUp = "$hostConnect/user/signup.php";
  static const login = "$hostConnect/user/login.php";
}

// static const hostConnect = "http://ipaddress/file name in htdocs";

// to find ipaddress run ipconfig in cmd