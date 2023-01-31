import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/cubits/service/services_cubit.dart';
import 'widgets/widgets.dart';

class AddAdvPage extends StatefulWidget {
  const AddAdvPage({super.key});

  @override
  State<AddAdvPage> createState() => _AddAdvPageState();
}

class _AddAdvPageState extends State<AddAdvPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        left: 24,
        right: 24,
      ),
      decoration: const BoxDecoration(),
      child: Column(
        children: [
          Text(
            "E'lon berish",
            style: GoogleFonts.nunito(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: BlocListener<ServicesCubit, ServicesState>(
              listener: (context, state) {
                if (state is ServicesAdded) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Sizning e'loningiz qo'shildi.",
                              style: GoogleFonts.nunito(
                                fontSize: 20,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Ok"),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
              },
              child: const AddAdvForm(),
            ),
          )
        ],
      ),
    );
  }
}
