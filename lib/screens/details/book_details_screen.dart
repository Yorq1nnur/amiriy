import 'package:amiriy/data/models/book_model.dart';
import 'package:amiriy/screens/global_widgets/global_text.dart';
import 'package:amiriy/screens/global_widgets/image_item.dart';
import 'package:amiriy/screens/routes.dart';
import 'package:amiriy/utils/sizedbox/get_sizedbox.dart';
import 'package:amiriy/utils/utility_functions/utility_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_utils/my_utils.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({
    super.key,
    required this.bookModel,
  });

  final BookModel bookModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light),
        child: Scaffold(
          body: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(
                        50,
                      ),
                      bottomRight: Radius.circular(
                        50,
                      ),
                    ),
                    child: ImageItem(
                      imageUrl: bookModel.imageUrl,
                      width: width,
                      height: height / 2.5,
                    ),
                  ),
                  Positioned(
                    top: 10.h,
                    left: 10.w,
                    child: IconButton(
                      style: IconButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: Theme.of(context).iconTheme.size,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10.h,
                    right: 10.w,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          style: IconButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          icon: Icon(
                            Icons.shop,
                            color: Theme.of(context).iconTheme.color,
                            size: Theme.of(context).iconTheme.size,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.pdfViewRoute,
                              arguments: bookModel,
                            );
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          icon: Icon(
                            Icons.picture_as_pdf,
                            color: Theme.of(context).iconTheme.color,
                            size: Theme.of(context).iconTheme.size,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
                    left: 20.w,
                    right: 20.w,
                    bottom: 20.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: GlobalText(
                          data: bookModel.bookDescription,
                          fontSize: 20.w,
                          textAlign: TextAlign.justify,
                          fontWeight: FontWeight.w900,
                          isTranslate: false,
                          maxLines: 10000,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
