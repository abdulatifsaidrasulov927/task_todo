import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GridItem extends StatelessWidget {
  final String icon;
  final String text;
  final String counttext;

  const GridItem({
    required this.icon,
    required this.text,
    required this.counttext,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 3,
          offset: const Offset(0, 3),
        )
      ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          Text(
            counttext,
            style: const TextStyle(
                fontSize: 8, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
