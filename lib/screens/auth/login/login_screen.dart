import 'package:amiriy/bloc/auth/auth_bloc.dart';
import 'package:amiriy/bloc/auth/auth_event.dart';
import 'package:amiriy/bloc/auth/auth_state.dart';
import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/screens/auth/dialog/error_dialog.dart';
import 'package:amiriy/screens/auth/widgets/global_passwordfield.dart';
import 'package:amiriy/screens/auth/widgets/global_textbutton.dart';
import 'package:amiriy/screens/auth/widgets/global_textfield.dart';
import 'package:amiriy/utils/colors/app_colors.dart';
import 'package:amiriy/utils/constants/app_constants.dart';
import 'package:amiriy/utils/formaters/formatters.dart';
import 'package:amiriy/utils/images/app_images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_utils/my_utils.dart';
import '../../routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKeyTwo = GlobalKey<FormState>();
  final _formKeyThree = GlobalKey<FormState>();

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == FormStatus.error) {
              debugPrint("Hello dialog");
              errorDialog(context: context, errorText: state.errorMessage);
            }
            if (state.status == FormStatus.authenticated) {
              if (state.statusMessage == "registered") {
                ///TODO ADD USER DATA TO USER TABLE
                // BlocProvider.of<ResumeBloc>(context).add(
                //   InsertResumeEvent(uid: state.userModel.authUid),
                // );
              }
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteNames.tabRoute,
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 102.h, left: 29.w, right: 29.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "welcome_back".tr(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 30),
                      ),
                    ),
                    SizedBox(height: 11.h),
                    Center(
                      child: Text(
                        "login_to_use_app".tr(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 12),
                      ),
                    ),
                    SizedBox(height: 64.h),
                    Text(
                      "phone".tr(),
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
                      validateText: 'Invalid phone',
                      validateEmptyText: 'Enter phone number',
                      formKey: _formKeyTwo,
                    ),
                    SizedBox(height: 14.h),
                    Text(
                      "password".tr(),
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
                    SizedBox(height: 20.h),
                    SizedBox(height: 24.h),
                    Padding(
                      padding: EdgeInsets.only(left: 25.w, right: 25.w),
                      child: GlobalTextButton(
                        isLoading: state.status == FormStatus.loading,
                        onTap: () {
                          final isValidateTwo =
                              _formKeyTwo.currentState!.validate();
                          final isValidateThree =
                              _formKeyThree.currentState!.validate();
                          if (isValidateTwo && isValidateThree) {
                            String cleanedPhone = phoneController.text
                                .replaceAll(RegExp(r'\D+'), '');
                            context.read<AuthBloc>().add(
                                  LoginUserEvent(
                                    phoneNumber: cleanedPhone,
                                    password: passwordController.text,
                                  ),
                                );
                          }
                        },
                        text: "login",
                      ),
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
                                "sign_up_google".tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontSize: 14,
                                    ),
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
                          "have_an_account".tr(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 12),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.registerRoute,
                            );
                          },
                          child: Text(
                            'Sign up'.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontSize: 12,
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
