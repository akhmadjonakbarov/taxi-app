import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:taxi_app/controller/cubits/service/services_cubit.dart';
import 'package:taxi_app/controller/cubits/user/user_cubit.dart';
import 'package:taxi_app/models/models.dart';

class AddAdvPage extends StatefulWidget {
  const AddAdvPage({super.key});

  @override
  State<AddAdvPage> createState() => _AddAdvPageState();
}

class _AddAdvPageState extends State<AddAdvPage> {
  DateTime selectedDate = DateTime.now();
  bool dateIsSelected = false;
  final _addAdvKey = GlobalKey<FormState>();

  late String from_where;
  late String to_where;
  late double service_price;
  // late DateTime se;
  late String phone_number;
  late String accessToken;

  @override
  void didChangeDependencies() {
    accessToken = BlocProvider.of<UserCubit>(context).user.token;
    super.didChangeDependencies();
  }

  void _submit() {
    bool isValid = _addAdvKey.currentState!.validate();
    if (isValid) {
      _addAdvKey.currentState!.save();
      BlocProvider.of<ServicesCubit>(context).add(
          accessToken: accessToken,
          from_where: from_where,
          to_where: to_where,
          service_price: service_price,
          leaving_time: selectedDate,
          phone_number: phone_number);
    }
  }

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
          Form(
            key: _addAdvKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Qayerdan",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (inputFromWhere) {
                    from_where = inputFromWhere;
                  },
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Qayerga",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (inputToWhere) {
                    to_where = inputToWhere;
                  },
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Hizmat narxini kiriting",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (inputServicePrice) {
                    service_price = double.parse(inputServicePrice);
                  },
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Ketish vaqti:",
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime(DateTime.now().year,
                                DateTime.now().month, DateTime.now().day),
                            firstDate: DateTime(2022, 12),
                            lastDate: DateTime(2030, 12));
                        if (picked != null && picked != selectedDate) {
                          setState(() {
                            selectedDate = picked;
                            dateIsSelected = true;
                          });
                        }
                      },
                      child: Text(
                        dateIsSelected != false
                            ? DateFormat("d.MM.y").format(selectedDate)
                            : "Vaqtni tanlash",
                        style: GoogleFonts.nunito(fontSize: 18),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Telefon raqam",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (inputPhoneNumber) {
                    phone_number = inputPhoneNumber;
                  },
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    _submit();
                  },
                  child: Text(
                    "E'lon joylashtirish",
                    style: GoogleFonts.nunito(fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
