import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_app_layout/cubit/home_states.dart';
import 'package:shop_app/models/favorites_model/get_favorites_model.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../../layouts/shop_app_layout/cubit/home_cubit.dart';
import '../../../shared/components/constants.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, ShopHomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition: state is! ShopLoadingGetFavoritesState &&
                  HomeCubit.get(context).favoritesModel != null,
              builder: (context) => ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => favoritesBuilder(
                      HomeCubit.get(context).favoritesModel!.data!.data![index],
                      context),
                  separatorBuilder: (context, index) => seperatorLine(),
                  itemCount: HomeCubit.get(context)
                      .favoritesModel!
                      .data!
                      .data!
                      .length),
              fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ));
        });
  }

  Widget favoritesBuilder(FavData model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 100,
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Stack(alignment: AlignmentDirectional.bottomStart, children: [
              Image(
                image: NetworkImage('${model.product!.image!}'),
                height: 100,
                width: 100,
              ),
              if (model.product!.discount! != 0)
                Container(
                  padding: EdgeInsets.all(2),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(fontSize: 8, color: Colors.white),
                  ),
                  color: Colors.red,
                  height: 15,
                  width: 48,
                ),
            ]),
            Expanded(
              child: Column(
                children: [
                  Text(
                    '${model.product!.name}',
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${model.product!.price}",
                        style: TextStyle(
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      if (model.product!.discount! != 0)
                        Text(
                          '${model.product!.oldPrice}',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            HomeCubit.get(context)
                                .changeFavorites(model.product!.id!);
                            print('============added to favorites');
                          },
                          icon: HomeCubit.get(context)
                                  .favorites[model.product!.id!]!
                              ? Icon(
                                  Icons.favorite_outlined,
                                  size: 15,
                                  color: Colors.red,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  size: 15,
                                ))
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      );
}
