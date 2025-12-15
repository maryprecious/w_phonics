import 'package:flutter/material.dart';
import 'package:w_phonics/pages/lessons_page.dart';
import 'package:w_phonics/pages/profile_page.dart';
import 'package:w_phonics/pages/pupils_page.dart';
import 'package:w_phonics/widgets/custom_tab_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: [LessonsPage(), ProfilePage(), PupilsPage()],
      ),
      bottomNavigationBar: CustomBottomNavigation(tabController: tabController,),
    );
  }
}
