import 'package:flutter/material.dart';

class CommonLabelWithTap extends StatelessWidget {
  final String text;
  final Function onTap;

  const CommonLabelWithTap({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 1.0),
        child: InkWell(
          onTap: () => onTap(),
          child: Text(
            text,
            style: const TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 16,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
