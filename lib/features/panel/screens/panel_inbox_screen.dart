import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/widgets/appbar/default_appbar.dart';

import 'package:asood/core/widgets/search_box.dart';
import 'package:asood/core/widgets/simple_bot_navbar.dart';
import 'package:asood/features/panel/widgets/message_card.dart';

import 'package:flutter/material.dart';

class PanelInboxScreen extends StatelessWidget {
  const PanelInboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colora.primaryColor,
      child: SafeArea(
        child: Scaffold(
          // appBar: DefaultAppBar(context: context, title: 'لیست پیامک‌ها',),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    //for appbar
                    SizedBox(height: Dimensions.height * 0.12),

                    ListView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder:
                          (context, index) =>
                              (index != 9)
                                  ? const MessageCardWidget()
                                  : const SimpleBotNavBar(),
                    ),
                  ],
                ),
              ),

              const NewAppBar(title: 'لیست پیامک‌ها'),
            ],
          ),
          // bottomNavigationBar: const SimpleBotNavBar(),
        ),
      ),
    );
  }
}

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: SearchBoxWidget()),
        SliverList(
          delegate: SliverChildBuilderDelegate((
            BuildContext context,
            int index,
          ) {
            const int itemCount = 10;
            if (index < itemCount) {
              return const MessageCardWidget();
            }
            return null;
          }, childCount: 10),
        ),
      ],
    );
  }
}
