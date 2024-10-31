import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/colors.dart';
import '../provider/get_current_slider_food.dart';

class MealsSlider extends StatefulWidget {
  final List<Map<String, dynamic>> meals; // Changed to a single list

  const MealsSlider({super.key, required this.meals});

  @override
  _MealsSliderState createState() => _MealsSliderState();
}

// class _MealsSliderState extends State<MealsSlider> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: widget.meals.isNotEmpty
//           ? CarouselSlider(
//         options: CarouselOptions(
//           height: 300,
//           enlargeCenterPage: true,
//           viewportFraction: 0.6,
//         ),
//         items: widget.meals.map((meal) {
//           return Builder(
//             builder: (BuildContext context) {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Use a placeholder image if the image path is invalid
//                   Image.network(
//                     meal['imagePath'] ?? 'assets/images/fallback.png', // Use a fallback if null
//                     height: 90,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Image.asset(
//                         'assets/images/fallback.png',
//                         height: 100,
//                         fit: BoxFit.cover,
//                       );
//                     },
//                   ),
//
//                   const SizedBox(height: 10),
//                   Text(
//                     meal['foodName'] ?? 'عنصر غير معروف', // Fallback text
//                     style: const TextStyle(
//                       fontSize: 22.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textAlign: TextAlign.center, // Center text
//                   ),
//                 ],
//               );
//             },
//           );
//         }).toList(),
//       )
//           : const Text(
//         'لا توجد وجبات متاحة.',
//         style: TextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.bold,
//           color: AppColors.textSecondary,
//         ),
//       ),
//     );
//   }
// }

//==========


class _MealsSliderState extends State<MealsSlider> {
  @override
  void initState() {
    super.initState();

    // Set the initial meal if there are meals available
    if (widget.meals.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<GetCurrentSliderFoodProvider>(context, listen: false)
            .setCurrentMeal(widget.meals[0]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: widget.meals.isNotEmpty
          ? CarouselSlider(
        options: CarouselOptions(
          height: 300,
          enlargeCenterPage: true,
          viewportFraction: 0.6,
          onPageChanged: (index, reason) {
            Provider.of<GetCurrentSliderFoodProvider>(context, listen: false)
                .setCurrentMeal(widget.meals[index]);
          },
        ),
        items: widget.meals.map((meal) {
          return Builder(
            builder: (BuildContext context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    meal['imagePath'] ?? 'assets/images/fallback.png',
                    height: 90,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/fallback.png',
                        height: 100,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Text(
                    meal['foodName'] ?? 'عنصر غير معروف',
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          );
        }).toList(),
      )
          : const Text(
        'لا توجد وجبات متاحة.',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
