import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/features/job_managment/presentation/bloc/jobmanagment_bloc.dart';
import 'package:asood/features/job_managment/presentation/screen/cat_tab.dart';
import 'package:asood/features/job_managment/presentation/screen/group_tab.dart';
import 'package:asood/features/job_managment/presentation/screen/sub_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/helper/secure_storage.dart';
import 'package:asood/core/helper/snack_bar_util.dart';
import 'package:asood/core/widgets/appbar/default_appbar.dart';

class JobManagementScreen extends StatefulWidget {
  const JobManagementScreen({super.key});

  @override
  State<JobManagementScreen> createState() => _JobManagementScreenState();
}

class _JobManagementScreenState extends State<JobManagementScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int _activeTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(_onTabChanged);
  }

  void _onTabChanged() {
    final newIndex = _tabController.index;
    if (newIndex != _activeTabIndex) {
      _activeTabIndex = newIndex;
      context.read<JobmanagmentBloc>().add(
        ChangeTabView(activeTabIndex: newIndex),
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<JobmanagmentBloc>();

    return Container(
      color: Colora.primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: BlocConsumer<JobmanagmentBloc, JobmanagmentState>(
            listener: (context, state) {
              if (_tabController.index != state.activeTabIndex) {
                _tabController.index = state.activeTabIndex;
              }

              if (state.status == CWSStatus.failure) {
                showSnackBar(context, "مشکلی پیش آمده مجددا تلاش کنید");
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        // Appbar Space
                        const SizedBox(height: 80),
                        _buildTabBar(state),
                        SizedBox(
                          height: Dimensions.height * 0.795,
                          child: TabBarView(
                            controller: _tabController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              GroupTab(bloc: bloc),
                              CatTab(bloc: bloc),
                              SubTab(bloc: bloc),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const NewAppBar(title: "مدیریت مشاغل"),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar(JobmanagmentState state) {
    return IgnorePointer(
      ignoring: true,
      child: TabBar(
        controller: _tabController,
        indicatorColor: Colors.transparent,
        tabs: [
          _buildTab(state, "تعریف گروه", 0),
          _buildTab(state, "تعریف دسته", 1),
          _buildTab(state, "تعریف زیردسته", 2),
        ],
      ),
    );
  }

  Widget _buildTab(JobmanagmentState state, String label, int index) {
    final isActive = state.activeTabIndex == index;
    final tabColor = isActive ? Colora.primaryColor : Colors.white;
    final textColor = isActive ? Colors.white : Colora.primaryColor;

    return Container(
      width: Dimensions.width * 0.3,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: tabColor,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colora.primaryColor, width: 2),
      ),
      child: Center(
        child: FittedBox(
          child: Text(label, style: TextStyle(color: textColor)),
        ),
      ),
    );
  }
}
