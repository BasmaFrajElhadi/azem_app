import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';


class TotalCalories extends StatefulWidget {
  const TotalCalories({super.key});

  @override
  State<TotalCalories> createState() => _TotalCaloriesState();
}

class _TotalCaloriesState extends State<TotalCalories> {
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
                    height: 200,
                    child: SfRadialGauge(
                      axes: [
                        RadialAxis(
                          labelOffset: 0,
                          pointers: const [
                            RangePointer(
                              value: 20,
                              cornerStyle: CornerStyle.bothCurve,
                              color: Color(0xFF6BBDFF),
                              width: 20,
                            ),
                          ],
                          axisLineStyle: const AxisLineStyle(
                            thickness: 20,
                          ),
                          startAngle: 130,
                          endAngle: 130,
                          showLabels: false,
                          showTicks: false,
                          annotations: const [
                            GaugeAnnotation(
                              widget: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '2,265',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: AppSizes.sm),
                                  Text(
                                    'السعرات الحرارية',
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
                        RadialAxis(
                          pointers: const [
                            RangePointer(
                              value: 20,
                              cornerStyle: CornerStyle.bothCurve,
                              color: Color(0xFFFFB744),
                              width: 20,
                            ),
                          ],
                          startAngle: 10,
                          endAngle: 10,
                          showLabels: false,
                          showTicks: false,
                          showAxisLine: false,
                        ),
                        RadialAxis(
                          pointers: const [
                            RangePointer(
                              value: 20,
                              cornerStyle: CornerStyle.bothCurve,
                              color: Color(0xFFFF76EA),
                              width: 20,
                            ),
                          ],
                          startAngle: 70,
                          endAngle: 70,
                          showLabels: false,
                          showTicks: false,
                          showAxisLine: false,
                        ),
                        RadialAxis(
                          pointers: const [
                            RangePointer(
                              value: 20,
                              cornerStyle: CornerStyle.bothCurve,
                              color: Color(0xFF7A6AFC),
                              width: 20,
                            ),
                          ],
                          startAngle: -60,
                          endAngle: -60,
                          showLabels: false,
                          showTicks: false,
                          showAxisLine: false,
                        ),
                      ],
                    ),

                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
