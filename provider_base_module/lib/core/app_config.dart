class AppConfig {
  static const String apiTestUrl = "http://192.168.1.12:8000/api";
  static const String apiProdUrl = "https://ai-avatar-backend-production.up.railway.app/docs#/";
  static const String imageUrl = "http://192.168.1.12:8000";
  static const String apiTestKey = "";
  static const String apiProdKey = "";
  static const reverseAddressApi = "";
  static const String mapApiKey = "";
  static const bool isProduction = true;

  static String get baseUrl => isProduction ? apiProdUrl : apiTestUrl;

  static String get apiKey => isProduction ? apiProdKey : apiTestKey;

  //auth api call
  static const String actionSignIn = '/login';
  static const String actionSignUp = '/register';
  static const String actionProfile = '/profile';
  static const String actionServiceCategory = '/categories';
  static const String actionServiceSubsCategory = '/subcategories';
  static const String actionServiceProductDetails = '/products';
  static const String actionFormStateDetails = '/apply-form';
  static const String actionPolicyDetails = '/policy-details';
  static const String actionUpdateProfile = '/profile/update';
  static const String actionSubmitFormDetails = '/individualKycAddOrUpdate';
}
