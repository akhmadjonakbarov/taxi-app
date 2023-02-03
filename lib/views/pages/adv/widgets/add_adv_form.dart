import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../models/service.dart';

import '../../../../controller/cubits/service/services_cubit.dart';
import '../../../../controller/cubits/user/user_cubit.dart';
import '../../../../models/user.dart';

class AddAdvForm extends StatefulWidget {
  final int? serviceId;
  const AddAdvForm({super.key, this.serviceId});

  @override
  State<AddAdvForm> createState() => _AddAdvFormState();
}

class _AddAdvFormState extends State<AddAdvForm> {
  bool dateIsSelected = false;
  final _addAdvKey = GlobalKey<FormState>();

  late String from_where;
  late String to_where;
  late double service_price;
  DateTime selectedDate = DateTime.now();
  late DateTime updatedTime;
  late String phone_number;
  late User user;
  Service? service;

  @override
  void initState() {
    super.initState();
    user = BlocProvider.of<UserCubit>(context).user;
    if (widget.serviceId != null) {
      BlocProvider.of<ServicesCubit>(context)
          .getService(serviceId: widget.serviceId!)
          .then((Service resService) {
        setState(() {
          service = resService;
        });
      });
    }
  }

  void _submit() {
    bool isValid = _addAdvKey.currentState!.validate();

    _addAdvKey.currentState!.save();

    if (isValid) {
      if (service != null) {
        BlocProvider.of<ServicesCubit>(context).updated(
          accessToken: user.token,
          id: service!.id,
          from_where: from_where,
          to_where: to_where,
          service_price: service_price,
          leaving_time: selectedDate,
          phone_number: phone_number,
          user: user,
        );
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Sizning e'loningiz o'zgartirildi!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
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
      } else {
        BlocProvider.of<ServicesCubit>(context).add(
          accessToken: user.token,
          from_where: from_where,
          to_where: to_where,
          service_price: service_price,
          leaving_time: selectedDate,
          phone_number: phone_number,
          user: user,
        );
      }
      _addAdvKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _addAdvKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            initialValue: service != null ? service!.fromWhere : null,
            decoration: const InputDecoration(
              hintText: "Qayerdan",
              border: OutlineInputBorder(),
            ),
            onSaved: (inputFromWhere) {
              setState(() {
                from_where = inputFromWhere!;
              });
            },
            keyboardType: TextInputType.text,
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            initialValue: service != null ? service!.toWhere : null,
            decoration: const InputDecoration(
              hintText: "Qayerga",
              border: OutlineInputBorder(),
            ),
            onSaved: (inputToWhere) {
              setState(() {
                to_where = inputToWhere!;
              });
            },
            keyboardType: TextInputType.text,
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            initialValue:
                service != null ? service!.servicePrice.toString() : null,
            decoration: const InputDecoration(
              hintText: "Hizmat narxini kiriting",
              border: OutlineInputBorder(),
            ),
            onSaved: (inputServicePrice) {
              setState(() {
                service_price = double.parse(inputServicePrice!);
              });
            },
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 5,
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
                  DateFormat("d.MM.y").format(
                    selectedDate,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            initialValue: service != null ? service!.phoneNumber : null,
            decoration: const InputDecoration(
              hintText: "Telefon raqam",
              border: OutlineInputBorder(),
            ),
            onSaved: (inputPhoneNumber) {
              setState(() {
                phone_number = inputPhoneNumber!;
              });
            },
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 5,
          ),
          ElevatedButton(
            onPressed: () {
              _submit();
            },
            child: Text(
              service != null ? "E'lon yangilash" : "E'lon joylashtirish",
              style: GoogleFonts.nunito(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
