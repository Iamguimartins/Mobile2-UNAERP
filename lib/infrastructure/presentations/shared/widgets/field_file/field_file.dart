import 'package:flutter/material.dart';
import 'package:trabalho_faculdade/utils/colors.dart';

class FieldFile extends StatelessWidget {
  FieldFile({Key? key, required this.title, required this.text, required this.color, required this.onTap}) : super(key: key);

  String title;
  String text;
  Color color;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 16,
                    color: MyColors.black,
                    fontWeight: FontWeight.w400),
              ),
              IconButton(
                  onPressed: onTap,
                  icon: const Icon(Icons.upload)),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: color),
              color: Colors.grey[300],
              borderRadius:
              BorderRadius.circular(15)),
          margin: const EdgeInsets.only(top: 5),
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
                text
            ),
          ),
        )
      ],
    );
  }
}
