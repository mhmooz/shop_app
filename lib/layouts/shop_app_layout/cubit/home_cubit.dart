import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_app_layout/cubit/home_states.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';
import 'package:shop_app/models/favorites_model/get_favorites_model.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/modules/home/categories/categories.dart';
import 'package:shop_app/modules/home/favourites/favourites.dart';
import 'package:shop_app/modules/home/settings/settings.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../models/favorites_model/change_favorites_model.dart';
import '../../../modules/home/products/products.dart';

class HomeCubit extends Cubit<ShopHomeStates> {
  HomeCubit() : super(ShopHomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  void changeBottomIndex(index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  List<Widget> screens = [
    const ProductsScreen(),
    const FavouritesScreen(),
    const CategoriesScreen(),
    SettingsScreen(),
  ];
  List<String> titles = [
    'Home',
    'Favourites',
    'Categories',
    'Settings',
  ];

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopHomeLoadingState());

    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id!: element.inFavourites!,
        });
      });
      emit(ShopHomeSuccessState());
    }).catchError((error) {
      printFullText('error is ============= ${error.toString()}');
      emit(ShopHomeErrorState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(url: CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopCategoriesSuccessState());
    }).catchError((error) {
      printFullText(
          'error while getting the categories is ============= ${error.toString()}');
      emit(ShopCategoriesErrorState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeIconFavouritesState());
    DioHelper.postData(
            url: FAVORITES, data: {'product_id': productId}, token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavoutiesData();
      }
      emit(ShopChangeFavouritesSuccessState());
    }).catchError((error) {
      emit(ShopChangeFavouritesErrorState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavoutiesData() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fomJson(value.data);
      emit(ShopGetFavoritesSuccessState());
    }).catchError((error) {
      print('error while getting favorites======== ${error.toString()}');
      emit(ShopGetFavoritesErrorState());
    });
  }

  late ShopLoginModel loginModel;

  void getUserData() {
    emit(ShopLoadingGetUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopGetUserDataSuccessState());
    }).catchError((error) {
      printFullText(
          'error while getting the userdata is ============= ${error.toString()}');
      emit(ShopGetUserDataErrorState());
    });
  }
}
