import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/constants/app_constants.dart';
import 'package:multi/constants/images.dart';
import 'package:multi/data/router_names.dart';
import 'package:multi/logic/cubit/signin_cubit.dart';
import 'package:multi/logic/cubit/splash_cubit.dart';
import 'package:multi/logic/utilits/utility.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final userLogin = context.read<SigninCubit>();
    return Scaffold(
      backgroundColor: const Color(0xffE07A5F),
      body: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashLoading) {
             Utils.loadingDialog(context);
          }
          if (state is SplashError) {
            Utils.showSnackBar(context, state.error);
          }
          if (state is SplashLoaded) {
            if (userLogin.isLogedIn) {
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteNames.mainPage, (route) => false);
            } else {
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteNames.signinScreen, (route) => false);
            }
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color(0xffE07A5F),
                      Color(0xffF25328),
                    ])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Image.asset("assets/images/Frame 3.png")],
                ),
              ),
              Positioned(
                  child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      Kimages.logo,
                      height: 150,
                      width: 150,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      AppConstants.appName,
                      style: TextStyle(
                          color: Color(0xffFFFFFF),
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          fontFamily: "Nunito Sans"),
                    )
                  ],
                ),
              ))
            ],
          );
        },
      ),
    );
  }
}
