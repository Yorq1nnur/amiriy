import 'package:amiriy/screens/global_widgets/global_text.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: GlobalText(
          data: 'search',
          fontSize: 20.w,
          fontWeight: FontWeight.w900,
          isTranslate: true,
        ),
      ),
    );
  }
}
