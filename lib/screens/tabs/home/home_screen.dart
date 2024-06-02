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
import 'package:amiriy/screens/global_widgets/category_button.dart';
import 'package:amiriy/screens/global_widgets/item_books_search.dart';
import 'package:amiriy/screens/global_widgets/global_text.dart';
import 'package:amiriy/screens/routes.dart';
import 'package:amiriy/utils/images/app_images.dart';
import 'package:amiriy/utils/sizedbox/get_sizedbox.dart';
import 'package:amiriy/utils/utility_functions/utility_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
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
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: ItemBooksSearch(
                  items: context.read<BookBloc>().state.books,
                ),
              );
            },
            icon: Icon(
              Icons.search,
              size: 24.w,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          10.getW(),
        ],
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
                return context.read<BannerBloc>().state.banners.isNotEmpty
                    ? BannerItems(
                        banners: state.banners,
                      )
                    : const SizedBox.shrink();
              },
            ),
            context.read<BannerBloc>().state.banners.isNotEmpty
                ? 20.getH()
                : const SizedBox.shrink(),
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
                    return Center(
                      child: Lottie.asset(
                        AppImages.loadingLottie,
                      ),
                    );
                  }
                  if (state.formStatus == FormStatus.success) {
                    return Wrap(
                      children: [
                        ...List.generate(
                          state.allCategories.length > 10
                              ? state.allCategories.length -
                                  (state.allCategories.length - 10)
                              : state.allCategories.length,
                          (index) => CategoryButton(
                            voidCallback: () async {
                              context.read<BookBloc>().add(
                                    GetBooksByCategoryId(
                                      categoryId:
                                          state.allCategories[index].docId,
                                    ),
                                  );
                              await Future.delayed(
                                  const Duration(milliseconds: 500));
                              if (!context.mounted) return;
                              Navigator.pushNamed(
                                context,
                                RouteNames.oneCategoryRoute,
                                arguments: {
                                  'categoryName':
                                      state.allCategories[index].categoryName,
                                  'categoryId':
                                      state.allCategories[index].docId,
                                },
                              ).then((v) async {
                                context.read<BookBloc>().add(
                                      GetBooksByCategoryId(
                                        categoryId:
                                            state.allCategories[index].docId,
                                      ),
                                    );
                                await Future.delayed(
                                  const Duration(
                                    seconds: 1,
                                  ),
                                );
                                if (!context.mounted) return;
                                UtilityFunctions.methodPrint(
                                  'WHAT WHAT WHAT WHAT WHAT ${context.read<BookBloc>().state.categoryBooks.length}',
                                );
                              });
                            },
                            title: state.allCategories[index].categoryName,
                            isTranslate: false,
                          ),
                        ),
                        CategoryButton(
                          voidCallback: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.categoryRoute,
                            );
                          },
                          title: "more",
                          isTranslate: true,
                        ),
                      ],
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
                    height: height / 2.3,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.w,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.lastTenBooks.length,
                      itemBuilder: (BuildContext context, int index) {
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
                    height: height / 2.3,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.w,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.lastTenBooks.length,
                      itemBuilder: (BuildContext context, int index) {
                        UtilityFunctions.methodPrint(
                          "$index dagi book date: ${state.lastTenBooks[index].dateTime}",
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
