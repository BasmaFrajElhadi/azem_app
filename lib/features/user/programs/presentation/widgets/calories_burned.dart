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
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 300,
                    child: SfRadialGauge(
                      axes: [
                        RadialAxis(
                          // Make half pie chart
                          startAngle: 180,
                          endAngle: 0,
                          showLabels: false,
                          showTicks: false,
                          axisLineStyle: AxisLineStyle(
                            thickness: 20,
                            cornerStyle: CornerStyle.bothCurve,
                            color: Colors.grey[300],
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
                                      fontSize: 20,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: AppSizes.sm),
                                  Text(
                                    '2,200',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                              positionFactor: 0.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
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
          ],
        ),
      ),
    );
  }
}
