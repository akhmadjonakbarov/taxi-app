import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
      ),
    );
    return Container(
      decoration: const BoxDecoration(),
      child: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Arizalar",
                    style: GoogleFonts.nunito(
                      fontSize: 25,
                    ),
                  ),
                  IconButton(
                    splashRadius: 18,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_none_outlined,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: const [],
            ),
          ),
        ],
      ),
    );
  }
}
