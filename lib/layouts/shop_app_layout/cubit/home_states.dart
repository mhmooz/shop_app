import 'package:shop_app/models/favorites_model/change_favorites_model.dart';

abstract class ShopHomeStates {}

class ShopHomeInitialState extends ShopHomeStates {}

class ShopChangeBottomNavState extends ShopHomeStates {}

class ShopHomeLoadingState extends ShopHomeStates {}

class ShopHomeSuccessState extends ShopHomeStates {}

class ShopHomeErrorState extends ShopHomeStates {}

class ShopCategoriesSuccessState extends ShopHomeStates {}

class ShopCategoriesErrorState extends ShopHomeStates {}

class ShopChangeIconFavouritesState extends ShopHomeStates {}

class ShopChangeFavouritesSuccessState extends ShopHomeStates {
  ChangeFavoritesModel? model;
}

class ShopChangeFavouritesErrorState extends ShopHomeStates {}

class ShopLoadingGetFavoritesState extends ShopHomeStates {}

class ShopGetFavoritesSuccessState extends ShopHomeStates {}

class ShopGetFavoritesErrorState extends ShopHomeStates {}

class ShopLoadingGetUserDataState extends ShopHomeStates {}

class ShopGetUserDataSuccessState extends ShopHomeStates {}

class ShopGetUserDataErrorState extends ShopHomeStates {}
