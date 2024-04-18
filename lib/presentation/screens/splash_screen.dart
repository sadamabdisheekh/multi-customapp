import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/constants/app_constants.dart';
import 'package:multi/constants/images.dart';
import 'package:multi/data/router_names.dart';
import 'package:multi/logic/cubit/location_cubit.dart';
import 'package:multi/logic/utility.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Timer(
    //    const Duration(seconds: 3),
    //         () => Navigator.pushNamed(context, RouteNames.signinScreen),);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationCubit, LocationState>(
      listener: (context, state) {
        if (state is LocationError) {
          AppSettings.openAppSettings(type: AppSettingsType.location);
          Utils.showSnackBar(context, state.message);
        }
         if (state is LocationLoaded) {
          Navigator.pushNamed(context, RouteNames.signinScreen);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xffE07A5F),
        body: Stack(
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
                    height: 80,
                    width: 80,
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
        ),
      ),
    );
  }
}
