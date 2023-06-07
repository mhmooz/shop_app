import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/components/constants.dart';

Widget defaultFormField({
  required TextEditingController? controller,
  required String hintText,
  required TextInputType keyboardType,
  required Icon prefix,
  required String? Function(String?)? validat,
  bool isPassword = false,
  bool enable_Suggestion = false,
  bool auto_correct = false,
  Color hint_color = Colors.black,
  Color fillColor = Colors.white,
  double radius = 25,
  bool filled = true,
  Function()? onTap,
  Function()? show_password,
  void Function(String)? onSubmitt,
  void Function(String)? onchanged,
  Icon? suffix,
  Function()? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: hint_color),
          prefixIcon: prefix,
          suffixIcon: suffix != null
              ? IconButton(onPressed: suffixPressed, icon: suffix)
              : null,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
          filled: filled,
          fillColor: fillColor),
      validator: validat,
      enableSuggestions: enable_Suggestion,
      autocorrect: auto_correct,
      keyboardType: keyboardType,
      obscureText: isPassword ? true : false,
      onTap: onTap,
      onChanged: onchanged,
      onFieldSubmitted: onSubmitt,
    );

Widget defaultButton({
  double width = 200,
  double height = 60,
  bool isUpperCase = true,
  double fontsize = 30,
  Color fontColor = Colors.white,
  Color? backgroundColor = defaultColor,
  double radius = 25,
  required Function()? function,
  Widget? buttonwidget,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: backgroundColor),
      child: MaterialButton(
        onPressed: function,
        child: buttonwidget,
      ),
    );

Widget seperatorLine() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey,
      ),
    );

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => widget), (route) {
      return false;
    });

void showToast({required String text, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
