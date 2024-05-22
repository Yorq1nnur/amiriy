import 'package:amiriy/bloc/category/category_bloc.dart';
import 'package:amiriy/bloc/category/category_state.dart';
import 'package:amiriy/screens/global_widgets/global_text.dart';
import 'package:amiriy/utils/colors/app_colors.dart';
import 'package:amiriy/utils/sizedbox/get_sizedbox.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_utils/my_utils.dart';

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
        title: GlobalText(
          data: "welcome_back",
          fontSize: 20.sp,
          fontWeight: FontWeight.w900,
          isTranslate: true,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 32.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            24.getH(),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.c29BB89,
                  size: 25.w,
                ),
                contentPadding: EdgeInsets.only(
                  left: 20.w,
                  right: 10.w,
                  top: 16.h,
                  bottom: 16.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 1.w,
                  ),
                ),
                hintText: 'search_books'.tr(),
              ),
            ),
            50.getH(),
            GlobalText(
              data: 'category',
              fontSize: 18.w,
              fontWeight: FontWeight.w700,
              isTranslate: true,
            ),
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                return Wrap(
                  children: List.generate(
                    15,
                    (index) => Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 5.h,
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.cF1F1F1,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: GlobalText(
                        data: state.allCategories[index].categoryName,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        isTranslate: false,
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
