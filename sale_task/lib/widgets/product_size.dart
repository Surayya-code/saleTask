
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductSize extends StatelessWidget {
   final String labelText;

  const ProductSize({Key? key,
  required this.labelText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.all(20),
      child: TextField(
        decoration:  InputDecoration(labelText: labelText),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(
            RegExp(r'[0-9]'),
          ),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}
