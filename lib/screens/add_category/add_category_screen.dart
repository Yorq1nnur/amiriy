import 'package:cached_network_image/cached_network_image.dart';
import 'package:amiriy/data/models/category_model.dart';
import 'package:amiriy/utils/styles/app_text_style.dart';
import 'package:amiriy/view_models/category_view_model.dart';
import 'package:amiriy/view_models/notifications_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../utils/colors/app_colors.dart';
import '../../view_models/image_view_model.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final TextEditingController categoryNameController = TextEditingController();

  // final TextEditingController imageUrlController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  String imageUrl = "";
  String storagePath = "";
  bool imageNotEmpty = false;

  @override
  void dispose() {
    categoryNameController.dispose();
    // imageUrlController.dispose();
    super.dispose();
  }

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
            "ADD CATEGORY",
            style: AppTextStyle.interBold.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 20.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                controller: categoryNameController,
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
              SizedBox(
                height: 24.h,
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(10.w),
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
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
                height: 24.h,
              ),
              imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      height: 300.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : const CircularProgressIndicator(),
              SizedBox(
                height: 24.h,
              ),
              const Spacer(),
              ZoomTapAnimation(
                onTap: () async {
                  if (categoryNameController.text != "" && imageUrl != "") {
                    CategoryModel category = CategoryModel(
                      imageUrl: imageUrl,
                      categoryName: categoryNameController.text,
                      docId: "",
                    );
                    await context.read<CategoriesViewModel>().insertCategory(
                          category,
                          context,
                        );
                    if (!context.mounted) return;
                    context.read<NotificationsViewModel>().showNotifications(
                          title:
                              "${categoryNameController.text} NOMLI YANGI KATEGORIYA QO'SHILDI!!!",
                          body: categoryNameController.text,
                          id: DateTime.now().millisecond,
                        );
                    if (!context.mounted) return;
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "PLEASE COMPLETE ALL DETAILS",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
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
      imageNotEmpty = true;
      setState(() {});
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
      imageNotEmpty = true;
      setState(() {});
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
                  imageNotEmpty = true;
                  setState(() {});
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
                  imageNotEmpty = true;
                  setState(() {});
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
