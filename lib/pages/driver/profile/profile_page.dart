import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/constants/app_colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var dropDownValue = "";
  List<String> cars = ["Cobalt", "Spark"];
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: SafeArea(
                    child: Text(
                      "Profile",
                      style: GoogleFonts.nunito(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: yellowOpancity,
                            hintText: "Ism",
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: yellowOpancity,
                                  hintText: "Yosh",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: yellowOpancity,
                                  hintText: "Tel raqam",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: yellowOpancity,
                                ),
                                dropdownColor: yellowOpancity,
                                value: dropDownValue,
                                isExpanded: true,
                                isDense: true,
                                hint: const Text("Tanlang"),
                                items: cars.map((e) {
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
                            SizedBox(
                              width: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: yellowOpancity,
                                  hintText: "Mashina",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(),
                                color: Colors.transparent),
                            width: MediaQuery.of(context).size.width * 0.50,
                            height: MediaQuery.of(context).size.height * 0.25,
                            alignment: Alignment.center,
                            child: Text(
                              "Upload",
                              style: GoogleFonts.nunito(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 24.0,
              right: 24,
              bottom: 24,
            ),
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: yellowColor,
                ),
                onPressed: () {},
                child: Text(
                  "Saqlash".toUpperCase(),
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
    );
  }
}
