import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controller/cubits/service/services_cubit.dart';
import 'controller/cubits/user/user_cubit.dart';
import 'views/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider.value(
        value: ServicesCubit(),
      ),
      BlocProvider.value(
        value: UserCubit(),
      )
    ], child: const Wrapper());
  }
}

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(
        seconds: 3,
      ),
    ).then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return MaterialApp(
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Loading...",
                            style: GoogleFonts.nunito(fontSize: 25),
                          )
                        ],
                      ),
                    ),
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
                return const LoginScreen();
              }
            },
          ),
          routes: {
            HomeScreen.routeName: (context) => const HomeScreen(),
            UserServicesScreen.routeNames: (context) =>
                const UserServicesScreen(),
            LoginScreen.routeName: (context) => const LoginScreen(),
            RegisterScreen.routeName: (context) => RegisterScreen(),
          },
        );
      },
    );
  }
}
