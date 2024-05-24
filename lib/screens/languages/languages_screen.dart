import 'package:amiriy/screens/auth/widgets/global_textbutton.dart';
import 'package:amiriy/screens/routes.dart';
import 'package:amiriy/utils/images/app_images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({super.key});

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  int language = 1;
  late Locale locale;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    locale = context.locale;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = EasyLocalization.of(context)!.locale;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteNames.tabRoute,
              (context) => false,
            );
          },
          icon: Icon(
            Icons.arrow_back,
            size: 20.w,
          ),
        ),
        title:
            Text('language'.tr(), style: Theme.of(context).textTheme.bodyLarge),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 17.w,
          right: 17.w,
          top: 40.h,
          bottom: 40.h,
        ),
        child: Column(
          children: [
            ListTile(
              onTap: () {
                locale = const Locale('uz', 'UZ');
                context.setLocale(locale);
                debugPrint(context.locale.toString());
              },
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  AppImages.uzbFlag,
                  height: 25.h,
                  width: 25.w,
                  fit: BoxFit.cover,
                ),
              ),
              trailing: Icon(
                currentLocale == const Locale('uz', 'UZ')
                    ? Icons.check_circle
                    : Icons.circle_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                'Uzbek',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Divider(color: Theme.of(context).dividerColor),
            ListTile(
              onTap: () {
                locale = const Locale('ru', 'RU');
                context.setLocale(locale);
                debugPrint(context.locale.toString());
              },
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  AppImages.rusFlag,
                  height: 25.h,
                  width: 25.w,
                  fit: BoxFit.cover,
                ),
              ),
              trailing: Icon(
                currentLocale == const Locale('ru', 'RU') ? Icons.check_circle : Icons.circle_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                'Русский',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Divider(
              color: Theme.of(context).dividerColor,
            ),
            ListTile(
              onTap: () {
                locale = const Locale('en', 'US');
                context.setLocale(locale);

                debugPrint(context.locale.toString());
              },
              leading: Image.asset(AppImages.english, height: 25.h),
              trailing: Icon(
                currentLocale == const Locale('en', 'US') ? Icons.check_circle : Icons.circle_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                'English',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Divider(
              color: Theme.of(context).dividerColor,
            ),
            ListTile(
              onTap: () {
                locale = const Locale('uz', 'RU');
                context.setLocale(locale);

                debugPrint(context.locale.toString());
              },
              leading: Image.asset(AppImages.uzbFlag, height: 25.h),
              trailing: Icon(
                currentLocale == const Locale('uz', 'RU') ? Icons.check_circle : Icons.circle_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                'Кирилча',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const Spacer(),
            GlobalTextButton(
              onTap: () async {
                isLoading = true;
                setState(() {});
                await Future.delayed(const Duration(seconds: 1));
                if (!context.mounted) return;
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteNames.tabRoute,
                  (context) => false,
                );
              },
              text: "save",
              isTranslate: true,
              isLoading: isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
