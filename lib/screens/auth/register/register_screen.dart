import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
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
                    hintText: "Ism",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Familya",
                    border: OutlineInputBorder(),
                  ),
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
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Parolni tasqidlash",
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
                    width: 255,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(),
                        onPressed: () {},
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
