import 'package:cached_network_image/cached_network_image.dart';
import 'package:amiriy/data/models/category_model.dart';
import 'package:amiriy/utils/styles/app_text_style.dart';
import 'package:amiriy/view_models/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../utils/colors/app_colors.dart';
import '../../view_models/image_view_model.dart';

class EditCategoryScreen extends StatefulWidget {
  const EditCategoryScreen({
    super.key,
    required this.categoryModel,
  });

  final CategoryModel categoryModel;

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  final ImagePicker picker = ImagePicker();
  String imageUrl = "";
  String storagePath = "";
  String categoryName = '';

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
            "EDIT BOOK",
            style: AppTextStyle.interBold.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        body: Column(
          children: [
            SingleChildScrollView(
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
                            categoryName = v;
                          },
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            label: const Text(
                              "CATEGORY NAME",
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
            SizedBox(
              height: 50.h,
            ),
            imageUrl == ''
                ? Center(
                    child: CachedNetworkImage(
                      imageUrl: widget.categoryModel.imageUrl,
                      height: 300.h,
                      width: 300.w,
                      fit: BoxFit.cover,
                    ),
                  )
                : Center(
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      height: 300.h,
                      width: 300.w,
                      fit: BoxFit.cover,
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
            const Spacer(),
            ZoomTapAnimation(
              onTap: () async {
                CategoryModel category = CategoryModel(
                  imageUrl:
                      imageUrl == "" ? widget.categoryModel.imageUrl : imageUrl,
                  categoryName: categoryName != ''
                      ? categoryName
                      : widget.categoryModel.categoryName,
                  docId: widget.categoryModel.docId,
                );
                await context
                    .read<CategoriesViewModel>()
                    .updateCategory(category, context);
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
            SizedBox(
              height: 20.h,
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
        setState(() {

        });
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
        setState(() {

        });
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
