import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
      listener: (context, state) {
        if (state is ShopLoginSuccessState) {
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
                        'Login',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Login To See Our Newest Offers',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 20,
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
                              builder: (context) => const Text(
                                    "Login",
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account?',
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                          TextButton(
                              onPressed: () {
                                navigateTo(context, Registerscreen());
                              },
                              child: const Text(
                                "REGISTER",
                                style: TextStyle(fontSize: 16),
                              ))
                        ],
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
