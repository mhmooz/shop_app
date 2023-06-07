import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layouts/shop_app_layout/home_layout.dart';
import 'package:shop_app/modules/login/cubit/login_cubit.dart';
import 'package:shop_app/modules/login/cubit/login_states.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopLogIn extends StatelessWidget {
  ShopLogIn({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status!) {
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) => navigateAndFinish(context, ShopAppHome()));
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
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Login To See Out Newest Offers',
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: emailController,
                            hintText: 'Your Email',
                            keyboardType: TextInputType.emailAddress,
                            prefix: Icon(Icons.email_outlined),
                            validat: (value) {
                              if (value!.isEmpty) {
                                return 'Enter An Email Please';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          suffix: ShopLoginCubit.get(context).isPassword
                              ? Icon(Icons.remove_red_eye_outlined)
                              : Icon(Icons.visibility_off),
                          suffixPressed: () {
                            ShopLoginCubit.get(context).changePswdVisibility();
                          },
                          controller: passwordController,
                          hintText: 'Your Password',
                          keyboardType: TextInputType.visiblePassword,
                          prefix: Icon(Icons.email_outlined),
                          validat: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Your Password Please';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            buttonwidget: ConditionalBuilder(
                                condition: state is! ShopLoginLoadingState,
                                builder: (context) => Text(
                                      "Login",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                fallback: (context) => Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                      ),
                                    ))),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                            ),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, Registerscreen());
                                },
                                child: Text(
                                  "REGISTER",
                                  style: TextStyle(fontSize: 16),
                                ))
                          ],
                        ),
                        SizedBox(
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
      ),
    );
  }
}
