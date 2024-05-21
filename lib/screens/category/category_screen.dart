import 'package:cached_network_image/cached_network_image.dart';
import 'package:amiriy/data/models/book_model.dart';
import 'package:amiriy/data/models/category_model.dart';
import 'package:amiriy/screens/book_details/book_details_screen.dart';
import 'package:amiriy/utils/styles/app_text_style.dart';
import 'package:amiriy/view_models/books_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../utils/colors/app_colors.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({
    super.key,
    required this.categoryModel,
    required this.categoryDocId,
  });

  final CategoryModel categoryModel;
  final String categoryDocId;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: ZoomTapAnimation(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.black,
            ),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.white,
          title: Text(
            widget.categoryModel.categoryName,
            style: AppTextStyle.interBold.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        body: StreamBuilder<List<BookModel>>(
          stream: context
              .read<BooksViewModel>()
              .listenProductsByCategory(categoryDocId: widget.categoryDocId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.hasData) {
              List<BookModel> list = snapshot.data as List<BookModel>;
              return ListView(
                children: [
                  ...List.generate(
                    list.length,
                    (index) {
                      BookModel book = list[index];
                      return ZoomTapAnimation(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookDetailsScreen(
                                bookModel: book,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.h,
                            vertical: 10.h,
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amberAccent.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(
                              16.r,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  16.r,
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: book.imageUrl,
                                  height: 200.h,
                                  width: 150.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "BOOK NAME:",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyle.interBold.copyWith(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    Text(
                                      book.bookName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyle.interBold.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      "BOOK AUTHOR:",
                                      style: AppTextStyle.interBold.copyWith(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      book.bookAuthor,
                                      style: AppTextStyle.interBold.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16.sp,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
