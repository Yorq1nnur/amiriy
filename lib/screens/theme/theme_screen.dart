import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  AdaptiveThemeMode? currentTheme = AdaptiveThemeMode.system;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    currentTheme = await AdaptiveTheme.getThemeMode();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'change_theme'.tr(),
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 20.w,
              ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 17.w, right: 17.w, top: 40.h),
        child: Column(
          children: [
            ListTile(
              onTap: () {
                AdaptiveTheme.of(context).setLight();
                _init();
              },
              leading: Icon(
                currentTheme!.isLight
                    ? Icons.check_circle
                    : Icons.circle_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                'light_theme'.tr(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Divider(color: Theme.of(context).dividerColor),
            ListTile(
              onTap: () {
                AdaptiveTheme.of(context).setDark();
                _init();
              },
              leading: Icon(
                currentTheme!.isDark
                    ? Icons.check_circle
                    : Icons.circle_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                'dark_theme'.tr(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Divider(color: Theme.of(context).dividerColor),
            ListTile(
              onTap: () {
                AdaptiveTheme.of(context).setSystem();
                _init();
              },
              leading: Icon(
                currentTheme!.isSystem
                    ? Icons.check_circle
                    : Icons.circle_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text('system_theme'.tr(),
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
          ],
        ),
      ),
    );
  }
}
