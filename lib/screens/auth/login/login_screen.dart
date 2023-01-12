import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kirish",
                style: GoogleFonts.nunito(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Iltimos davom etish uchun tizimga kiring",
                style: GoogleFonts.nunito(fontSize: 18),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Telefon raqam",
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
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
                ),
                const SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    decoration: const BoxDecoration(),
                    width: 135,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Kirish".toUpperCase(),
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
