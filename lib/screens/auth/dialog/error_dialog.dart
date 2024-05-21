import 'package:amiriy/screens/auth/widgets/global_textbutton.dart';
import 'package:flutter/material.dart';

errorDialog({
  required BuildContext context,
  required String errorText,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "!!!",
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(color: Colors.redAccent, fontSize: 20),
                ),
                Text(
                  errorText,
                  style:Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.redAccent, fontSize: 24),
                ),
                const SizedBox(height: 20),
                GlobalTextButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    text: "Ok")
              ],
            ),
          ),
        );
      });
}
