import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/views/screens/screens.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Column(
                children: [
                  Image.asset("assets/images/taxi-app.png"),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: const BoxDecoration(),
                    child: Text(
                      "TAXISERVICE",
                      style: GoogleFonts.nunito(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(RegisterScreen.routeName);
                    },
                    child: Text(
                      "Ro'yhatdan o'tish",
                      style: GoogleFonts.nunito(
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  height: 50,
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(LoginScreen.routeName);
                    },
                    child: Text(
                      "Kirish",
                      style: GoogleFonts.nunito(fontSize: 22),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
