import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../controller/cubits/service/services_cubit.dart';
import '../../../models/models.dart';
import 'widgets/widgets.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: BlocListener<ServicesCubit, ServicesState>(
              listener: (context, state) {
                if (state is ServicesLoaded) {
                  if (state.services.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Bu so'ro'v bo'yicha e'lonlar topilmadi.\nIltimos qaytadan urunib ko'ring,",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.nunito(
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<ServicesCubit>(context)
                                      .clearService();
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Qayta urunish",
                                  style: GoogleFonts.nunito(
                                    fontSize: 18,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }
                }
              },
              child: BlocBuilder<ServicesCubit, ServicesState>(
                builder: (context, state) {
                  if (state is ServicesLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is ServicesLoaded) {
                    if (state.services.isNotEmpty) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                splashRadius: 18,
                                onPressed: () {
                                  BlocProvider.of<ServicesCubit>(context)
                                      .clearService();
                                },
                                icon: const Icon(
                                  CupertinoIcons.back,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              itemCount: state.services.length,
                              itemBuilder: (context, index) {
                                Service service = state.services[index];
                                return ServiceItem(service: service);
                              },
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const _ServiceFilterForm();
                    }
                  } else if (state is ServicesError) {
                    return Center(
                        child: Container(
                      decoration: const BoxDecoration(),
                      child: Text(state.errorMessage),
                    ));
                  } else {
                    return const _ServiceFilterForm();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceFilterForm extends StatefulWidget {
  const _ServiceFilterForm();

  @override
  State<_ServiceFilterForm> createState() => _ServiceFilterFormState();
}

class _ServiceFilterFormState extends State<_ServiceFilterForm> {
  void _search() {
    bool isValid = _searchServiceKey.currentState!.validate();
    if (isValid) {
      _searchServiceKey.currentState!.save();
      BlocProvider.of<ServicesCubit>(context).filterService(
        fromWhere: fromWhere,
        toWhere: toWhere,
        dateTime: selectedDate,
      );
      dateIsSelected = false;
    }
  }

  final _searchServiceKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();

  bool dateIsSelected = false;

  late String fromWhere;

  late String toWhere;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 210),
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).primaryColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: _searchServiceKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Qayerdan",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (inputFromWhere) {
                      fromWhere = inputFromWhere;
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Qayerga",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (inputToWhere) {
                      toWhere = inputToWhere;
                    },
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
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _search();
              },
              child: const Text(
                "Qidirish",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
