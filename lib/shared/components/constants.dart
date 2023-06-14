import 'package:flutter/material.dart';

import '../../modules/login/login.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

const defaultColor = Colors.blueAccent;

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    navigateAndFinish(context, ShopLogIn());
  });
}
