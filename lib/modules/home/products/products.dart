import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_app_layout/cubit/home_cubit.dart';
import 'package:shop_app/layouts/shop_app_layout/cubit/home_states.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/shared/components/constants.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, ShopHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeCubit.get(context).homeModel != null,
          builder: (context) =>
              productBuilder(HomeCubit.get(context).homeModel!),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget productBuilder(HomeModel model) => SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
                items: model.data!.banners
                    .map((e) => Image(
                          image: NetworkImage('${e.image}'),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ))
                    .toList(),
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
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.8,
              crossAxisCount: 2,
              children: List.generate(model.data!.products.length,
                  (index) => buildGridProduct(model.data!.products[index])),
            ),
          ],
        ),
      );

  Widget buildGridProduct(ProductModel model) => Container(
        width: 30,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Image(
            image: NetworkImage('${model.image}'),
            fit: BoxFit.cover,
            height: 250,
            width: 190,
          ),
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
              if (model.oldPrice != 0)
                Text(
                  '${model.oldPrice.round()}',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      decoration: TextDecoration.lineThrough),
                ),
              Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite_border_outlined,
                    size: 15,
                  ))
            ],
          ),
        ]),
      );
}
