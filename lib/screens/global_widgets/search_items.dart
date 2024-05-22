import 'package:amiriy/data/models/book_model.dart';
import 'package:amiriy/utils/sizedbox/get_sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: bookModel.imageUrl,
                  height: width / 3,
                  width: width / 3,
                  placeholder: (context, s) {
                    return const CircularProgressIndicator();
                  },
                  errorWidget: (context, s, w) {
                    return Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 100.w,
                    );
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    bookModel.bookName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
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
