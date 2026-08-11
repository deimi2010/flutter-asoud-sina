import 'package:asood/core/constants/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class DashboardCarouselWidget extends StatefulWidget {
  const DashboardCarouselWidget({super.key});

  @override
  State<DashboardCarouselWidget> createState() =>
      _DashboardCarouselWidgetState();
}

class _DashboardCarouselWidgetState extends State<DashboardCarouselWidget> {
  int currentSliderIndex = 0;
  int sliderLength = 5;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.33,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  currentSliderIndex = index;
                });
              },
              aspectRatio: 16 / 9,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              disableCenter: false,
              enlargeFactor: 2,
              pageSnapping: true,
              viewportFraction: .9,
              autoPlay: true,
            ),
            items: List.generate(
              sliderLength,
              (index) => Container(
                decoration: BoxDecoration(
                  border: const Border(
                    bottom: BorderSide(width: 13.0, color: Colora.primaryColor),
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Assets.images.toolsThatYouShouldHave.image(
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          //indicator
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: sliderLength,
              itemBuilder:
                  (context, index) => Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          index == currentSliderIndex
                              ? Colora.primaryColor
                              : Colora.scaffold,
                      border: Border.all(color: Colora.primaryColor, width: 2),
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: Dimensions.width * 0.01,
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
