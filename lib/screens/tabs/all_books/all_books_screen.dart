import 'package:amiriy/bloc/book/book_bloc.dart';
import 'package:amiriy/bloc/book/book_state.dart';
import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/screens/global_widgets/global_search_delegate.dart';
import 'package:amiriy/screens/global_widgets/global_text.dart';
import 'package:amiriy/screens/global_widgets/image_item.dart';
import 'package:amiriy/screens/global_widgets/search_widget.dart';
import 'package:amiriy/screens/global_widgets/shimmer_container.dart';
import 'package:amiriy/screens/global_widgets/tab_item.dart';
import 'package:amiriy/screens/routes.dart';
import 'package:amiriy/utils/sizedbox/get_sizedbox.dart';
import 'package:amiriy/utils/utility_functions/utility_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_utils/my_utils.dart';

class AllBooksScreen extends StatefulWidget {
  const AllBooksScreen({super.key});

  @override
  State<AllBooksScreen> createState() => _AllBooksScreenState();
}

class _AllBooksScreenState extends State<AllBooksScreen> {
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
          data: "all_books",
          fontSize: 20.sp,
          fontWeight: FontWeight.w900,
          isTranslate: true,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                showSearch(
                  context: context,
                  delegate: ItemSearch(
                    items: context.read<BookBloc>().state.books,
                  ),
                );
              },
              child: SearchWidget(
                controller: searchController,
                voidCallback: (v) {},
              ),
            ),
            BlocBuilder<BookBloc, BookState>(builder: (context, state) {
              if (state.formStatus == FormStatus.loading) {
                return ShimmerContainer(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 4,
                );
              }
              if (state.formStatus == FormStatus.error) {
                return Center(
                  child: Text(state.errorText),
                );
              }
              if (state.formStatus == FormStatus.success) {
                return Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      vertical: 20.h,
                    ),
                    itemCount: state.books.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TabItem(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RouteNames.bookDetailsRoute,
                            arguments: state.books[index],
                          );
                        },
                        duration: const Duration(microseconds: 500),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: ImageItem(
                                  imageUrl: state.books[index].imageUrl,
                                  width: MediaQuery.of(context).size.width,
                                  height: 220.h,
                                ),
                              ),
                              10.getH(),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.w),
                                    child: Text(
                                      state.books[index].bookName,
                                    ),
                                  ),
                                  20.getW(),
                                  UtilityFunctions.buildRatingStars(
                                    double.parse(state.books[index].rate),
                                    MainAxisAlignment.center,
                                  ),
                                ],
                              ),
                              const Divider(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }
}
