import 'package:amiriy/data/models/book_model.dart';
import 'package:amiriy/utils/styles/app_text_style.dart';
import 'package:amiriy/view_models/books_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../data/models/category_model.dart';
import '../../utils/colors/app_colors.dart';
import '../../view_models/category_view_model.dart';
import '../../view_models/image_view_model.dart';
import '../../view_models/notifications_view_model.dart';
import '../add_book/widgets/category_button.dart';

class EditBookScreen extends StatefulWidget {
  const EditBookScreen({
    super.key,
    required this.bookModel,
  });

  final BookModel bookModel;

  @override
  State<EditBookScreen> createState() => _EditBookScreenState();
}

int activeIndex = -1;

class _EditBookScreenState extends State<EditBookScreen> {
  final ImagePicker picker = ImagePicker();
  String imageUrl = "";
  String storagePath = "";

  @override
  Widget build(BuildContext context) {
    String bookName = '';
    String bookDescription = '';
    String bookPrice = '';
    String rate = '';
    String bookAuthor = '';
    String categoryDocId = '';
    String categoryName = '';

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
            "EDIT BOOK",
            style: AppTextStyle.interBold.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              // flex: 6,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                            onChanged: (v) {
                              bookName = v;
                            },
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              label: const Text(
                                "BOOK NAME",
                              ),
                              labelStyle: AppTextStyle.interBold.copyWith(
                                fontSize: 10.sp,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  16.r,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black54,
                                  width: 2.w,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  16.r,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2.w,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  16.r,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2.w,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            onChanged: (v) {
                              bookAuthor = v;
                            },
                            decoration: InputDecoration(
                              label: const Text(
                                "BOOK AUTHOR",
                              ),
                              labelStyle: AppTextStyle.interBold.copyWith(
                                fontSize: 10.sp,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  16.r,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black54,
                                  width: 2.w,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  16.r,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2.w,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  16.r,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2.w,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            onChanged: (v) {
                              bookDescription = v;
                            },
                            decoration: InputDecoration(
                              label: const Text(
                                "BOOK DESCRIPTION",
                              ),
                              labelStyle: AppTextStyle.interBold.copyWith(
                                fontSize: 10.sp,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  16.r,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black54,
                                  width: 2.w,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  16.r,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2.w,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  16.r,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2.w,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            onChanged: (v) {
                              rate = v;
                            },
                            decoration: InputDecoration(
                              label: const Text(
                                "BOOK'S RATE",
                              ),
                              labelStyle: AppTextStyle.interBold.copyWith(
                                fontSize: 10.sp,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  16.r,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black54,
                                  width: 2.w,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  16.r,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2.w,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  16.r,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2.w,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            onChanged: (v) {
                              bookPrice = v;
                            },
                            decoration: InputDecoration(
                              label: const Text(
                                "BOOK'S PRICE",
                              ),
                              labelStyle: AppTextStyle.interBold.copyWith(
                                fontSize: 10.sp,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  16.r,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black54,
                                  width: 2.w,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  16.r,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2.w,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  16.r,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2.w,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(
                      24.w,
                    ),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        16.r,
                      ),
                    ),
                  ),
                  onPressed: () {
                    takeAnImage();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "TAKE AN IMAGE",
                        style: AppTextStyle.interSemiBold.copyWith(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.image,
                        color: Colors.white,
                        size: 20.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: Text(
                "PLEASE, SELECT CATEGORY:",
                textAlign: TextAlign.center,
                style: AppTextStyle.interBold.copyWith(
                  color: AppColors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            StreamBuilder<List<CategoryModel>>(
              stream: context.read<CategoriesViewModel>().listenCategories(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                if (snapshot.hasData) {
                  List<CategoryModel> list =
                      snapshot.data as List<CategoryModel>;
                  return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ...List.generate(
                            list.length,
                            (index) => CategoryButton(
                                title: list[index].categoryName,
                                onTap: () {
                                  categoryName = list[index].categoryName;
                                  debugPrint(
                                      "\$\$\$\$\$\$\$\$\$========\n$activeIndex\n========\$\$\$\$\$\$\$\$\$");
                                  categoryDocId = list[index].docId;
                                  debugPrint(categoryDocId);
                                  setState(() {
                                    activeIndex = index;
                                  });
                                },
                                isActive: activeIndex == index),
                          )
                        ],
                      ));
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            SizedBox(
              height: 24.h,
            ),
            ZoomTapAnimation(
              onTap: () async {
                BookModel category = BookModel(
                  imageUrl:
                      imageUrl == "" ? widget.bookModel.imageUrl : imageUrl,
                  rate: rate == "" ? widget.bookModel.rate : rate,
                  bookAuthor: bookAuthor == ""
                      ? widget.bookModel.bookAuthor
                      : bookAuthor,
                  bookName:
                      bookName == "" ? widget.bookModel.bookName : bookName,
                  docId: widget.bookModel.docId,
                  price: bookPrice == ""
                      ? widget.bookModel.price
                      : double.parse(bookPrice),
                  bookDescription: bookDescription == ""
                      ? widget.bookModel.bookDescription
                      : bookDescription,
                  categoryId: categoryDocId != ''
                      ? categoryDocId
                      : widget.bookModel.categoryId,
                  categoryName: categoryName != ''
                      ? categoryName
                      : widget.bookModel.categoryName,
                );
                await context
                    .read<BooksViewModel>()
                    .updateProduct(category, context);
                if (!context.mounted) return;
                context.read<NotificationsViewModel>().showNotifications(
                      title: "$bookName NOMLI BOOK TAHRIRLANDI!!!",
                      body: bookDescription,
                      id: DateTime.now().millisecond,
                    );
                if (!context.mounted) return;
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: 30.w,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(
                    16.r,
                  ),
                ),
                child: Center(
                  child: Text(
                    "SAVE",
                    style: AppTextStyle.interBold.copyWith(
                      color: AppColors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getImageFromCamera() async {
    XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 1024,
      maxWidth: 1024,
    );
    if (image != null && context.mounted) {
      debugPrint("IMAGE PATH:${image.path}");
      storagePath = "files/images/${image.name}";
      if (mounted) {
        imageUrl = (await context.read<ImageViewModel>().uploadImage(
              pickedFile: image,
              storagePath: storagePath,
            ))!;
      }
      debugPrint("DOWNLOAD URL:$imageUrl");
    }
  }

  Future<void> _getImageFromGallery() async {
    XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1024,
      maxWidth: 1024,
    );
    if (image != null && context.mounted) {
      debugPrint("IMAGE PATH:${image.path}");
      storagePath = "files/images/${image.name}";
      if (mounted) {
        imageUrl = (await context.read<ImageViewModel>().uploadImage(
              pickedFile: image,
              storagePath: storagePath,
            ))!;
      }
      debugPrint("DOWNLOAD URL:$imageUrl");
    }
  }

  takeAnImage() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        )),
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12.h),
              ListTile(
                onTap: () async {
                  await _getImageFromGallery();
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                leading: const Icon(Icons.photo_album_outlined),
                title: const Text("Gallereyadan olish"),
              ),
              ListTile(
                onTap: () async {
                  await _getImageFromCamera();
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text("Kameradan olish"),
              ),
              SizedBox(height: 24.h),
            ],
          );
        });
  }
}
