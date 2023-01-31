import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/controller/cubits/user/user_cubit.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  static const routeName = "/register-screen";
  final _registerKey = GlobalKey<FormState>();

  late String name;
  late String phoneNumber;
  late String password;
  late String password2;

  void _submit(BuildContext context) {
    bool isValid = _registerKey.currentState!.validate();
    if (isValid) {
      BlocProvider.of<UserCubit>(context).userRegister(
        name: name,
        password: password,
        phoneNumber: phoneNumber,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ro'yhatdan o'tish",
                      style: GoogleFonts.nunito(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _registerKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: "To'liq ismingizni kiriting",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Telefon raqam",
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Parol",
                        prefixIcon: Icon(Icons.lock_outline),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Parolni tasqidlash",
                        prefixIcon: Icon(Icons.lock_outline),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        password2 = value;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        decoration: const BoxDecoration(),
                        width: 255,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(),
                            onPressed: () {
                              _submit(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Ro'yhatdan o'tish".toUpperCase(),
                                  style: GoogleFonts.nunito(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                                const Icon(
                                  CupertinoIcons.arrow_right,
                                  color: Colors.white,
                                )
                              ],
                            )),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
