import 'package:amiriy/data/models/book_model.dart';
import 'package:amiriy/screens/global_widgets/image_item.dart';
import 'package:amiriy/utils/sizedbox/get_sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';

class SearchItems extends StatelessWidget {
  const SearchItems({super.key, required this.bookModel});

  final BookModel bookModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 14.h,
        horizontal: 35.w,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  20,
                ),
                child: ImageItem(
                  imageUrl: bookModel.imageUrl,
                  width: width/3,
                  height: height/3,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    bookModel.bookName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  50.getH(),
                  Text(
                    bookModel.bookDescription,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
          13.getH(),
          const Divider(),
        ],
      ),
    );
  }
}
