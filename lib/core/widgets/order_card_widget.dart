import 'package:asood/features/vendor/presentation/bloc/workspace/workspace_bloc.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'custom_button.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({super.key, required this.index, this.bloc});

  final int index;
  final WorkspaceBloc? bloc;

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool isOrderMenuVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isOrderMenuVisible = !isOrderMenuVisible;
              });
            },
            child: Container(
              // height: 110,
              width: Dimensions.width,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(20),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft:
                      !isOrderMenuVisible
                          ? const Radius.circular(20)
                          : Radius.zero,
                  bottomRight:
                      !isOrderMenuVisible
                          ? const Radius.circular(20)
                          : Radius.zero,
                ),
                color: Colora.primaryColor, // Change this to your primary color
              ),
              // margin: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "درخواست شماره ۳۷ - نقدی",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: Dimensions.width * 0.9,
                    child: const Divider(thickness: 1),
                  ),
                  SizedBox(
                    width: Dimensions.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "نام مشتری: محمدرضا محمدی",
                          style: ATextStyle.light12.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "همراه: ۰۹۱۲۳۴۵۶۷۸۹",
                          style: ATextStyle.light12.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: Dimensions.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "وضعیت: تایید نهایی",
                          style: ATextStyle.light12.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "تاریخ: ۱۴۰۲/۱۲/۱۳ - ۱۳:۳۰",
                          style: ATextStyle.light12.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: Dimensions.width * 0.4,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        'مبلغ: ۲۰۰،۰۰۰ ریال',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          if (isOrderMenuVisible)
            OrderCardMenu(
              isOrderMenuVisible: isOrderMenuVisible,
              bloc: widget.bloc!,
            ),
        ],
      ),
    );
  }
}

class OrderCardMenu extends StatelessWidget {
  const OrderCardMenu({
    super.key,
    required this.isOrderMenuVisible,
    required this.bloc,
  });

  final bool isOrderMenuVisible;
  final WorkspaceBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(20),
        borderRadius: BorderRadius.only(
          bottomLeft: const Radius.circular(20),
          bottomRight: const Radius.circular(20),
          topLeft:
              !isOrderMenuVisible ? const Radius.circular(20) : Radius.zero,
          topRight:
              !isOrderMenuVisible ? const Radius.circular(20) : Radius.zero,
        ),
        color: Colora.primaryColor,
      ),
      child: Column(
        // Messages
        children: [
          const SizedBox(height: 10),
          const Text(
            "پرداخت سفارش یه صورت نقدی خواهد بود.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          const Text(
            "سفارش توسط مشتری تایید شده و خرید تکمیل گردید.\nتاریخ: ۱۴۰۲/۱۲/۱۳ - ۱۳:۳۰",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          const Text(
            "سفارش به رویت شما رسیده و در تدارک ارسال می‌باشد.\nتاریخ: ۱۴۰۲/۱۲/۱۳ - ۱۳:۳۰",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          const Text(
            "سفارش هنوز توسط شما تایید و ارسال نشده است.",
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.white,
              // alignment: TextAlign.right,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            // Buttons
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                onPress: () {
                  bloc.add(const ShowInvoice(isShow: true));
                },
                text: 'تایید پرداخت',
                width: 100,
                color: Colors.green,
              ),
              CustomButton(
                onPress: () {},
                text: 'تماس',
                width: 100,
                color: Colors.green,
              ),
              CustomButton(
                onPress: () {},
                text: 'پیگیری درخواست',
                width: 100,
                color: Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

// class OrderCardMenu extends StatelessWidget {
//   const OrderCardMenu({
//     super.key,
//     required this.context,
//   });

//   final BuildContext context;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 10),
//       padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               CustomButton(
//                   width: 110,
//                   onPress: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const StoreScreen(),
//                       ),
//                     );
//                   },
//                   text: "پیش نمایش"),
//               CustomButton(
//                   width: 110,
//                   onPress: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const EditStoreScreen(),
//                       ),
//                     );
//                   },
//                   text: "ویرایش"),
//               CustomButton(width: 110, onPress: () {}, text: "اشتراک گذاری"),
//               // Add more menu items as needed
//             ],
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               CustomButton(width: 110, onPress: () {}, text: "انتشار"),
//               CustomButton(width: 110, onPress: () {}, text: "پرداخت اشتراک"),
//               CustomButton(width: 110, onPress: () {}, text: "غیرفعال"),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CustomerOrderCard extends OrderCard {
//   const CustomerOrderCard({super.key, required int index});

// }
