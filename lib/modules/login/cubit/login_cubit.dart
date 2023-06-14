import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/modules/login/cubit/login_states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../shared/components/components.dart';
import '../../../shared/network/end_points.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  bool isPassword = true;

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void changePswdVisibility() {
    isPassword = !isPassword;
    emit(ShopLoginChangePasswordVisiblity());
  }

  late ShopLoginModel loginModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());

    DioHelper.postData(
            url: LOGIN,
            data: {
              "email": email,
              "password": password,
            },
            token: token)
        .then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      print(value.data);
      Restart.restartApp();
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      emit(ShopLoginErrorState(error.toString()));
      print("error is while singing in  ======== ${error.toString()}");
    });
  }

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());

    DioHelper.postData(
            url: REGISTER,
            data: {
              "name": name,
              "email": email,
              "password": password,
              "phone": phone,
            },
            token: token)
        .then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      print(value.data);
      emit(ShopRegisterSuccessState(loginModel));
      Restart.restartApp();
    }).catchError((error) {
      emit(ShopRegisterErrorState(error.toString()));
      print("error is while registering  ======== ${error.toString()}");
    });
  }

  void upadateProfile({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopUpdateProfileLoadingState());
    DioHelper.putData(url: UPDATE_PROFILE, token: token, data: {
      "name": name,
      "email": email,
      "phone": phone,
    }).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      print(value.data);
      emit(ShopUpdateProfileSuccessState(loginModel));
    }).catchError((error) {
      emit(ShopUpdateProfileErrorState(error));
      print('error while updating profile ========= ${error.toString()}');
    });
  }
}
