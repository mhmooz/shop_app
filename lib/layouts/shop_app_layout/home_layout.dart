import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import '../../shared/components/components.dart';

class ShopAppHome extends StatelessWidget {
  const ShopAppHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OZ Style'),
        actions: [
          TextButton(
              onPressed: () {
                CacheHelper.removeData(key: 'token')
                    .then((value) => navigateAndFinish(context, ShopLogIn()));
              },
              child: Text('Sign out'))
        ],
      ),
    );
  }
}
