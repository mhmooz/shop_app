import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_app_layout/cubit/home_cubit.dart';
import 'package:shop_app/layouts/shop_app_layout/cubit/home_states.dart';
import 'package:shop_app/layouts/shop_app_layout/home_layout.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/modules/on_boarding/on_boarding.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget? widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  String? token = CacheHelper.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null) {
      widget = ShopAppHome();
    } else {
      widget = ShopLogIn();
    }
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  MyApp({this.startWidget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit()..getHomeData(),
        ),
      ],
      child: BlocConsumer<HomeCubit, ShopHomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      home: startWidget,
    );
        },
      ),
    );
  }
}
