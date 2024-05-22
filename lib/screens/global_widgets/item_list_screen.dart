import 'package:amiriy/bloc/book/book_bloc.dart';
import 'package:amiriy/bloc/book/book_state.dart';
import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/screens/global_widgets/global_search_delegate.dart';
import 'package:amiriy/screens/global_widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/colors/app_colors.dart';

class ItemsListScreen extends StatefulWidget {
  const ItemsListScreen({super.key, required this.category});

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
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       Navigator.pushNamed(context, RouteNames.cartScreen);
        //     },
        //     icon: const Icon(Icons.shopping_cart,
        //
        //     ),
        //   ),
        //   const SizedBox(width: 4),
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(Icons.person),
        //   ),
        //   const SizedBox(width: 4),
        //
        //   const SizedBox(width: 4),
        // ],
        elevation: 0,
      ),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
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
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GestureDetector(
                    onTap: () {
                      showSearch(
                        context: context,
                        delegate: ItemSearch(
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
