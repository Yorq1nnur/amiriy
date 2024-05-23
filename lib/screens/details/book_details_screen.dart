import 'package:amiriy/data/models/book_model.dart';
import 'package:amiriy/screens/global_widgets/global_text.dart';
import 'package:amiriy/screens/global_widgets/image_item.dart';
import 'package:amiriy/utils/colors/app_colors.dart';
import 'package:amiriy/utils/sizedbox/get_sizedbox.dart';
import 'package:amiriy/utils/utility_functions/utility_functions.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({
    super.key,
    required this.bookModel,
  });

  final BookModel bookModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          66.getH(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Ink(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: Theme.of(context).iconTheme.color,
                        size: Theme.of(context).iconTheme.size,
                      ),
                      const GlobalText(
                        data: 'back',
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        isTranslate: true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          50.getH(),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ImageItem(
                imageUrl: bookModel.imageUrl,
                width: width / 2,
                height: height / 3,
              ),
            ),
          ),
          20.getH(),
          Center(
            child: GlobalText(
              data: bookModel.bookName,
              fontSize: 20.w,
              fontWeight: FontWeight.w900,
              isTranslate: false,
            ),
          ),
          UtilityFunctions.buildRatingStars(
            double.parse(
              bookModel.rate,
            ),
            MainAxisAlignment.center,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: 40.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: GlobalText(
                      data: bookModel.bookDescription,
                      fontSize: 20.w,
                      fontWeight: FontWeight.w900,
                      isTranslate: false,
                      maxLines: 10000,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 20.h,
              left: 20.w,
              right: 20.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Ink(
                  height: 50.h,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                    color: AppColors.c29BB89,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {},
                    child: Center(
                      child: GlobalText(
                        data: 'buy',
                        fontSize: 20.w,
                        fontWeight: FontWeight.w900,
                        isTranslate: true,
                      ),
                    ),
                  ),
                ),
                GlobalText(
                  data: 'or',
                  fontSize: 20.w,
                  color: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.color
                      ?.withOpacity(0.6),
                  fontWeight: FontWeight.w900,
                  isTranslate: true,
                ),
                Ink(
                  height: 50.h,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                    color: AppColors.c29BB89,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {},
                    child: Center(
                      child: GlobalText(
                        data: 'rent',
                        fontSize: 20.w,
                        fontWeight: FontWeight.w900,
                        isTranslate: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
