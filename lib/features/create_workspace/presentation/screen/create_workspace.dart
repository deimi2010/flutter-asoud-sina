import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/helper/snack_bar_util.dart';
import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/core/widgets/appbar/default_appbar.dart';
import 'package:asood/features/create_workspace/presentation/bloc/create_workspace_bloc.dart';
import 'package:asood/features/create_workspace/presentation/screen/tab_screens/basic_info.dart';
import 'package:asood/features/create_workspace/presentation/screen/tab_screens/contacts_info.dart';
import 'package:asood/features/create_workspace/presentation/screen/tab_screens/location_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateWorkSpaceScreen extends StatefulWidget {
  const CreateWorkSpaceScreen({super.key});

  @override
  State<CreateWorkSpaceScreen> createState() => _CreateWorkSpaceScreenState();
}

class _CreateWorkSpaceScreenState extends State<CreateWorkSpaceScreen>
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
      context.read<CreateWorkSpaceBloc>().add(
        ChangeWorkspaceTabView(activeTabIndex: newIndex),
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// on back button if user presses to get pre tab
  void onBack(BuildContext context) {
    var bloc = context.read<CreateWorkSpaceBloc>();
    int index = bloc.state.activeTabIndex;
    if (index > 0) {
      bloc.add(ChangeWorkspaceTabView(activeTabIndex: index - 1));
    } else if (index == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        context.pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateWorkSpaceBloc>();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        onBack(context);
      },
      child: Container(
        color: Colora.primaryColor,
        child: SafeArea(
          child: Scaffold(
            body: BlocConsumer<CreateWorkSpaceBloc, CreateWorkSpaceState>(
              listener: (context, state) {
                if (_tabController.index != state.activeTabIndex) {
                  _tabController.index = state.activeTabIndex;
                }

                if (state.status == CWSStatus.failure) {
                  showSnackBar(context, "مشکلی پیش آمده مجددا تلاش کنید");
                }
              },
              builder: (context, state) {
                return NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      // AppBar ثابت
                      SliverToBoxAdapter(
                        child: const NewAppBar(title: 'ثبت دفتر کار'),
                      ),

                      SliverPersistentHeader(
                        pinned: true, // این باعث می‌شود تب‌ها ثابت بمانند
                        floating: false,
                        delegate: _StickyTabBarDelegate(
                          child: Container(
                            color: Colors.white, // پس‌زمینه سفید برای تب‌ها
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                _buildTabBar(state),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildScrollableTabContent(BasicInfo()),
                      _buildScrollableTabContent(ContactsInfo(bloc: bloc)),
                      _buildScrollableTabContent(LocationInfo(bloc: bloc)),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // تابع برای ساخت محتوای قابل اسکرول هر تب
  Widget _buildScrollableTabContent(Widget child) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: child,
    );
  }

  Widget _buildTabBar(CreateWorkSpaceState state) {
    return IgnorePointer(
      ignoring: true,
      child: TabBar(
        controller: _tabController,
        indicatorColor: Colors.transparent,
        indicator: const BoxDecoration(),
        dividerColor: Colors.transparent,
        tabs: [
          _buildTab(state, 'مشخصات پایه', 0),
          _buildTab(state, 'مشخصات ارتباطی', 1),
          _buildTab(state, 'مشخصات مکانی', 2),
        ],
      ),
    );
  }

  Widget _buildTab(CreateWorkSpaceState state, String label, int index) {
    final isActive = state.activeTabIndex == index;
    final tabColor = isActive ? Colora.primaryColor : Colors.white;
    final textColor = isActive ? Colors.white : Colora.primaryColor;

    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Container(
        height: Dimensions.height * 0.04,
        width: Dimensions.width * 1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: tabColor,
          border: Border.all(color: Colora.primaryColor, width: 2),
        ),
        child: Center(
          child: FittedBox(
            child: Text(
              label,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

// کلاس Delegate برای تب‌های Sticky
class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyTabBarDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 80; // ارتفاع تب‌ها + padding

  @override
  double get minExtent => 80; // ارتفاع تب‌ها + padding

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}