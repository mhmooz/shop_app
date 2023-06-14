import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model/search_model.dart';
import 'package:shop_app/modules/home/search/cubit/search_states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/end_points.dart';

import '../../../../shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH, token: token, data: {'text': text})
        .then((value) {
      searchModel = SearchModel.fomJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState());
      print("error while searching ================== ${error.toString()}");
    });
  }
}
