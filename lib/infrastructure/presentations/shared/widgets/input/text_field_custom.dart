import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trabalho_faculdade/utils/colors.dart';

class TextFieldCustom extends StatelessWidget {
  TextFieldCustom(
      {Key? key,
      required this.hint,
      this.isPassword = false,
      this.controller,
      required this.getColorValidator,
      this.mask,
      this.readOnly = false,
      this.onTap,
      required this.inputType})
      : super(key: key);

  String hint;
  bool isPassword;
  TextEditingController? controller;
  Color getColorValidator;
  TextInputFormatter? mask;
  TextInputType inputType;
  bool readOnly;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hint, style: TextStyle(
            fontSize: 16,
            color: MyColors.black,
            fontWeight: FontWeight.w400),),
        const SizedBox(height: 10,),
        TextField(
          onTap: onTap,
          readOnly: readOnly,
          inputFormatters: mask != null ? [mask!] : [],
          controller: controller,
          keyboardType: inputType,
          obscureText: isPassword,
          style: TextStyle(
              fontSize: 16,
              color: MyColors.black,
              fontWeight: FontWeight.w400),
          decoration: InputDecoration(
              isDense: true,
              suffixIcon: isPassword
                  ? Icon(Icons.visibility,
                      color: MyColors.gray, size: 20)
                  : null,
              border: _border(getColorValidator),
              enabledBorder: _border(getColorValidator),
              focusedBorder: _border(getColorValidator)),
        ),
      ],
    );
  }

  static InputBorder _border(Color borderColor) => OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(width: 1.5, color: borderColor),
      );
}
