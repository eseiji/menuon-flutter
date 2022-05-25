import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final Function press;
  const CategoryItem({
    Key? key,
    required this.title,
    this.isActive = false,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: <Widget>[
            Text(
              title,
              style: isActive
                  ? TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )
                  : const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
            ),
            if (isActive)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                height: 3,
                width: 22,
                decoration: BoxDecoration(
                  color: const Color(0xFF5767FE).withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
