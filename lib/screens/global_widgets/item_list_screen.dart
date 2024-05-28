import 'package:amiriy/bloc/book/book_bloc.dart';
import 'package:amiriy/bloc/book/book_state.dart';
import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/screens/global_widgets/item_books_search.dart';
import 'package:amiriy/screens/global_widgets/search_widget.dart';
import 'package:amiriy/utils/utility_functions/utility_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/colors/app_colors.dart';

class ItemsListScreen extends StatefulWidget {
  const ItemsListScreen({
    super.key,
    required this.category,
  });

  final String category;

  @override
  State<ItemsListScreen> createState() => _ItemsListScreenState();
}

class _ItemsListScreenState extends State<ItemsListScreen> {
  TextEditingController textEditingController = TextEditingController();
  String search = '';
  bool isSelect = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          widget.category,
        ),
        elevation: 0,
      ),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          UtilityFunctions.methodPrint(
            state.books.length,
          );
          if (state.formStatus == FormStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.formStatus == FormStatus.error) {
            return Center(
              child: Text("Error${state.errorText}"),
            );
          } else if (state.books.isEmpty) {
            return const Center(
              child: Text("Ma'lumot yo'q"),
            );
          } else {
            UtilityFunctions.methodPrint(
              state.books.length,
            );
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GestureDetector(
                    onTap: () {
                      showSearch(
                        context: context,
                        delegate: ItemBooksSearch(
                          items: context.read<BookBloc>().state.books,
                        ), // Pass your list of items here
                      );
                    },
                    child: SearchWidget(
                      controller: textEditingController,
                      voidCallback: (v) {},
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            );
          }
        },
      ),
    );
  }
}
