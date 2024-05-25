import 'package:amiriy/bloc/banner/banner_bloc.dart';
import 'package:amiriy/bloc/banner/banner_state.dart';
import 'package:amiriy/bloc/book/book_bloc.dart';
import 'package:amiriy/bloc/book/book_event.dart';
import 'package:amiriy/bloc/category/category_bloc.dart';
import 'package:amiriy/bloc/category/category_state.dart';
import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/bloc/recommended_books/recommended_books_bloc.dart';
import 'package:amiriy/bloc/recommended_books/recommended_books_state.dart';
import 'package:amiriy/screens/global_widgets/banner_items.dart';
import 'package:amiriy/screens/global_widgets/books_item.dart';
import 'package:amiriy/screens/global_widgets/global_text.dart';
import 'package:amiriy/screens/routes.dart';
import 'package:amiriy/utils/colors/app_colors.dart';
import 'package:amiriy/utils/sizedbox/get_sizedbox.dart';
import 'package:amiriy/utils/utility_functions/utility_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_utils/my_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: GlobalText(
          data: "welcome_back",
          fontSize: 20.sp,
          fontWeight: FontWeight.w900,
          isTranslate: true,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.getH(),
            BlocBuilder<BannerBloc, BannerState>(
              builder: (context, state) {
                return BannerItems(
                  banners: state.banners,
                );
              },
            ),
            20.getH(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: GlobalText(
                data: 'categories',
                fontSize: 18.w,
                fontWeight: FontWeight.w700,
                isTranslate: true,
              ),
            ),
            6.getH(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 32.w,
              ),
              child: BlocBuilder<CategoryBloc, CategoryState>(
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
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RouteNames.oneCategoryRoute,
                                arguments:
                                    state.allCategories[index].categoryName,
                              );
                              context.read<BookBloc>().add(
                                    GetBooksByCategoryId(
                                      categoryId:
                                          state.allCategories[index].docId,
                                    ),
                                  );
                            },
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
              ),
            ),
            20.getH(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: GlobalText(
                data: 'recommended',
                fontSize: 18.w,
                fontWeight: FontWeight.w700,
                isTranslate: true,
              ),
            ),
            20.getH(),
            BlocBuilder<RecommendedBooksBloc, RecommendedBooksState>(
              builder: (context, state) {
                if (state.formStatus == FormStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state.formStatus == FormStatus.error) {
                  return Center(
                    child: Text(
                      state.errorMessage,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  );
                }
                if (state.formStatus == FormStatus.success) {
                  return SizedBox(
                    height: height / 2.5,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.w,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.recommendedBooks.length,
                      itemBuilder: (BuildContext context, int index) {
                        return BooksItem(
                          bookModel: state.recommendedBooks[index],
                          voidCallback: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.bookDetailsRoute,
                              arguments: state.recommendedBooks[index],
                            );
                          },
                        );
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            20.getH(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 32.w,
              ),
              child: GlobalText(
                data: 'last_ten_books',
                fontSize: 20.w,
                fontWeight: FontWeight.w900,
                isTranslate: true,
              ),
            ),
            20.getH(),
            BlocBuilder<RecommendedBooksBloc, RecommendedBooksState>(
              builder: (context, state) {
                if (state.statusMessage == "last_ten_loading") {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state.formStatus == FormStatus.error) {
                  return Center(
                    child: Text(
                      state.errorMessage,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  );
                }
                if (state.statusMessage == "last_ten_success") {
                  return SizedBox(
                    height: height / 2.5,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.w,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.lastTenBooks.length,
                      itemBuilder: (BuildContext context, int index) {
                        UtilityFunctions.methodPrint(
                          "$index dagi book date: ${state.recommendedBooks[index].dateTime}",
                        );
                        return BooksItem(
                          bookModel: state.lastTenBooks[index],
                          voidCallback: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.bookDetailsRoute,
                              arguments: state.lastTenBooks[index],
                            );
                          },
                        );
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
