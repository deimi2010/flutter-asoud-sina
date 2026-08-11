import 'package:asood/core/widgets/appbar/default_appbar.dart';
import 'package:flutter/material.dart';

import 'package:asood/core/constants/constants.dart';

import 'pages/basic_info.dart';
import 'pages/contacts_info.dart';
import 'pages/location_info.dart';

class EditStoreInfoScreen extends StatefulWidget {
  const EditStoreInfoScreen({super.key});

  @override
  State<EditStoreInfoScreen> createState() => _EditStoreInfoScreenState();
}

class _EditStoreInfoScreenState extends State<EditStoreInfoScreen>
    with SingleTickerProviderStateMixin {
  bool switchValue = false;
  late TabController _tabController;
  late int _activeTabIndex; // To keep track of the active tab
  bool isMenuVisible = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChanged);
    _activeTabIndex = _tabController.index; // Set initial active tab index
  }

  void _onTabChanged() {
    setState(() {
      _activeTabIndex = _tabController.index; // Update the active tab index
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(),
      body: SafeArea(
        child: Container(
          height: Dimensions.height,
          width: Dimensions.width,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: null,
                  indicatorColor: Colors.transparent, // Remove indicator color
                  tabs: [
                    buildTab('مشخصات پایه', 0),
                    buildTab('مشخصات ارتباطی', 1),
                    buildTab('مشخصات مکانی', 2),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: Dimensions.height * .76,
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      BasicInfo(),
                      ContactsInfo(),
                      LocationInfo(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTab(String label, int tabIndex) {
    bool isActive = _activeTabIndex == tabIndex; // Check if tab is active

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      // margin: EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
        color:
            isActive
                ? Colors.white
                : Colors.purple, // White when active, purple otherwise
        borderRadius: BorderRadius.circular(50), // Border radius for each tab
        border:
            isActive
                ? Border.all(color: Colors.purple) // Purple border when active
                : null, // No border otherwise
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(color: isActive ? Colors.black : Colors.white),
        ),
      ),
    );
  }
}
