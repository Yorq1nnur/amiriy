import 'package:amiriy/bloc/book/book_bloc.dart';
import 'package:amiriy/bloc/book/book_event.dart';
import 'package:amiriy/bloc/book/book_state.dart';
import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/data/models/book_model.dart';
import 'package:amiriy/screens/global_widgets/books_item.dart';
import 'package:amiriy/screens/global_widgets/search_text_field.dart';
import 'package:amiriy/screens/routes.dart';
import 'package:amiriy/utils/utility_functions/utility_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_utils/my_utils.dart';

class OneCategoryScreen extends StatefulWidget {
  const OneCategoryScreen({
    super.key,
    required this.categoryDetails,
  });

  final Map<String, dynamic> categoryDetails;

  @override
  State<OneCategoryScreen> createState() => _OneCategoryScreenState();
}

class _OneCategoryScreenState extends State<OneCategoryScreen> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  Future<void> _addSearchToCategoryProducts(String query) async {
    if (query.isNotEmpty) {
      context.read<BookBloc>().add(
            SearchProductsProductsEvent(
              query: query,
              isCategoryProducts: true,
              books: categoryBooks,
            ),
          );
    } else {
      context.read<BookBloc>().add(
            GetBooksByCategoryId(
              categoryId: widget.categoryDetails['categoryId'],
            ),
          );
    }
  }

  List<BookModel> categoryBooks = [];

  @override
  void initState() {
    Future.microtask(() {
      categoryBooks = context.read<BookBloc>().state.categoryBooks;
      UtilityFunctions.methodPrint(
        'CURRENT SEARCHER CATEGORY PRODUCTS OF LENGTH IS: ${categoryBooks.length}',
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.categoryDetails['categoryName'],
        ),
      ),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state.formStatus == FormStatus.error) {
            return Center(
              child: Text(
                state.errorText,
              ),
            );
          }
          if (state.formStatus == FormStatus.success) {
            return Column(
              children: [
                SearchTextField(
                  textEditingController: textEditingController,
                  valueChanged: (v) {
                    _addSearchToCategoryProducts(
                      v,
                    );
                  },
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: List.generate(state.categoryBooks.length,
                              (index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 10.h,
                              ),
                              child: BooksItem(
                                heightt: height / 2.3,
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
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
