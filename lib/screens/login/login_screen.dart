import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/constants/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // List of items in our dropdown menu
  String? dropDownValue;

  var items = [
    "Haydovchi",
    "Yo'lovchi",
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return Scaffold(
      body: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Container(
                  margin: const EdgeInsets.only(top: 90),
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(border: Border.all()),
                  alignment: Alignment.center,
                  child: Text(
                    "PoputiUz",
                    style: GoogleFonts.nunito(fontSize: 56),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: yellowOpancity,
                ),
                dropdownColor: yellowOpancity,
                value: dropDownValue,
                isExpanded: true,
                hint: const Text("Tanlang"),
                items: items.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Text(
                        e,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (selectedType) {
                  setState(() {
                    dropDownValue = selectedType!;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: yellowColor,
                  ),
                  onPressed: () {},
                  child: Text(
                    "Davom etish".toUpperCase(),
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
