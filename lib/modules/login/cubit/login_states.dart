import 'package:shop_app/models/login_model/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginStates {
  final String error;
  ShopLoginErrorState(this.error);
}

class ShopLoginChangePasswordVisiblity extends ShopLoginStates {}

class ShopRegisterLoadingState extends ShopLoginStates {}

class ShopRegisterSuccessState extends ShopLoginStates {
 late final ShopLoginModel loginModel;
  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterErrorState extends ShopLoginStates {
  final String error;
  ShopRegisterErrorState(this.error);
}

class ShopUpdateProfileLoadingState extends ShopLoginStates {}

class ShopUpdateProfileSuccessState extends ShopLoginStates {
 late final ShopLoginModel loginModel;
  ShopUpdateProfileSuccessState(this.loginModel);
}

class ShopUpdateProfileErrorState extends ShopLoginStates {
  final String error;
  ShopUpdateProfileErrorState(this.error);
}