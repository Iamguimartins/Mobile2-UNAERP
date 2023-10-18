import 'package:flutter/material.dart';
import 'package:trabalho_faculdade/utils/colors.dart';

class ButtonOption extends StatelessWidget {
  const ButtonOption({Key? key, required this.title, required this.icon, required this.onTap}) : super(key: key);

  final String title;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
            color: MyColors.primaryColor,
            borderRadius: BorderRadius.circular(25)
        ),
        height: 100,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.white)),
            Icon(icon, size: 50, color: Colors.white,)
          ],
        ),
      ),
    );
  }
}
