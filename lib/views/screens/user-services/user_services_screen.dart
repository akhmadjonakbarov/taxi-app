import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/cubits/service/services_cubit.dart';

import '../../../controller/cubits/user/user_cubit.dart';
import '../../../models/models.dart';
import '../../pages/service/widgets/widgets.dart';

class UserServicesScreen extends StatefulWidget {
  const UserServicesScreen({super.key});
  static const routeNames = "/user-services-screen";

  @override
  State<UserServicesScreen> createState() => _UserServicesScreenState();
}

class _UserServicesScreenState extends State<UserServicesScreen> {
  late User user;

  @override
  void didChangeDependencies() {
    user = BlocProvider.of<UserCubit>(context).user;

    BlocProvider.of<ServicesCubit>(context)
        .filteredUserServices(userId: user.id);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  splashRadius: 18,
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    CupertinoIcons.back,
                  ),
                )
              ],
            ),
            BlocListener<ServicesCubit, ServicesState>(
              listener: (context, state) {
                if (state is ServicesError) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              state.errorMessage.toString(),
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
                } else if (state is ServicesAdded) {
                  BlocProvider.of<ServicesCubit>(context)
                      .filteredUserServices(userId: user.id);
                }
              },
              child: BlocBuilder<ServicesCubit, ServicesState>(
                builder: (context, state) {
                  if (state is FilteresUserServices) {
                    if (state.services.isNotEmpty) {
                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          itemCount: state.services.length,
                          itemBuilder: (context, index) {
                            Service userService = state.services[index];
                            return ServiceItem(
                              service: userService,
                            );
                          },
                        ),
                      );
                    } else {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height / 2.5),
                        child: Text(
                          "Sizda e'lonlar mavjud emas!",
                          style: GoogleFonts.nunito(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }
                  } else {
                    return Container(
                      margin: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height / 2.5),
                      child: const CircularProgressIndicator(),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
