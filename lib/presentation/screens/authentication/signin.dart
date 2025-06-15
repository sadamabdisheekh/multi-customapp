import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:multi/constants/dimensions.dart';
import 'package:multi/constants/images.dart';
import 'package:multi/data/router_names.dart';
import 'package:multi/logic/cubit/signin_cubit.dart';
import 'package:multi/logic/utilits/utility.dart';
import 'package:multi/logic/utilits/validators.dart';
import 'package:multi/presentation/widgets/custom_button.dart';
import 'package:multi/presentation/widgets/custom_textfield.dart';

import '../../../constants/styles.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state is SigninErrorState) {
          Utils.closeDialog(context);
          Utils.showSnackBar(context, state.error.message);
        }
        if (state is SigninLoadedState) {
          Navigator.pushNamedAndRemoveUntil(
              context, RouteNames.mainPage, (route) => false);
        }
      },
      child: Scaffold(
        body: Center(
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
                      child: Text('Sign In',
                          style: robotoBold.copyWith(
                              fontSize: Dimensions.fontSizeExtraLarge)),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    CustomTextField(
                      hintText: 'email',
                      maxLines: 1,
                      inputType: TextInputType.emailAddress,
                      controller: emailController,
                      prefixIcon: Icons.email,
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeDefault,
                    ),
                    CustomTextField(
                      hintText: 'Password',
                      maxLines: 1,
                      isPassword: true,
                      inputAction: TextInputAction.done,
                      inputType: TextInputType.visiblePassword,
                      prefixIcon: Icons.lock,
                      controller: passwordController,
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text('forgot password?',
                            style: robotoRegular.copyWith(
                                color: Theme.of(context).primaryColor)),
                      ),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    BlocBuilder<SigninCubit, SigninState>(
                      builder: (context, state) {
                        return CustomButton(
                          buttonText: 'Login',
                          isLoading: (state is SigninLoadingState),
                          onPressed: _submit,
                        );
                      },
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text("Don't have account?",
                          style: robotoRegular.copyWith(
                              color: Theme.of(context).hintColor)),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RouteNames.signupScreen);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.paddingSizeExtraSmall),
                          child: Text('Sign Up',
                              style: robotoMedium.copyWith(
                                  color: Theme.of(context).primaryColor)),
                        ),
                      ),
                    ]),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  _submit() {
    if (emailController.text.trim().isEmpty) {
      return Utils.showSnackBar(context, 'email is required');
    }
    if (!isValidEmail(emailController.text.trim())) {
      return Utils.showSnackBar(context, 'invalid email');
    }
    if (passwordController.text.trim().isEmpty) {
      return Utils.showSnackBar(context, 'password is required');
    }
    Utils.closeKeyBoard(context);
    Map<String, dynamic> body = {
      "username": emailController.text.trim(),
      "password": passwordController.text.trim(),
      "isCustomerLogin": true
    };
    context.read<SigninCubit>().login(body);
  }
}
