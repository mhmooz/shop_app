import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shop_app/models/on_boarding_model/on_boarding_model.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardingController = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                navigateAndFinish(context, ShopLogIn());
              },
              child: Text(
                'SKIP',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardingController,
                onPageChanged: (int index) {
                  if (index == onBoardingList.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoardingItem(onBoardingList[index]),
                itemCount: onBoardingList.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                SizedBox(
                  width: 54,
                ),
                SmoothPageIndicator(
                  controller: boardingController,
                  count: onBoardingList.length,
                  effect: WormEffect(activeDotColor: defaultColor),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    if (isLast) {
                      navigateAndFinish(context, ShopLogIn());
                    } else {
                      boardingController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastEaseInToSlowEaseOut);
                    }
                  },
                  icon: isLast
                      ? Icon(
                          Icons.skip_next_rounded,
                          size: 30,
                        )
                      : Icon(Icons.arrow_forward_ios),
                  color: defaultColor,
                )
              ],
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(OnBoardingModel model) {
    return Column(
      children: [
        Expanded(child: Image(image: AssetImage('${model.image}'))),
        Text(
          '${model.title}',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          '${model.body}',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
