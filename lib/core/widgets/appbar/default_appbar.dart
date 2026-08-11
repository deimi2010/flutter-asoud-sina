import 'package:asood/core/constants/constants.dart';
import 'package:asood/core/widgets/appbar/menu_dialog.dart';
import 'package:flutter/material.dart';

import 'profile_menu_widget.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  const DefaultAppBar({super.key, this.title});

  @override
  Size get preferredSize => const Size.fromHeight(90);

  @override
  Widget build(BuildContext context) {
    final bool isHome = title == 'home';

    return AppBar(
      toolbarHeight: preferredSize.height,
      centerTitle: true,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            isHome
                ? const [
                  Text(
                    'آســود',
                    style: TextStyle(
                      color: Colora.scaffold,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'خیالی آسوده با آسود',
                    style: TextStyle(
                      color: Colora.scaffold,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]
                : [
                  Text(
                    title ?? '',
                    style: const TextStyle(
                      color: Colora.scaffold,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
      ),
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          icon: Icon(
            Icons.menu_rounded,
            color: Colora.scaffold,
            size: Dimensions.width * 0.07,
          ),
          onPressed: () => showProfileDialog(context),
        ),
      ],
      leading: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Dimensions.height * 0.01,
          horizontal: Dimensions.width * 0.02,
        ),
        child:
            isHome
                ? InkWell(
                  onTap:
                      () => showDialog(
                        context: context,
                        builder: (_) => const MenuDialog(),
                      ),
                  child: CircleAvatar(
                    backgroundImage: Assets.images.placeholder.provider(),
                  ),
                )
                : IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colora.scaffold,
                    size: Dimensions.width * 0.07,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
      ),
      flexibleSpace: _buildFlexibleBackground(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
    );
  }

  Widget _buildFlexibleBackground() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          const Image(
            image: AssetImage('assets/images/home_app_bar.png'),
            fit: BoxFit.fill,
          ),
          Container(
            color: const Color.fromARGB(255, 0, 4, 253).withValues(alpha: 0.5),
          ),
        ],
      ),
    );
  }
}

class NewAppBar extends StatelessWidget {
  final String title;

  const NewAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final bool isHome = title == 'home';

    return Container(
      height: Dimensions.height * 0.11,
      width: Dimensions.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Stack(
        children: [
          _buildBackground(),
          _buildOverlay(),
          _buildLeading(context, isHome),
          _buildMenuButton(context),
          _buildTitle(isHome),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      height: Dimensions.height * 0.1,
      width: Dimensions.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/home_app_bar.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
    );
  }

  Widget _buildOverlay() {
    return Container(
      height: Dimensions.height * 0.1,
      width: Dimensions.width,
      decoration: BoxDecoration(
        color: Colora.primaryColor.withValues(alpha: 0.6),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
    );
  }

  Widget _buildLeading(BuildContext context, bool isHome) {
    return Positioned(
      top: Dimensions.height * 0.02,
      right: 10,
      child: SizedBox(
        width: Dimensions.width * 0.1,
        child:
            isHome
                ? InkWell(
                  // deleted by Sina, mybe in future it should go to profile page.
                  // onTap:
                  // () => showDialog(
                  //   context: context,
                  //   builder: (_) => const MenuDialog(),
                  // ),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colora.scaffold, width: 2),
                        image: DecorationImage(
                          image: Assets.images.placeholder.provider(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                )
                : IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colora.scaffold,
                    size: Dimensions.width * 0.07,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context) {
    return Positioned(
      top: Dimensions.height * 0.02,
      left: 10,
      width: Dimensions.width * 0.1,
      child: IconButton(
        icon: Icon(
          Icons.menu_rounded,
          color: Colora.scaffold,
          size: Dimensions.width * 0.07,
        ),
        onPressed: () => showProfileDialog(context),
      ),
    );
  }

  Widget _buildTitle(bool isHome) {
    return Positioned(
      right: Dimensions.width * 0.25,
      left: Dimensions.width * 0.25,
      child: SizedBox(
        width: Dimensions.width * 0.5,
        height: Dimensions.height * 0.11,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              isHome
                  ? [
                    FittedBox(
                      fit: BoxFit.scaleDown,

                      // child: Text(
                      //   'آســود',
                      //   style: TextStyle(
                      //     color: Colora.scaffold,
                      //     fontSize: Dimensions.width * 0.065,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      child: Assets.images.asood.image(
                        fit: BoxFit.scaleDown,
                        width: Dimensions.width * 0.15,
                        color: Colors.white,
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'خیالی آسوده با آسود',
                        style: TextStyle(
                          color: Colora.scaffold,
                          fontSize: Dimensions.width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ]
                  : [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colora.scaffold,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
        ),
      ),
    );
  }
}
