import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/constants/colors.dart';

class PlansCarousel extends StatefulWidget {
  const PlansCarousel({super.key});

  @override
  _PlansCarouselState createState() => _PlansCarouselState();
}

class _PlansCarouselState extends State<PlansCarousel> {
  final List<Map<String, String>> _plans = [
    {
      'title': 'تمرينات مع المدرب أحمد علي',
      'duration': 'شهر',
      'image': 'assets/images/home/workout1.svg',
    },
    {
      'title': 'تغذية صحية مع المدرب محمد',
      'duration': 'أسبوعين',
      'image': 'assets/images/home/workout2.svg',
    },
    {
      'title': 'تمرينات متقدمة مع المدربة سارة',
      'duration': '3 أشهر',
      'image': 'assets/images/home/workout3.svg',
    },
  ];

  Map<String, String> _selectedPlan = {}; // Track the selected plan

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 330,
        aspectRatio: 16 / 9,
        viewportFraction: 0.70,
        enlargeCenterPage: true,
      ),
      items: _plans.map((plan) {
        return Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              setState(() {
                if (_selectedPlan == plan) {
                  _selectedPlan = {};
                } else {
                  _selectedPlan = plan;
                }
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: _selectedPlan == plan
                    ? Border.all(
                  color:AppColors.primaryColor,
                  width: 3,
                )
                    : null,
                boxShadow: _selectedPlan == plan
                    ? [
                  BoxShadow(
                    color: Colors.blue.shade100,
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  )
                ]
                    : [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: Column(
                children: [
                  // Plan Image
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SvgPicture.asset(
                      plan['image']!,
                      height: 200, // Adjust height as needed
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 10), // Adjust spacing between image and title

                  // Plan Title
                  Text(
                    plan['title']!, // Access the title from the map
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),

                  // Plan Duration
                  Text(
                    plan['duration']!, // Access the duration from the map
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      }).toList(),
    );
  }
}
