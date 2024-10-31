import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/icons_path.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/widgets/bottom_bar.dart';
import '../../../../../core/widgets/text_app_bar.dart';
import '../provider/current_user_provider.dart';

class EditUserProfileScreen extends StatefulWidget {
  const EditUserProfileScreen({super.key});

  @override
  _EditUserProfileScreenState createState() => _EditUserProfileScreenState();
}

class _EditUserProfileScreenState extends State<EditUserProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _healthController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _selectedGender = 'ذكر';

  @override
  void initState() {
    super.initState();
    final currentUserProvider = Provider.of<CurrentUserProvider>(context, listen: false);
    _firstNameController.text = currentUserProvider.firstName ?? 'اسم المستخدم الافتراضي';
    _lastNameController.text = currentUserProvider.lastName ?? 'اسم المستخدم الافتراضي';
    _heightController.text = currentUserProvider.height ?? '170';
    _weightController.text = currentUserProvider.weight ?? '70';
    _healthController.text = currentUserProvider.healthIssue ?? 'مرض القلب';
    _selectedGender = currentUserProvider.gender ?? 'ذكر';
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _healthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserProvider = Provider.of<CurrentUserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
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
            Colors.white,
            ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          ),
        ),
      ),
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white.withOpacity(0.7),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.xl, horizontal: AppSizes.md),
        child: ListView(
            padding: const EdgeInsets.symmetric(vertical: AppSizes.xl, horizontal: AppSizes.md),
            children: [
              const TextAppBar(title: "تعديل الملف الشخصي"),
              const SizedBox(height: AppSizes.spaceBetweenItemsMd),
              Container(
                padding: const EdgeInsets.all(AppSizes.lg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            width: AppSizes.iconLg * 2.5,
                            height: AppSizes.iconLg * 2.5,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.primaryColor, width: 2),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                IconsPath.userIcon,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              height: 28,
                              width: 28,
                              decoration: const BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.camera_alt, color: Colors.white, size: 14),
                                onPressed: () {
                                  // Handle image change
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.md),
                      Row(
                        children: [
                          Expanded(child: TextFormField(
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              labelText: 'اسم الأول',
                              labelStyle: const TextStyle(color: AppColors.textHint),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            validator: (value) => value!.isEmpty ? 'الرجاء إدخال اسم المستخدم' : null,
                            onChanged: (value) => currentUserProvider.updateFirstName(value),
                          )),
                          const SizedBox(width: AppSizes.sm),
                          Expanded(child: TextFormField(
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              labelText: 'اسم الأخير',
                              labelStyle: const TextStyle(color: AppColors.textHint),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            validator: (value) => value!.isEmpty ? 'الرجاء إدخال اسم المستخدم' : null,
                            onChanged: (value) => currentUserProvider.updateLastName(value),
                          )),
                        ],
                      ),
                      const SizedBox(height: AppSizes.md),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildGenderCard('ذكر', IconsPath.maleIcon, currentUserProvider),
                          _buildGenderCard('أنثى', IconsPath.femaleIcon, currentUserProvider),
                        ],
                      ),
                      const SizedBox(height: AppSizes.md),
                      TextFormField(
                        controller: _weightController,
                        decoration: InputDecoration(
                          labelText: 'الوزن',
                          labelStyle: const TextStyle(color: AppColors.textHint),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        validator: (value) => value!.isEmpty ? 'الرجاء إدخال وزنك' : null,
                        onChanged: (value) => currentUserProvider.updateWeight(value),
                      ),
                      const SizedBox(height: AppSizes.md),
                      TextFormField(
                        controller: _heightController,
                        decoration: InputDecoration(
                          labelText: 'الطول',
                          labelStyle: const TextStyle(color: AppColors.textHint),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        validator: (value) => value!.isEmpty ? 'الرجاء إدخال طولك' : null,
                        onChanged: (value) => currentUserProvider.updateHeight(value),
                      ),
                      const SizedBox(height: AppSizes.md),
                      TextFormField(
                        controller: _healthController,
                        decoration: InputDecoration(
                          labelText:  'المشاكل الصحية',
                          labelStyle: const TextStyle(color: AppColors.textHint),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        onChanged: (value) => currentUserProvider.updateHealthIssue(value),
                      ),
                      const SizedBox(height: AppSizes.md),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            currentUserProvider.saveUserProfile();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("تم تحديث البيانات بنجاح")),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          minimumSize: const Size(double.infinity, 50), // Keeps the height to 56
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        child: const Text(
                          "تعديل",
                          style: TextStyle(color: AppColors.white,fontSize: AppSizes.fontSizeMd),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
              ),
                ),
                ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildGenderCard(String gender, String iconPath, CurrentUserProvider provider) {
    return GestureDetector(
      onTap: () {
        setState(() => _selectedGender = gender);
        provider.updateGender(gender);
      },
      child: SizedBox(
        width: 100,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: const EdgeInsets.all(AppSizes.md),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(
                color: _selectedGender == gender ? AppColors.primaryColor : Colors.transparent,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(IconsPath.maleIcon, height: AppSizes.iconLg),
                const SizedBox(height: AppSizes.sm),
                Text(
                  gender,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
