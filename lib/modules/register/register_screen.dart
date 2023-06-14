import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layouts/shop_app_layout/home_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../login/cubit/login_cubit.dart';
import '../login/cubit/login_states.dart';

// ignore: must_be_immutable
class Registerscreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
      listener: (context, state) {
        if (state is ShopRegisterSuccessState) {
          if (state.loginModel.status) {
            CacheHelper.saveData(
                    key: 'token', value: state.loginModel.data.token)
                .then((value) {
              token = state.loginModel.data.token;
              navigateAndFinish(context, ShopAppHome());
            });
          } else {
            showToast(
                text: state.loginModel.message!, state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Register To See Our Newest Offers',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller: nameController,
                          hintText: 'Name',
                          keyboardType: TextInputType.name,
                          prefix: const Icon(Icons.person),
                          validat: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Your name Please';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                          controller: emailController,
                          hintText: 'Your Email',
                          keyboardType: TextInputType.emailAddress,
                          prefix: const Icon(Icons.email_outlined),
                          validat: (value) {
                            if (value!.isEmpty) {
                              return 'Enter An Email Please';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        isPassword: ShopLoginCubit.get(context).isPassword,
                        suffix: ShopLoginCubit.get(context).isPassword
                            ? const Icon(Icons.remove_red_eye_outlined)
                            : const Icon(Icons.visibility_off),
                        suffixPressed: () {
                          ShopLoginCubit.get(context).changePswdVisibility();
                        },
                        controller: passwordController,
                        hintText: 'Your Password',
                        keyboardType: TextInputType.visiblePassword,
                        prefix: const Icon(Icons.email_outlined),
                        validat: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Your Password Please';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                          controller: phoneController,
                          hintText: 'Your Phone',
                          keyboardType: TextInputType.phone,
                          prefix: const Icon(Icons.phone),
                          validat: (value) {
                            if (value!.isEmpty) {
                              return 'Enter A Phone Number Please';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text);
                            }
                          },
                          buttonwidget: ConditionalBuilder(
                              condition: state is! ShopRegisterLoadingState,
                              builder: (context) => const Text(
                                    "REGISTER",
                                    style: TextStyle(fontSize: 20),
                                  ),
                              fallback: (context) => const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.black,
                                    ),
                                  ))),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
