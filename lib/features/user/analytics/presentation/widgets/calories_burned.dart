import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';

class CaloriesBurned extends StatefulWidget {
  const CaloriesBurned({super.key});

  @override
  State<CaloriesBurned> createState() => _CaloriesBurnedState();
}

class _CaloriesBurnedState extends State<CaloriesBurned> {
  // Method to build info columns with title and value
  Widget _buildInfoColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: AppSizes.fontSizeLg,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: AppSizes.fontSizeMd,
          ),
        ),
      ],
    );
  }

  // Method to build a light grey divider
  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 40,
      color: Colors.grey[300],
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      surfaceTintColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 280,
                width: double.infinity,
                child: SfRadialGauge(
                  axes: [
                    RadialAxis(
                      startAngle: 180,
                      endAngle: 0,
                      showLabels: false,
                      showTicks: false,
                      axisLineStyle: const AxisLineStyle(
                        thickness: 20,
                        cornerStyle: CornerStyle.bothCurve,
                        color: AppColors.mediumLightGray,
                      ),
                      pointers: const [
                        RangePointer(
                          value: 70,
                          cornerStyle: CornerStyle.bothCurve,
                          color: AppColors.primaryColor,
                          width: 20,
                        ),
                      ],
                      annotations: const [
                        GaugeAnnotation(
                          widget: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'اجمالي السعرات المحروقة',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSizes.fontSizeLg,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              SizedBox(height: AppSizes.sm),
                              Text(
                                '2,200',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSizes.fontSizeMd,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Row of information
            Positioned(
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSizes.md),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // IBM Text and Value
                    _buildInfoColumn("IBM", "18.5"),
                    _buildDivider(),
                    // Exercise Duration
                    _buildInfoColumn("مدة التمرين", "2 ساعة"),
                    _buildDivider(),
                    // Calories Burned
                    _buildInfoColumn("الحرق", "2,000"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
