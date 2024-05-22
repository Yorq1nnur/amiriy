import 'package:amiriy/bloc/category/category_bloc.dart';
import 'package:amiriy/bloc/category/category_state.dart';
import 'package:amiriy/bloc/form_status/form_status.dart';
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
            6.getH(),
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state.formStatus == FormStatus.error) {
                  return Text(state.errorText);
                }
                if (state.formStatus == FormStatus.loading) {
                  return const CircularProgressIndicator();
                }
                if (state.formStatus == FormStatus.success) {
                  return Wrap(
                    children: List.generate(
                      state.allCategories.length,
                      (index) => Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.w,
                          vertical: 3.h,
                        ),
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 15.h,
                            ),
                            margin: EdgeInsets.all(2.w),
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
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
