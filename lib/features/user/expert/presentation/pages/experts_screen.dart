import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/widgets/bottom_bar.dart';
import '../../../../../core/widgets/text_app_bar.dart';
import '../widgets/expert_grid_view.dart';
import '../widgets/expert_search_bar.dart';

class ExpertScreen extends StatefulWidget {
  const ExpertScreen({super.key});

  @override
  _ExpertScreenState createState() => _ExpertScreenState();
}

class _ExpertScreenState extends State<ExpertScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Map<String, dynamic>> allExperts = [];
  List<Map<String, dynamic>> coaches = [];
  List<Map<String, dynamic>> nutritionists = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    fetchDataFromFirestore(); // Fetch data from Firebase
  }

  Future<void> fetchDataFromFirestore() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();

      List<Map<String, dynamic>> allData = [];
      List<Map<String, dynamic>> coachData = [];
      List<Map<String, dynamic>> nutritionistData = [];

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        if (data['role'] == 'مدرب' || data['role'] == 'أخصائي تغذية') {
          allData.add(data);
        }
        if (data['role'] == 'مدرب') {
          coachData.add(data);
        }
        if (data['role'] == 'أخصائي تغذية') {
          nutritionistData.add(data);
        }
      }

      setState(() {
        allExperts = allData;
        coaches = coachData;
        nutritionists = nutritionistData;
      });
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: CustomBottomBar(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
                children: [
            Container(
            decoration: BoxDecoration(
            gradient: LinearGradient(
            colors: [
            AppColors.primaryColor.withOpacity(0.8),
            Colors.white
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),

        ),
      ),
            // Glassmorphism effect
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 30,
                sigmaY: 30,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            // Content of the screen
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSizes.xl, horizontal: AppSizes.md),
              child: Column(
                    children: [
                      const TextAppBar(title: "خبراء"),
                      const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                      const Text(
                        'يقدم تطبيقنا أفضل الخبراء في اللياقة و التغذية لتوجيهك نحو نمط حياة صحي و متوازن.',
                        style: TextStyle(
                          fontSize: AppSizes.fontSizeXs,
                          color: AppColors.textSecondary,
                        ),
                        softWrap: true,
                      ),
                      const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                      const ExpertSearchBar(),
                      const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                      // TabBar outside the AppBar
                      Container(
                        child:  TabBar(
                          controller: _tabController,
                          isScrollable: true,
                          unselectedLabelColor: AppColors.textPrimary,
                          labelColor: AppColors.white,
                          labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                          indicator: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          tabs: List.generate(3, (index) {
                            return Tab(
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: AppSizes.sm, horizontal: AppSizes.lg),
                                decoration: BoxDecoration(
                                  color: _tabController.index == index
                                      ? AppColors.primaryColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.primaryColor,
                                    width: 1,
                                  ),
                                ),
                                child: Text(_getTabTitle(index)),
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                      // TabBarView to display the content for each tab
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            ExpertGridView(expertList: allExperts),
                            ExpertGridView(expertList: coaches),
                            ExpertGridView(expertList: nutritionists),
                          ],
                        ),
                      ),
                    ],
                  )
                ),
              ],
            ),
          ),
        ),
      )
    );
  }


  String _getTabTitle(int index) {
    switch (index) {
      case 0:
        return 'الكل';
      case 1:
        return 'المدربين';
      case 2:
        return 'أخصائيي التغذية';
      default:
        return '';
    }
  }
}
