import 'package:flutter/material.dart';
import 'package:todo_app/utils/app_text.dart';
import 'package:todo_app/utils/colors.dart';

class AppInput extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final double height;
  final TextInputType inputType;
  final TextAlign textAlign;
  final bool isObscure;
  final IconButton suffixIcon;
  final String hint;
  final bool hasSuffix;
  final bool radius;
  final int maxLine;
  final int minLine;
  final bool reeadOnly;
  //final InputDecoration decoration;

  const AppInput({
    Key? key,
    this.label = "",
    required this.hasSuffix,
    required this.controller,
    required this.validator,
    this.height = 55,
    this.inputType = TextInputType.text,
    this.isObscure = false,
    this.suffixIcon = const IconButton(
      icon: Icon(Icons.edit),
      onPressed: null,
    ),
    this.textAlign = TextAlign.start,
    this.hint = "",
    this.radius = true,
    this.maxLine = 1,
    this.minLine = 1,
    this.reeadOnly = false,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: AppText(
                label,
                color: Colors.green,
                size: 20.0,
                weight: FontWeight.bold,
              )),
          TextFormField(
            readOnly: reeadOnly,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: AppColors.getGreyColor),
              labelStyle: const TextStyle(color: Colors.green),
              suffixIcon: hasSuffix ? suffixIcon : null,
              suffixIconColor: AppColors.getBlueNightColor,
              hintText: hint,
              focusColor: AppColors.getBlueNightColor,
              iconColor: AppColors.getBlueNightColor,
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.getBlueNightColor)),
              errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)),
              focusedBorder: radius
                  ? UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.getBlueNightColor))
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      // SEE HERE
                      borderSide: BorderSide(
                          width: 3, color: AppColors.getBlueNightColor),
                    ),
              focusedErrorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
            ),
            obscureText: isObscure,
            keyboardType: inputType,
            controller: controller,
            maxLines: maxLine,
            validator: validator,
            textAlign: textAlign,
            style: TextStyle(fontSize: 16, color: AppColors.getBlueNightColor),
            minLines: 1,
          ),
        ],
      ),
    );
  }
}
