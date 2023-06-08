import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_app_layout/cubit/home_states.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/modules/home/categories/categories.dart';
import 'package:shop_app/modules/home/favourites/favourites.dart';
import 'package:shop_app/modules/home/products/products.dart';
import 'package:shop_app/modules/home/settings/settings.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class HomeCubit extends Cubit<ShopHomeStates> {
  HomeCubit() : super(ShopHomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  void changeBottomIndex(index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  List<Widget> screens = [
    ProductsScreen(),
    FavouritesScreen(),
    CategoriesScreen(),
    SettingsScreen(),
  ];
  List<String> titles = [
    'Home',
    'Favourites',
    'Categories',
    'Settings',
  ];

  HomeModel? homeModel;
  void getHomeData() {
    emit(ShopHomeLoadingState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      emit(ShopHomeSuccessState());
    }).catchError((error) {
      printFullText('error is ============= ${error.toString()}');
      emit(ShopHomeErrorState());
    });
  }
}
