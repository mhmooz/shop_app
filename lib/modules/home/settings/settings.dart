import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/shop_app_layout/cubit/home_cubit.dart';
import 'package:shop_app/layouts/shop_app_layout/cubit/home_states.dart';
import 'package:shop_app/modules/login/cubit/login_cubit.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

import '../../login/cubit/login_states.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, ShopHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        nameController.text = HomeCubit.get(context).loginModel.data.name;
        emailController.text = HomeCubit.get(context).loginModel.data.email;
        phoneController.text = HomeCubit.get(context).loginModel.data.phone;
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                if (state is ShopUpdateProfileLoadingState)
                  LinearProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                defaultFormField(
                  controller: nameController,
                  hintText: 'Name',
                  keyboardType: TextInputType.name,
                  prefix: const Icon(Icons.person),
                  validat: (value) {
                    if (value!.isEmpty) {
                      return "Name Must not be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                defaultFormField(
                  controller: emailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  prefix: const Icon(Icons.email),
                  validat: (value) {
                    if (value!.isEmpty) {
                      return "Email Must not be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                defaultFormField(
                  controller: phoneController,
                  hintText: 'Phone',
                  keyboardType: TextInputType.phone,
                  prefix: const Icon(Icons.phone),
                  validat: (value) {
                    if (value!.isEmpty) {
                      return "Phone Must not be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                defaultButton(
                    function: () {
                      if (formKey.currentState!.validate()) {
                        ShopLoginCubit.get(context).upadateProfile(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text);
                      }
                    },
                    buttonwidget: Text(
                      'Update Profile',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 10,
                ),
                defaultButton(
                    function: () {
                      signOut(context);
                    },
                    buttonwidget: Text(
                      'LogOut',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
