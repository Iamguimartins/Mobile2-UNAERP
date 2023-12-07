import 'package:flutter/material.dart';
import 'package:trabalho_faculdade/utils/colors.dart';

class ButtonOption extends StatelessWidget {
  const ButtonOption({Key? key, required this.title, required this.icon, required this.onTap, required this.enabled}) : super(key: key);

  final String title;
  final IconData icon;
  final Function() onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: enabled ? MyColors.primaryColor : Colors.grey,
            borderRadius: BorderRadius.circular(25)
        ),
        height: 120,
        width: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.white,),
            Center(child: Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                fontWeight:
            FontWeight.w400, fontSize: 14, color: Colors.white))),
          ],
        ),
      ),
    );
  }
}
