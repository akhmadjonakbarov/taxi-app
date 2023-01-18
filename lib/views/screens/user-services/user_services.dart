import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../controller/cubits/user/user_cubit.dart';
import '../../../models/models.dart';
import '../../pages/service/widgets/widgets.dart';

class UserServices extends StatefulWidget {
  const UserServices({super.key});

  @override
  State<UserServices> createState() => _UserServicesState();
}

class _UserServicesState extends State<UserServices> {
  List<Service> userservices = [];
  late User user;

  @override
  void didChangeDependencies() {
    userservices = BlocProvider.of<UserCubit>(context).userServices;
    user = BlocProvider.of<UserCubit>(context).user;
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
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: userservices.length,
                itemBuilder: (context, index) {
                  Service userService = userservices[index];
                  return ServiceItem(
                    service: userService,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
