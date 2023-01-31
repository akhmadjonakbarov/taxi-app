import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/cubits/user/user_cubit.dart';
import '../../../models/user.dart';
import '../../screens/screens.dart';

class ManagePage extends StatelessWidget {
  const ManagePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLogout) {
          return const LoginScreen();
        } else if (state is UserError) {
          return const Scaffold(
            body: Center(
              child: Text(
                "Sizda xatolik bor iltimos keyinroq urunib ko'ring.",
              ),
            ),
          );
        } else {
          return const ProfilePage();
        }
      },
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    User user = BlocProvider.of<UserCubit>(context).user;
    return Container(
      decoration: const BoxDecoration(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                Text("${user.firstName} ${user.lastName}",
                    style: GoogleFonts.nunito(fontSize: 25)),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.only(left: 24, right: 24),
              alignment: Alignment.centerLeft,
              width: double.infinity,
              height: 40,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Text(
                "Mening ma'lumotlarimni tahrirlash",
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                UserServicesScreen.routeNames,
              );
            },
            child: Container(
              padding: const EdgeInsets.only(left: 24, right: 24),
              alignment: Alignment.centerLeft,
              width: double.infinity,
              height: 40,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Text(
                "Mening e'lonlarim",
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
            child: const Divider(),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
            ),
            child: Text(
              "Mashina",
              style: GoogleFonts.nunito(
                fontSize: 25,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.only(left: 24, right: 24),
              alignment: Alignment.centerLeft,
              width: double.infinity,
              height: 40,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Text(
                "Mening mashinam",
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
            child: const Divider(),
          ),
          InkWell(
            onTap: () {
              BlocProvider.of<UserCubit>(context).userLogOut();
            },
            child: Container(
              padding: const EdgeInsets.only(left: 24, right: 24),
              alignment: Alignment.centerLeft,
              width: double.infinity,
              height: 40,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Row(
                children: [
                  Text(
                    "Chiqish",
                    style: GoogleFonts.nunito(
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    CupertinoIcons.arrow_right,
                    color: Colors.indigo,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
