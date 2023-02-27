 import 'package:flutter/material.dart';

Widget CustomButton(
      {required String title,
      required IconData icon,
      required void Function()? onClick
      }) {
    return Container(
        width: 280,
        child: ElevatedButton(
            onPressed: onClick,
            child: Row(
              children: [
                Icon(icon),
                const SizedBox(
                  width: 20,
                ),
                Text(title),
              ],
            )));
  }