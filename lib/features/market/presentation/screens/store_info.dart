import 'package:asood/core/widgets/appbar/default_appbar.dart';

import 'package:asood/core/widgets/search_box.dart';
import 'package:asood/core/widgets/simple_bot_navbar.dart';
import 'package:asood/core/widgets/store_card.dart';
import 'package:asood/features/vendor/presentation/bloc/workspace/workspace_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreInfoScreen extends StatelessWidget {
  const StoreInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SearchBoxWidget()),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return StoreCard(
                  index: index,
                  market:
                      BlocProvider.of<WorkspaceBloc>(
                        context,
                      ).state.storesList[index],
                  bloc: BlocProvider.of<WorkspaceBloc>(context),
                );
              },
              childCount:
                  BlocProvider.of<WorkspaceBloc>(
                    context,
                  ).state.storesList.length,
            ),
          ),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: const SimpleBotNavBar(),
    );
  }
}
