import 'package:amiriy/screens/routes.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  String categoryDocId = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Books",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          ZoomTapAnimation(
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteNames.addBookRoute,
              );
            },
            child: const Icon(
              Icons.add,
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
        ],
      ),
    );
  }
}
