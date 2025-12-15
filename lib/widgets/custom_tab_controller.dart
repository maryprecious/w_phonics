import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({super.key, required this.tabController});

  final TabController tabController;

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
          image: AssetImage("assets/images/curve_rect.png"),
          fit: BoxFit.fitWidth,
        ),
      ),
      height: 120,
      child: TabBar(
        controller: widget.tabController,
        dividerHeight: 0,
        indicatorColor: Colors.transparent,
        tabs: [
          _buildBottomNavItem(index: 0, activeColor: Colors.amber.shade900, icon: Icons.book ),
          _buildBottomNavItem(index: 1, activeColor: Colors.green.shade900, icon: Icons.list),
          _buildBottomNavItem(index: 2, activeColor: Colors.purple.shade900, icon: Icons.notes),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem({
    required int index,
    required Color activeColor,
    required IconData icon,
  }) {
    return Container(
      height: 55,
      width: 55,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: widget.tabController.index == index ? activeColor : Colors.white,
      ),
      child: Tab(
        icon: Icon(
          icon,
          size: 45,
          color: widget.tabController.index == index
              ? Colors.white
              : activeColor,
        ),
      ),
    );
  }
}
