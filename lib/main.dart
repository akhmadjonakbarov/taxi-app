import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'controller/cubits/service/services_cubit.dart';
import 'controller/cubits/user/user_cubit.dart';

import 'views/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: ServicesCubit(),
        ),
        BlocProvider.value(
          value: UserCubit(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Yo'lo'vchi",
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return Scaffold(
                body: Center(
                  child: Container(
                      decoration: const BoxDecoration(),
                      child: const CircularProgressIndicator()),
                ),
              );
            } else if (state is UserLogin) {
              return const HomeScreen();
            } else if (state is UserError) {
              return Scaffold(
                body: Center(
                  child: Text(state.errorMsg.toString()),
                ),
              );
            } else {
              return LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
