import 'package:amiriy/data/models/book_model.dart';
import 'package:amiriy/screens/global_widgets/image_item.dart';
import 'package:amiriy/utils/colors/app_colors.dart';
import 'package:amiriy/utils/images/app_images.dart';
import 'package:amiriy/utils/sizedbox/get_sizedbox.dart';
import 'package:amiriy/utils/utility_functions/utility_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_utils/my_utils.dart';

class SearchItems extends StatelessWidget {
  const SearchItems({super.key, required this.bookModel});

  final BookModel bookModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 14.h,
        horizontal: 20.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  20,
                ),
                child: ImageItem(
                  imageUrl: bookModel.imageUrl,
                  width: width / 3,
                  height: height / 5,
                ),
              ),
              10.getW(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    bookModel.bookName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                  30.getH(),
                  SizedBox(
                    width: 225.w,
                    child: Text(
                      bookModel.bookDescription,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  30.getH(),
                  UtilityFunctions.buildRatingStars(
                    double.parse(
                      bookModel.rate,
                    ),
                    MainAxisAlignment.start,
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
