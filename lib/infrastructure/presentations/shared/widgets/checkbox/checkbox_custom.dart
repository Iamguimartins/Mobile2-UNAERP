import 'package:flutter/material.dart';
import 'package:trabalho_faculdade/utils/colors.dart';

class CheckboxCustom extends StatelessWidget {
  CheckboxCustom(
      {Key? key,
      required this.title,
      required this.onPressed,
      required this.isCheck,
      this.disabled = false})
      : super(key: key);

  String title;
  Function() onPressed;
  bool isCheck;
  bool disabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  if ((states.contains(MaterialState.focused)) || (states.contains(MaterialState.hovered)) || (states.contains(MaterialState.pressed))) {
                    return MyColors.info;
                  }
                  return null;
                },
              ),
            ),
            onPressed: disabled ? null : onPressed,
            icon: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: disabled
                            ? MyColors.gray
                            : MyColors.neutralText,
                        width: 1),
                    borderRadius: BorderRadius.circular(4)),
                child: Center(
                    child: Icon(
                  getIconByType(),
                  size: 14,
                  color: MyColors.primaryColor
                )))),
        const SizedBox(width: 15,),
        Text(
          title,
          style: TextStyle(
              color: MyColors.gray,
              fontSize: 16,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }

  IconData? getIconByType() {
    if (isCheck) {
      return Icons.check;
    } else {
      return null;
    }
  }
}
