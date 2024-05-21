import 'package:amiriy/bloc/auth/auth_bloc.dart';
import 'package:amiriy/bloc/auth/auth_event.dart';
import 'package:amiriy/bloc/auth/auth_state.dart';
import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/screens/auth/widgets/global_passwordfield.dart';
import 'package:amiriy/screens/auth/widgets/global_textbutton.dart';
import 'package:amiriy/screens/auth/widgets/global_textfield.dart';
import 'package:amiriy/screens/routes.dart';
import 'package:amiriy/utils/colors/app_colors.dart';
import 'package:amiriy/utils/constants/app_constants.dart';
import 'package:amiriy/utils/formaters/formatters.dart';
import 'package:amiriy/utils/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/user_model.dart';
import '../../../utils/styles/app_text_style.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKeyOne = GlobalKey<FormState>();
  final _formKeyTwo = GlobalKey<FormState>();
  final _formKeyThree = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 102.h, left: 29.w, right: 29.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "openRegister",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 30),
                      ),
                    ),
                    SizedBox(height: 11.h),
                    Center(
                      child: Text(
                        "register_to_use_app",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontSize: 12),
                      ),
                    ),
                    SizedBox(height: 64.h),
                    Text(
                      "name_and_surname",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 12),
                    ),
                    SizedBox(height: 10.h),
                    GlobalTextField(
                      onChanged: (v) {},
                      type: TextInputType.text,
                      inputFormatter: const [],
                      title: "anvar_anvarov",
                      icon: const Icon(Icons.person),
                      controller: nameController,
                      validate: AppConstants.textRegExp,
                      validateText: "wrong_name",
                      validateEmptyText: "enter_your_name",
                      formKey: _formKeyOne,
                    ),
                    SizedBox(height: 14.h),
                    Text(
                      "phone_",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 12),
                    ),
                    SizedBox(height: 10.h),
                    GlobalTextField(
                      onChanged: (v) {
                        if (v?.length == 17) {
                          FocusManager.instance.primaryFocus!.nextFocus();
                        }
                      },
                      type: TextInputType.phone,
                      inputFormatter: [AppInputFormatters.phoneFormatter],
                      title: '+998',
                      icon: const Icon(Icons.phone),
                      controller: phoneController,
                      validate: RegExp(''),
                      validateText: "wrong_name",
                      validateEmptyText: "enter_your_number",
                      formKey: _formKeyTwo,
                    ),
                    SizedBox(height: 14.h),
                    Text(
                      "password",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 12),
                    ),
                    SizedBox(height: 10.h),
                    GlobalPasswordField(
                      title: '* * * * * *',
                      icon: const Icon(Icons.lock),
                      controller: passwordController,
                      validate: AppConstants.passwordRegExp,
                      formKey: _formKeyThree,
                    ),
                    SizedBox(height: 24.h),
                    Padding(
                      padding: EdgeInsets.only(left: 25.w, right: 25.w),
                      child: GlobalTextButton(
                          isLoading: state.status == FormStatus.loading,
                          onTap: () {
                            final isValidateOne =
                                _formKeyOne.currentState!.validate();
                            final isValidateTwo =
                                _formKeyTwo.currentState!.validate();
                            final isValidateThree =
                                _formKeyThree.currentState!.validate();
                            if (isValidateOne &&
                                isValidateTwo &&
                                isValidateThree) {
                              String cleanedPhone = phoneController.text
                                  .replaceAll(RegExp(r'\D+'), '');
                              context.read<AuthBloc>().add(
                                    RegisterUserEvent(
                                      userModel: UserModel(
                                        username: nameController.text,
                                        phoneNumber: cleanedPhone,
                                        password: passwordController.text,
                                        userId: '',
                                        authUid: '',
                                      ),
                                    ),
                                  );
                            }
                          },
                          text: "register"),
                    ),
                    SizedBox(height: 15.h),
                    Padding(
                      padding: EdgeInsets.only(left: 25.w, right: 25.w),
                      child: SizedBox(
                        height: 50.h,
                        width: double.infinity,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: AppColors.cCA5A5A,
                          ),
                          onPressed: () {
                            context
                                .read<AuthBloc>()
                                .add(SignInWithGoogleEvent());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(AppImages.google, height: 20.h),
                              SizedBox(width: 10.w),
                              Text(
                                "sign_up_google",
                                style: AppTextStyle.interBold.copyWith(
                                    fontSize: 14, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "have_an_account",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 12),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(context,
                                RouteNames.loginRoute, (route) => false);
                          },
                          child: Text(
                            "login",
                            style: AppTextStyle.interRegular.copyWith(
                              fontSize: 12,
                              color: AppColors.cCA5A5A,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
