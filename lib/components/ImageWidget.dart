import 'package:flutter/material.dart';

import '../const/colors.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            color: backgroundColors,
            image: DecorationImage(
              image: AssetImage('images/7.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      );
}
