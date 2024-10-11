import 'package:amiriy/data/models/book_model.dart';
import 'package:amiriy/screens/global_widgets/global_text.dart';
import 'package:amiriy/screens/global_widgets/image_item.dart';
import 'package:amiriy/utils/sizedbox/get_sizedbox.dart';
import 'package:amiriy/utils/utility_functions/utility_functions.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';

class BooksItem extends StatelessWidget {
  const BooksItem({
    super.key,
    required this.bookModel,
    required this.voidCallback,
    this.heightt,
    this.widthh,
  });

  final BookModel bookModel;
  final VoidCallback voidCallback;
  final double? widthh;
  final double? heightt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: InkWell(
        borderRadius: BorderRadius.circular(
          20,
        ),
        onTap: voidCallback,
        child: Container(
          padding: EdgeInsets.only(bottom: 10.h),
          width: widthh ?? width / 2,
          // height: heightt ?? height / 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              20,
            ),
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 2.w,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(
                    20,
                  ),
                  topRight: Radius.circular(
                    20,
                  ),
                ),
                child: ImageItem(
                  imageUrl: bookModel.imageUrl,
                  height: height / 4,
                  width: width / 2,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      bookModel.bookName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 20.w,
                          ),
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      bookModel.bookAuthor,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 20.w,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    UtilityFunctions.buildRatingStars(
                      double.parse(
                        bookModel.rate,
                      ),
                      MainAxisAlignment.start,
                    ),
                    10.getH(),
                    GlobalText(
                      data: UtilityFunctions.timeAgo(
                        DateTime.parse(
                          bookModel.dateTime,
                        ),
                      ),
                      fontSize: 16.w,
                      fontWeight: FontWeight.w900,
                      isTranslate: false,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
