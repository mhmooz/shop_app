import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/home/search/cubit/search_cubit.dart';
import 'package:shop_app/modules/home/search/cubit/search_states.dart';
import 'package:shop_app/shared/components/components.dart';
import '../../../models/search_model/search_model.dart';
import '../../../shared/components/constants.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: defaultFormField(
                      controller: searchController,
                      hintText: 'Search Products',
                      keyboardType: TextInputType.text,
                      prefix: Icon(Icons.search),
                      validat: (value) {
                        if (value!.isEmpty) {
                          return "Input Search";
                        }
                        return null;
                      },
                      onchanged: (String text) {
                        SearchCubit.get(context).search(text);
                      },
                      onSubmitt: (String text) {
                        SearchCubit.get(context).search(text);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (state is SearchLoadingState) LinearProgressIndicator(),
                  if (state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => SearchBuilder(
                              SearchCubit.get(context)
                                  .searchModel!
                                  .data!
                                  .data![index],
                              context),
                          separatorBuilder: (context, index) => seperatorLine(),
                          itemCount: SearchCubit.get(context)
                              .searchModel!
                              .data!
                              .data!
                              .length),
                    ),
                ],
              ),
            ));
      },
    );
  }

  Widget SearchBuilder(SearchProductData model, context) => Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          height: 100,
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Image(
              image: NetworkImage('${model.image}'),
              height: 100,
              width: 100,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    '${model.name}',
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
                        "${model.price}",
                        style: TextStyle(
                          color: defaultColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      );
}
