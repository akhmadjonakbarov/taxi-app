import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../controller/cubits/user/user_cubit.dart';

import '../../../../models/models.dart';

class ServiceItem extends StatelessWidget {
  const ServiceItem({
    Key? key,
    required this.service,
  }) : super(key: key);

  final Service service;

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<UserCubit>(context).user;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    service.fromWhere.trim(),
                    style: GoogleFonts.nunito(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      CupertinoIcons.arrow_right,
                    ),
                  ),
                  Text(
                    service.toWhere,
                    style: GoogleFonts.nunito(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              if (user.id == service.usedId)
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(16)),
                    child: const Icon(
                      Icons.edit,
                      size: 18,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Ketish vaqti: ${DateFormat("d.MM.y").format(
              DateTime.parse(service.leavingTime),
            )}",
            style: GoogleFonts.nunito(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    user.id == service.usedId ? "Siz" : service.firstName,
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              Text(
                "60 000 so'm",
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
