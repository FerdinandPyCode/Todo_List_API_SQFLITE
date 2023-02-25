
import 'dart:ui';

import 'package:flutter/material.dart';

import 'colors.dart';


class AppSimpleInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final bool hasSufix;
  final Widget suffix;
  final int minLine;
  final int maxLine;
  final TextInputType inputType;
  final String? Function(String?)? validator;
  final double height;
  final double width;
  
  const AppSimpleInput({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText, 
    this.hasSufix=false, 
    this.suffix= const IconButton(
      icon: Icon(Icons.edit),
      onPressed: null,
    ), 
    this.minLine=1,
    this.maxLine=5, 
    this.inputType=TextInputType.text, 
    required this.validator, 
    this.height=40.0, 
    this.width=double.infinity, required bool hasSuffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: AppColors.getGreyColor)
      ),
      width: width,
      //height: height,
      child: TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          
          suffix: hasSufix? suffix:null,
          //suffixStyle: TextStyle(color: AppColors.blueBgColor),
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.getGreyColor,fontSize: 12.0),
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          filled: true,
          contentPadding: const EdgeInsets.all(8),
        ),
        validator: validator,
        obscureText: isPass,
        keyboardType:(minLine==1)? inputType:TextInputType.multiline,
        minLines: minLine,
        maxLines: maxLine,
      ),
    );
  }
}