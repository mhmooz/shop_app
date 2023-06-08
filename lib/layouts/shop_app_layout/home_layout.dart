import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_app_layout/cubit/home_cubit.dart';
import 'package:shop_app/layouts/shop_app_layout/cubit/home_states.dart';
import 'package:shop_app/modules/home/search/search.dart';
import 'package:shop_app/shared/components/components.dart';

// ignore: must_be_immutable
class ShopAppHome extends StatelessWidget {
  ShopAppHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, ShopHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit homeCubit = HomeCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.grey,
          appBar: AppBar(
            title: Text(homeCubit.titles[homeCubit.currentIndex]),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search)),
            ],
          ),
          body: homeCubit.screens[homeCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: homeCubit.currentIndex,
              onTap: (index) {
                homeCubit.changeBottomIndex(index);
              },
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart_outlined),
                    label: "Products"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: "Favourites"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.apps), label: "Category"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: "Settings"),
              ]),
        );
      },
    );
  }
}
