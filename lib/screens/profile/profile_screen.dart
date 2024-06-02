import 'dart:io';
import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/bloc/user/user_bloc.dart';
import 'package:amiriy/data/models/user_model.dart';
import 'package:amiriy/screens/global_widgets/custom_text_button.dart';
import 'package:amiriy/screens/global_widgets/custom_text_field.dart';
import 'package:amiriy/utils/helpers/helpers.dart';
import 'package:amiriy/utils/images/app_images.dart';
import 'package:amiriy/utils/utility_functions/utility_functions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:my_utils/my_utils.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/constants/app_constants.dart';
import '../../bloc/image/image_bloc.dart';
import '../../bloc/image/image_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _name = FocusNode();
  final FocusNode _dateF = FocusNode();
  final FocusNode _addressF = FocusNode();
  final FocusNode _emailF = FocusNode();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _email = TextEditingController();

  File? imageFile;
  XFile? xFile;
  DateTime? dateTime;
  TimeOfDay? timeOfDay;
  bool gender = true;
  bool save = false;

  final ImagePicker picker = ImagePicker();
  String imageUrl = "";
  String storagePath = "";

  @override
  void initState() {
    Future.microtask(() async {
      context.read<UserBloc>().add(
            GetUserEvent(
              userId: FirebaseAuth.instance.currentUser!.uid,
            ),
          );
      await Future.delayed(
        const Duration(
          seconds: 1,
        ),
      );
      if (mounted) {
        UtilityFunctions.methodPrint(
          'CURRENT USER: ${context.read<UserBloc>().state.userModel.username}\n${context.read<UserBloc>().state.userModel.phoneNumber}',
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (state.formStatus == FormStatus.success) {
                UtilityFunctions.methodPrint(
                  'CURRENT USER: ${context.read<UserBloc>().state.userModel.username}\n${context.read<UserBloc>().state.userModel.phoneNumber}',
                );
                _nameController.text = state.userModel.username;
              }
              if (state.formStatus == FormStatus.loading) {
                save = true;
                setState(() {});
              } else {
                save = false;
              }
            },
          ),
          BlocListener<ImageBloc, ImageState>(
            listener: (context, state) {
              if (state is ImageSuccess) {
                setState(() {
                  imageUrl = state.imageUrl;
                });
                debugPrint("DOWNLOAD URL edit profile: $imageUrl");
              } else if (state is ImageFailure) {
                debugPrint("Image upload failed: ${state.error}");
              }
            },
          ),
        ],
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state.userModel.imageUrl.isNotEmpty && imageUrl.isEmpty) {
              imageUrl = state.userModel.imageUrl;
            }
            if (state.formStatus == FormStatus.loading) {
              return Center(
                child: Lottie.asset(
                  AppImages.loadingLottie,
                ),
              );
            }
            if (state.formStatus == FormStatus.success) {
              UtilityFunctions.methodPrint('value');
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.zero,
                          topRight: Radius.zero,
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                        gradient: LinearGradient(
                            colors: [Colors.purple, Colors.indigo]),
                      ),
                      padding: EdgeInsets.all(25.w),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 40.h,
                          ),
                          BlocBuilder<ImageBloc, ImageState>(
                            builder: (BuildContext context, ImageState state) {
                              if (state is ImageInitial) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    90.w,
                                  ),
                                  child: Image.network(
                                    imageUrl.isEmpty
                                        ? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"
                                        : imageUrl,
                                    width: 60.w,
                                    height: 60.w,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }
                              if (state is ImageLoading) {
                                return SizedBox(
                                  width: 60.w,
                                  height: 60.h,
                                  child: Lottie.asset(AppImages.loadingLottie),
                                );
                              }
                              if (state is ImageSuccess) {
                                imageUrl = state.imageUrl;
                                UtilityFunctions.methodPrint(
                                    'WHAT A FUCK: $imageUrl}');
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    90.w,
                                  ),
                                  child: Image.network(
                                    state.imageUrl,
                                    width: 60.w,
                                    height: 60.w,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            state.userModel.username.isEmpty
                                ? "NOMALUM"
                                : state.userModel.username,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: "DM sans",
                            ),
                          ),
                          SizedBox(
                            height: 14.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              takeAnImage(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                "change_image".tr(),
                                style: const TextStyle(
                                  fontFamily: "Dm sans",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "name".tr(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          CustomTexField(
                            action: TextInputAction.next,
                            inputFormatter: const [],
                            validate: AppConstants.textRegExp,
                            validateText: 'Xato kiritingiz!',
                            validateEmptyText: 'Ism',
                            fromKey: _formKey,
                            maxLines: 1,
                            controller: _nameController,
                            focusNode: _name,
                            type: TextInputType.text,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text("date_birth".tr(),
                              style: Theme.of(context).textTheme.bodyLarge),
                          Row(
                            children: [
                              Expanded(
                                flex: 8,
                                child: CustomTexField(
                                  action: TextInputAction.next,
                                  validate: AppConstants.textRegExp,
                                  validateText: 'Xato kiritingiz!',
                                  inputFormatter: [
                                    MaskTextInputFormatter(
                                      mask: '####/##/##',
                                      filter: {"#": RegExp(r'[0-9]')},
                                      type: MaskAutoCompletionType.lazy,
                                    )
                                  ],
                                  validateEmptyText: 'Date',
                                  fromKey: _formKey,
                                  maxLines: 1,
                                  controller: _date,
                                  focusNode: _dateF,
                                  type: TextInputType.number,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () async {
                                    dateTime = await showDatePicker(
                                      barrierDismissible: false,
                                      cancelText: "Cancel",
                                      confirmText: "Choose time",
                                      context: context,
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2030),
                                    );
                                    _date.text =
                                        DateFormat.yMMMEd().format(dateTime!);
                                  },
                                  child: const SizedBox(
                                    width: double.infinity,
                                    child: Center(
                                      child: Icon(
                                        Icons.calendar_month,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            "address".tr(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          CustomTexField(
                            action: TextInputAction.next,
                            inputFormatter: const [],
                            validate: AppConstants.textRegExp,
                            validateText: 'Xato kiritingiz!',
                            validateEmptyText: 'Manzil',
                            fromKey: _formKey,
                            maxLines: 1,
                            controller: _address,
                            focusNode: _addressF,
                            type: TextInputType.text,
                          ),
                          SizedBox(height: 15.h),
                          Text("email".tr(),
                              style: Theme.of(context).textTheme.bodyMedium),
                          CustomTexField(
                            action: TextInputAction.next,
                            inputFormatter: const [],
                            validate: AppConstants.emailRegExp,
                            validateText: 'Xato kiritingiz!',
                            validateEmptyText: 'email'.tr(),
                            fromKey: _formKey,
                            maxLines: 1,
                            controller: _email,
                            focusNode: _emailF,
                            type: TextInputType.text,
                          ),
                          SizedBox(height: 20.h),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 81.0),
                            child: CustomTextButton(
                                height: 50.h,
                                width: 213,
                                color: AppColors.c_2A3256,
                                text:
                                    save == false ? "save".tr() : "LOADING...",
                                onTab: () {
                                  UserModel resumeModel = state.userModel;
                                  resumeModel = resumeModel.copyWith(
                                    imageUrl: imageUrl.isEmpty
                                        ? state.userModel.imageUrl
                                        : imageUrl,
                                    username: _nameController.text.isEmpty
                                        ? resumeModel.username
                                        : _nameController.text,
                                  );
                                  UtilityFunctions.methodPrint(
                                    'CURRENT IMAGE: $imageUrl, FROM IMAGE BLOC URL: ${context.read<ImageBloc>().imageUrl}',
                                  );
                                  context.read<UserBloc>().add(
                                        UpdateUserEvent(
                                          resumeModel,
                                        ),
                                      );
                                  UtilityFunctions.methodPrint(
                                    'CURRENT USER AUTH UID IS: ${resumeModel.authUid}',
                                  );
                                  context.read<UserBloc>().add(
                                        GetUserEvent(
                                          userId: FirebaseAuth
                                              .instance.currentUser!.uid,
                                        ),
                                      );
                                  if (!save) {
                                    Navigator.pop(context);
                                  }
                                }),
                          ),
                          SizedBox(
                            height: 42.h,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
