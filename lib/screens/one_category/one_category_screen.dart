import 'package:amiriy/bloc/book/book_bloc.dart';
import 'package:amiriy/bloc/book/book_state.dart';
import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OneCategoryScreen extends StatelessWidget {
  const OneCategoryScreen({
    super.key,
    required this.categoryName,
  });

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          categoryName,
        ),
      ),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if(state.formStatus ==FormStatus.loading){
            return const Center(child: CircularProgressIndicator(),);
          }
          if(state.formStatus ==FormStatus.error){
            return Center(child: Text(state.errorText),);
          }
          if(state.formStatus ==FormStatus.success){
            return Column(
              children: List.generate(state.categoryBooks.length, (i){
                return Text(state.categoryBooks[i].bookName,);
              }),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
