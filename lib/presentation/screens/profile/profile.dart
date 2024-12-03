import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/logic/cubit/signin_cubit.dart';

import '../../../data/router_names.dart';
import '../../../logic/utility.dart';

class ProfileScreen extends StatelessWidget {
  // Mock user data
  final String userName = "John Doe";
  final String userEmail = "johndoe@example.com";
  final String userPhone = "123-456-7890";

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    "https://www.w3schools.com/w3images/avatar2.png"),
              ),
              const SizedBox(height: 20),
              Text(
                userName,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                userEmail,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Text(
                userPhone,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              BlocListener<SigninCubit, SigninState>(
                listener: (context, state) {
                if (state is SigninStateLogoutLoading) {
                  Utils.loadingDialog(context);
                } else {
                  Utils.closeDialog(context);
                  if (state is SigninStateLogoutError) {
                    Utils.errorSnackBar(context, state.error.message);
                  } else if (state is SigninStateLogOut) {
                    Navigator.pop(context);
                    Navigator.pushNamedAndRemoveUntil(context,
                        RouteNames.signinScreen, (route) => false);
                    Utils.showSnackBar(context, state.msg);
                  }
                }
                },
                child: ListTile(
                  contentPadding: const EdgeInsets.all(15),
                  leading: const Icon(Icons.exit_to_app, color: Colors.red),
                  title: const Text("Logout",
                      style: TextStyle(color: Colors.red, fontSize: 18)),
                  onTap: () {
                    // Implement logout functionality here
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Logout'),
                          content:
                              const Text('Are you sure you want to log out?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                context.read<SigninCubit>().logOut();
                                // Perform logout action here
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Logged out successfully")),
                                );
                              },
                              child: const Text('Logout'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
