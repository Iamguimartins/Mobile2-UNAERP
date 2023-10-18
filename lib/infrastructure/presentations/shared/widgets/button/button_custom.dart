import 'package:flutter/material.dart';
import 'package:trabalho_faculdade/utils/colors.dart';

class ButtonCustom extends StatelessWidget {
  ButtonCustom({Key? key, required this.title, required this.onPressed})
      : super(key: key);

  String title;
  Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return MyColors.gray;
              } else if (states.contains(MaterialState.hovered)) {
                return MyColors.primaryColor;
              } else {
                return MyColors.primaryColor;
              }
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return MyColors.gray;
              } else if (states.contains(MaterialState.hovered)) {
                return MyColors.neutralBackground;
              } else {
                return MyColors.neutralBackground;
              }
            },
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return MyColors.primaryColor;
              }
              return null;
            },
          ),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.0))),
          side: MaterialStateProperty.resolveWith<BorderSide>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return BorderSide(
                  width: 5, color: MyColors.primaryColor);
            }
            return const BorderSide(width: 0, color: Colors.transparent);
          }),
        ),
        onPressed: onPressed,
        child: SizedBox(
            height: 40,
            child: Center(
              child: Text(title ?? "",
                  style:
                      const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            )),
      ),
    );
  }
}
