import 'package:amiriy/bloc/book/book_bloc.dart';
import 'package:amiriy/bloc/book/book_state.dart';
import 'package:amiriy/bloc/category/category_bloc.dart';
import 'package:amiriy/bloc/category/category_state.dart';
import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/screens/global_widgets/books_item.dart';
import 'package:amiriy/screens/global_widgets/global_text.dart';
import 'package:amiriy/screens/global_widgets/tab_item.dart';
import 'package:amiriy/utils/sizedbox/get_sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_utils/my_utils.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: GlobalText(
          data: 'categories',
          fontSize: 20.w,
          fontWeight: FontWeight.w900,
          isTranslate: true,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state.formStatus == FormStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.formStatus == FormStatus.error) {
                return Center(
                  child: Text(
                    state.errorText,
                  ),
                );
              }
              if (state.formStatus == FormStatus.success) {
                return SizedBox(
                  height: 50.h,
                  child: Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                      ),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.allCategories.length,
                      itemBuilder: (context, index) {
                        return TabItem(
                          onTap: () {
                            activeIndex = index;
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 5.w,
                              vertical: 5.h,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: activeIndex == index ? 10.h : 0,
                            ),
                            decoration: BoxDecoration(
                              color: activeIndex == index
                                  ? Colors.yellow
                                  : Colors.green,
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                state.allCategories[index].categoryName,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          BlocBuilder<BookBloc, BookState>(
            builder: (context, state) {
              if (state.formStatus == FormStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.formStatus == FormStatus.error) {
                return Center(
                  child: Text(
                    state.errorText,
                  ),
                );
              }
              if (state.formStatus == FormStatus.success) {
                return Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: List.generate(state.books.length, (index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 10.h,
                              ),
                              child: BooksItem(
                                heightt: height / 2.5,
                                widthh: width / 2.3,
                                bookModel: state.books[index],
                                voidCallback: () {},
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
