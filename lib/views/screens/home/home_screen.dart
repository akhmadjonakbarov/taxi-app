import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../pages/pages.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = "/home-screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  static List<Tab> tabs = <Tab>[
    Tab(
      child: Column(
        children: [
          const Icon(Icons.search),
          Text(
            "E'lonlar",
            style: GoogleFonts.nunito(),
          ),
        ],
      ),
    ),
    Tab(
      child: Column(
        children: [
          const Icon(Icons.add_circle_outline),
          Text(
            "E'lon berish",
            style: GoogleFonts.nunito(),
          ),
        ],
      ),
    ),
    Tab(
      child: Column(
        children: [
          const Icon(Icons.person_outline),
          Text(
            "Profilim",
            style: GoogleFonts.nunito(),
          ),
        ],
      ),
    ),
  ];

  late TabController _tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(),
          child: TabBarView(
            viewportFraction: 1,
            controller: _tabController,
            children: const [
              ServicePage(),
              AddAdvPage(),
              ManagePage(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 0.5,
            color: Theme.of(context).primaryColor,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: TabBar(
          indicatorColor: Colors.transparent,
          labelColor: Theme.of(context).primaryColor,
          splashBorderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          unselectedLabelColor: Colors.grey,
          labelStyle: GoogleFonts.nunito(fontSize: 16),
          unselectedLabelStyle: GoogleFonts.nunito(fontSize: 14),
          controller: _tabController,
          tabs: tabs,
        ),
      ),
    );
  }
}
