import 'package:flutter/material.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/icons_path.dart';
import '../../../../../core/constants/sizes.dart';
// Import barcode scanner package
// Import HTTP package
class MealSearchBar extends StatelessWidget {
  const MealSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.buttonRadiusLg),
        border: Border.all(color: const Color(0xFFEDEDED), width: 1),
      ),
      child: Row(
        children: [
          // Search icon
          Image.asset(
            IconsPath.searchIcon,
            height: AppSizes.iconMd,
          ),
          const SizedBox(width: AppSizes.md),
          // TextField for search input
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ابحث عن الوجبات...',
                hintStyle: TextStyle(color: AppColors.textHint),
                border: InputBorder.none,
              ),
            ),
          ),
          // Barcode icon wrapped in GestureDetector
          const SizedBox(width: AppSizes.md),
          GestureDetector(
            onTap: () {
              // _showBarcodeBottomSheet(context); // Show bottom sheet
            },
            child: Image.asset(
              IconsPath.barcodeBtnIcon,
              height: AppSizes.iconXl,
            ),
          ),
        ],
      ),
    );
  }
// Import JSON conversion
//   void _showBarcodeBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isDismissible: true, // Allow dismissing by tapping outside
//       isScrollControlled: true, // Allow scrolling if needed
//       builder: (BuildContext context) {
//         return Container(
//           width: double.infinity, // Make the width match the screen width
//           padding: const EdgeInsets.all(AppSizes.md),
//           height: 270,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Image displayed in the bottom sheet
//               Image.asset(
//                 'assets/icons/mainIcon/barcode.png',
//                 height: 150, // Adjust height as necessary
//                 fit: BoxFit.cover, // Adjust the image fitting if necessary
//               ),
//               SizedBox(height: AppSizes.md),
//               // Button under the image
//               ElevatedButton(
//                 onPressed: () async {
//                   // Initiate barcode scanning
//                   ScanResult result = await BarcodeScanner.scan();
//
//                   if (result.rawContent.isNotEmpty) {
//                     // Fetch product data from Open Food Facts API
//                     final productInfo = await fetchProductData(result.rawContent);
//                     if (productInfo != null) {
//                       // Handle the product information (e.g., show it in a dialog or display it)
//                       showDialog(
//                         context: context,
//                         builder: (context) {
//                           return AlertDialog(
//                             title: Text(productInfo['product']['product_name'] ?? 'Product'),
//                             content: Text('Details: ${productInfo['product']['ingredients_text'] ?? 'No ingredients available'}'),
//                             actions: [
//                               TextButton(
//                                 onPressed: () => Navigator.of(context).pop(),
//                                 child: const Text('Close'),
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     } else {
//                       // Handle case where no product data is found
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Product not found!')),
//                       );
//                     }
//                   }
//
//                   Navigator.of(context).pop();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primaryColor,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
//                 ),
//                 child: const Text(
//                   'مسح الباركود الخاص بالمنتج',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
// // Function to fetch product data from Open Food Facts API
//   Future<Map<String, dynamic>?> fetchProductData(String barcode) async {
//     final url = 'https://world.openfoodfacts.org/api/v0/product/$barcode.json';
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         return json.decode(response.body);
//       } else {
//         print('Failed to load product data: ${response.statusCode}');
//         return null;
//       }
//     } catch (e) {
//       print('Error fetching product data: $e');
//       return null;
//     }
//   }

}
