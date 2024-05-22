import 'package:amiriy/data/models/book_model.dart';
import 'package:amiriy/screens/global_widgets/search_items.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import '../../../utils/colors/app_colors.dart';

class ItemSearch extends SearchDelegate<String> {
  final List<BookModel> items; // List of items to search from

  ItemSearch({
    required this.items,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<BookModel> results = items
        .where(
            (item) => item.bookName.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => DetailScreen(
            //         productModel: results[index]),
            //   ),
            // );
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 4.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
              border: Border.all(width: 1, color: AppColors.black),
            ),
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 14.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.network(
                  results[index].imageUrl,
                  fit: BoxFit.cover,
                  height: 84.h,
                  width: 84.w,
                ),
                SizedBox(width: 15.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      results[index].bookName,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      "\$${results[index].price.toString()}",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Row(
                      children: [
                        ...List.generate(
                          5,
                          (index) =>
                              const Icon(Icons.star, color: Colors.amber),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "7.5",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.amber,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        const Icon(
                          Icons.circle,
                          color: AppColors.black,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          results[index].rate.toString(),
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      "Free Shipping",
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<BookModel> suggestionList = query.isEmpty
        ? []
        : items
            .where((item) =>
                item.bookName.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => DetailScreen(
            //         productModel: suggestionList[index]),
            //   ),
            // );
          },
          child: SearchItems(
            bookModel: suggestionList[index],
          ),
        );
      },
    );
  }
}
