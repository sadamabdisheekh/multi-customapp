import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:multi/data/router_names.dart';
import 'package:multi/logic/cubit/signup_cubit.dart';
import 'package:multi/presentation/widgets/custom_textfield.dart';
import '../../../constants/dimensions.dart';
import '../../../constants/images.dart';
import '../../../constants/styles.dart';
import '../../../logic/utility.dart';
import '../../widgets/custom_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final phoneController = TextEditingController();
  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupErrorState) {
          Utils.showSnackBar(context, state.error.message);
        }
        if (state is SignupLoadedState) {
          Navigator.pushReplacementNamed(context, RouteNames.homeScreen);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Container(
              width: context.width > 700 ? 500 : context.width,
              padding: context.width > 700
                  ? const EdgeInsets.symmetric(horizontal: 0)
                  : const EdgeInsets.all(Dimensions.paddingSizeLarge),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Kimages.logo, width: 125),
                    const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text('Create an account'.tr,
                          style: robotoBold.copyWith(
                              fontSize: Dimensions.fontSizeExtraLarge)),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    CustomTextField(
                      hintText: 'Phone number',
                      inputType: TextInputType.phone,
                      controller: phoneController,
                    ),
                    const SizedBox(height: Dimensions.paddingSizeLarge),
                    CustomTextField(
                      hintText: 'First name',
                      controller: firstNameController,
                    ),
                    const SizedBox(height: Dimensions.paddingSizeLarge),
                    CustomTextField(
                      hintText: 'Middle name',
                      controller: middleNameController,
                    ),
                    const SizedBox(height: Dimensions.paddingSizeLarge),
                    CustomTextField(
                      hintText: 'Last name',
                      controller: lastNameController,
                    ),
                    const SizedBox(height: Dimensions.paddingSizeLarge),
                    CustomTextField(
                      hintText: 'Password',
                      controller: passwordController,
                      isPassword: true,
                    ),
                    const SizedBox(height: Dimensions.paddingSizeLarge),
                    BlocBuilder<SignupCubit, SignupState>(
                      builder: (context, state) {
                        return CustomButton(
                          radius: Dimensions.radiusDefault,
                          isBold: true,
                          buttonText: 'Sign Up',
                          onPressed: _signupSubmit,
                          isLoading: (state is SignupLoadingState),
                        );
                      },
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text('Already have account?',
                          style: robotoRegular.copyWith(
                              color: Theme.of(context).hintColor)),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.paddingSizeExtraSmall),
                          child: Text('Sign In',
                              style: robotoMedium.copyWith(
                                  color: Theme.of(context).primaryColor)),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _signupSubmit() {
    if (phoneController.text.trim().isEmpty) {
      return Utils.showSnackBar(context, 'phone number is required');
    }
    if (firstNameController.text.trim().isEmpty) {
      return Utils.showSnackBar(context, 'firt name is required');
    }
    if (middleNameController.text.trim().isEmpty) {
      return Utils.showSnackBar(context, 'middle name is required');
    }
    if (lastNameController.text.trim().isEmpty) {
      return Utils.showSnackBar(context, 'last name is required');
    }
    if (passwordController.text.trim().isEmpty) {
      return Utils.showSnackBar(context, 'password is required');
    }
    Utils.closeKeyBoard(context);
    Map<String, dynamic> body = {
      "mobile": phoneController.text.trim(),
      "firstName": firstNameController.text.trim(),
      "middleName": middleNameController.text.trim(),
      "lastName": lastNameController.text.trim(),
      "password": passwordController.text.trim()
    };

    context.read<SignupCubit>().signUpUsers(body);
  }
}
