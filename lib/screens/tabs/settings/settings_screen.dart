import 'package:amiriy/screens/global_widgets/global_text.dart';
import 'package:amiriy/screens/routes.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: GlobalText(
          data: 'settings',
          fontSize: 20.sp,
          fontWeight: FontWeight.w900,
          isTranslate: true,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Ink(
            height: 50.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(
                16,
              ),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(
                16,
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteNames.languagesRoute,
                );
              },
              child: Center(
                child: GlobalText(
                  data: 'languages',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w900,
                  isTranslate: true,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
