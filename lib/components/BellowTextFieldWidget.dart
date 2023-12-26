import 'package:flutter/material.dart';

class BellowTextFieldWidget extends StatelessWidget {
  const BellowTextFieldWidget({
    super.key,
    required this.widget,
    required this.textQuest,
    required this.clickText,
  });

  final void Function() widget;
  final String textQuest;
  final String clickText;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              textQuest,
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
            ),
            SizedBox(width: 5),
            GestureDetector(
              onTap: widget,
              child: Text(
                clickText,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      );
}
