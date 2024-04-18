import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:multi/logic/cubit/signup_cubit.dart';
import 'package:multi/presentation/widgets/custom_textfield.dart';
import '../../../constants/dimensions.dart';
import '../../../constants/images.dart';
import '../../../constants/styles.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {},
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Container(
              width: context.width > 700 ? 500 : context.width,
              padding: context.width > 700
                  ? const EdgeInsets.symmetric(horizontal: 0)
                  : const EdgeInsets.all(Dimensions.paddingSizeLarge),
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
    );
  }

  _signupSubmit() {
    context.read<SignupCubit>().signUpUsers();
    // if (phoneController.text.trim().isEmpty) {}
    // if (firstNameController.text.trim().isEmpty) {}
    // if (middleNameController.text.trim().isEmpty) {}
    // if (lastNameController.text.trim().isEmpty) {}
  }
}
