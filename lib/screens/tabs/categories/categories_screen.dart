import 'package:amiriy/bloc/book/book_bloc.dart';
import 'package:amiriy/bloc/book/book_event.dart';
import 'package:amiriy/bloc/book/book_state.dart';
import 'package:amiriy/bloc/category/category_bloc.dart';
import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/screens/global_widgets/books_item.dart';
import 'package:amiriy/screens/global_widgets/global_text.dart';
import 'package:amiriy/screens/global_widgets/tab_item.dart';
import 'package:amiriy/screens/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_utils/my_utils.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int activeIndex = -1;

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
          SizedBox(
            height: 50.h,
            child: SingleChildScrollView(
              // padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h,),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TabItem(
                    onTap: () {
                      setState(() {
                        activeIndex = -1;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 5.h,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 0,
                      ),
                      decoration: BoxDecoration(
                        color: activeIndex == -1 ? Colors.yellow : Colors.green,
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'All',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                  ),
                  ...List.generate(
                      context.read<CategoryBloc>().state.allCategories.length,
                      (index) {
                    return TabItem(
                      onTap: () {
                        context.read<BookBloc>().add(
                              GetBooksByCategoryId(
                                categoryId: context
                                    .read<CategoryBloc>()
                                    .state
                                    .allCategories[index]
                                    .docId,
                              ),
                            );
                        setState(() {
                          activeIndex = index;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 5.h,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 0,
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
                            context
                                .read<CategoryBloc>()
                                .state
                                .allCategories[index]
                                .categoryName,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          activeIndex == -1
              ? BlocBuilder<BookBloc, BookState>(
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
                                children:
                                    List.generate(state.books.length, (index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 10.h,
                                    ),
                                    child: BooksItem(
                                      heightt: height / 2.5,
                                      widthh: width / 2.3,
                                      bookModel: state.books[index],
                                      voidCallback: () {
                                        Navigator.pushNamed(
                                          context,
                                          RouteNames.bookDetailsRoute,
                                          arguments: state.books[index],
                                        );
                                      },
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
                )
              : BlocBuilder<BookBloc, BookState>(
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
                                children: List.generate(
                                    state.categoryBooks.length, (index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 10.h,
                                    ),
                                    child: BooksItem(
                                      heightt: height / 2.5,
                                      widthh: width / 2.3,
                                      bookModel: state.categoryBooks[index],
                                      voidCallback: () {
                                        Navigator.pushNamed(
                                          context,
                                          RouteNames.bookDetailsRoute,
                                          arguments: state.categoryBooks[index],
                                        );
                                      },
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
