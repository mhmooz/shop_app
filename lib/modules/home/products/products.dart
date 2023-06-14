import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_app_layout/cubit/home_cubit.dart';
import 'package:shop_app/layouts/shop_app_layout/cubit/home_states.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

import '../../../models/categories_model/categories_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  get index => int;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, ShopHomeStates>(
      listener: (context, state) {
        if (state is ShopChangeFavouritesSuccessState) {
          if (state.model != null) {
            if (!state.model!.status!) {
              showToast(text: state.model!.messsage!, state: ToastStates.ERROR);
            }
          }
        }
      },
      builder: (
        context,
        state,
      ) {
        return ConditionalBuilder(
            condition: HomeCubit.get(context).homeModel != null &&
                HomeCubit.get(context).categoriesModel != null,
            builder: (context) => productBuilder(
                HomeCubit.get(context).homeModel!,
                HomeCubit.get(context).categoriesModel!,
                context),
            fallback: (context) {
              print('===========loading');
              return Center(
                child: CircularProgressIndicator(),
              );
            });
      },
    );
  }

  Widget productBuilder(
          HomeModel model, CategoriesModel categoriesModel, context) =>
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: [
                  Image(
                    image: AssetImage('assets/images/headers/headers_1.jpg'),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Image(
                    image: AssetImage('assets/images/headers/headers_2.png'),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Image(
                    image: AssetImage('assets/images/headers/headers_3.png'),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ],
                // items: model.data!.banners
                //     .map((e) => Image(
                //           image: NetworkImage('${e.image}'),
                //           width: double.infinity,
                //           fit: BoxFit.cover,
                //         ))
                //     .toList(),
                options: CarouselOptions(
                  height: 250,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 1,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCategoryItem(categoriesModel.data!.data![index]),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 20,
                      ),
                      itemCount: categoriesModel.data!.data!.length,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Products',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.87,
              crossAxisCount: 2,
              children: List.generate(
                  model.data!.products.length,
                  (index) =>
                      buildGridProduct(model.data!.products[index], context)),
            ),
          ],
        ),
      );
  Widget buildCategoryItem(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model.image!),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          Container(
            height: 30,
            width: 100,
            color: Colors.black,
            child: Center(
              child: Text(
                '${model.name}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      );

  Widget buildGridProduct(ProductModel model, context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(alignment: AlignmentDirectional.bottomStart, children: [
            Image(
              image: NetworkImage('${model.image}'),
              height: 250,
              width: 190,
            ),
            if (model.discount != 0)
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
          Text(
            '${model.name}',
            textAlign: TextAlign.left,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Text(
                "${model.price.round()}",
                style: TextStyle(
                  color: defaultColor,
                ),
              ),
              SizedBox(
                width: 6,
              ),
              if (model.discount != 0)
                Text(
                  '${model.oldPrice.round()}',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      decoration: TextDecoration.lineThrough),
                ),
              Spacer(),
              IconButton(
                  onPressed: () {
                    HomeCubit.get(context).changeFavorites(model.id!);
                    print('============added to favorites');
                  },
                  icon: HomeCubit.get(context).favorites[model.id!]!
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
        ]),
      );
}
