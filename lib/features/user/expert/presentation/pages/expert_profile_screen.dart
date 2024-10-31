import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/icons_path.dart';
import '../../../../../core/constants/images_path.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../programs/presentation/pages/main_program_screen.dart';
import '../../../userManagement/presentation/provider/current_user_provider.dart';
import '../../domain/entities/subscription_entity.dart';
import '../provider/subscription_provider.dart';

class ExpertProfileScreen extends StatefulWidget {
  const ExpertProfileScreen({
    super.key,
    required this.name,
    required this.email,
    required this.imagePath,
    required this.role,
    required this.bio,
    required this.likes,
    required this.subscriptionPrice

  });

  final String email;
  final String name;
  final String imagePath;
  final String role;
  final String bio;
  final int subscriptionPrice;
  final int likes;
  @override
  _ExpertProfileScreenState createState() => _ExpertProfileScreenState();
}

class _ExpertProfileScreenState extends State<ExpertProfileScreen> {
  bool isLiked = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  // Image at the top
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppSizes.xl, horizontal: AppSizes.md),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Back icon (right side)
                              IconButton(
                                icon: Image.asset(
                                  IconsPath.backArrowIcon,
                                  height: AppSizes.iconXxl,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              // Share icon (left side)
                              PopupMenuButton<int>(
                                icon: Image.asset(
                                  IconsPath.menuDotsIcon,
                                  height: AppSizes.iconLg,
                                ),
                                onSelected: (value) {
                                  if (value == 0) {
                                    print("ابلاغ clicked");
                                    // Add your reporting logic here
                                  } else if (value == 1) {
                                    print("مشاركة clicked");
                                    // Add your sharing logic here
                                  }
                                },
                                itemBuilder: (BuildContext context) =>
                                [
                                  const PopupMenuItem<int>(
                                    value: 0,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'ابلاغ',
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ),
                                  const PopupMenuItem<int>(
                                    value: 1,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'مشاركة',
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ),
                                ],
                                color: AppColors.lightGray,
                                // Background color of the popup menu
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(12)), // Border radius
                                ),
                              ),


                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppSizes.md, horizontal: AppSizes.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.name,
                                  style: const TextStyle(
                                    fontSize: AppSizes.fontSizeLg,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 12, bottom: 12),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 12.0),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    widget.role,
                                    style: const TextStyle(
                                      fontSize: AppSizes.fontSizeSm,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: Image.asset(
                                    isLiked
                                        ? IconsPath
                                        .filledFavoriteIcon // Liked state icon
                                        : IconsPath.favoriteIcon,
                                    // Default icon
                                    height: AppSizes.iconMd,
                                  ),
                                  onPressed: () {
                                    // Toggle the heart icon on click
                                    setState(() {
                                      isLiked = !isLiked;
                                    });
                                  },
                                ),
                                const Text(
                                  '120 إعجاب',
                                  style: TextStyle(
                                    fontSize: AppSizes.fontSizeXs,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          widget.bio,
                          style: const TextStyle(
                            fontSize: AppSizes.fontSizeSm,
                            color: AppColors.textSecondary,
                            height: 2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: AppSizes.md,
                              horizontal: AppSizes.md),
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.lightGray,
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Left Column (Text + Button)
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'حقق أهدافك الرياضية بسرعة مع برامج تدريبية مخصصة من مدرب شخصي محترف، سواء لبناء العضلات، تحسين اللياقة، أو فقدان الوزن.',
                                      style: TextStyle(
                                        fontSize: AppSizes.fontSizeSm,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: 16.0),
                                    ElevatedButton(
                                      onPressed: () {
                                        _showBottomSheet(
                                            context, widget.subscriptionPrice,
                                            widget.email);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              12),
                                        ),
                                      ),
                                      child: const Text(
                                        'اشترك الان',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: AppSizes.fontSizeSm,
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              const SizedBox(width: AppSizes.md),
                              // Right Column (Image)
                              Expanded(
                                flex: 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    ImagesPath.runningManImage,
                                    fit: BoxFit.cover,
                                    height: 180,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),
                        // comment section
                        const Text(
                          'التعليقات',
                          style: TextStyle(
                            fontSize: AppSizes.fontSizeLg,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: AppSizes.sm),
                        Container(
                          padding: const EdgeInsets.all(AppSizes.md),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                maxLines: 3,
                                decoration: InputDecoration(
                                  hintText: 'أضف تعليقك هنا...',
                                  hintStyle: const TextStyle(
                                      color: AppColors.textHint),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: AppColors.textHint),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: AppColors.primaryColor),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              // In your ElevatedButton inside the comment section
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  textStyle: const TextStyle(
                                      fontSize: AppSizes.fontSizeSm),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text('إرسال التعليق',
                                    style: TextStyle(color: AppColors.white)),
                              ),

                              const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                              const Text(
                                'التعليقات السابقة',
                                style: TextStyle(
                                  fontSize: AppSizes.fontSizeSm,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              ListView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  // Comment
                                  _buildComment('علي محمد',
                                      'هذا مدرب رائع! أنصح الجميع بالتسجيل.',
                                      'قبل 5 ساعات'),
                                  _buildComment('علي محمد',
                                      'هذا مدرب رائع! أنصح الجميع بالتسجيل.',
                                      'قبل 5 ساعات'),

                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComment(String name, String comment, String time) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSizes.spaceBetweenItemsMd),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/images/workoutman.jpg'),
          ),
          const SizedBox(width: AppSizes.spaceBetweenItemsSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: AppSizes.fontSizeSm,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  comment,
                  style: const TextStyle(color: AppColors.textSecondary,
                      fontSize: AppSizes.fontSizeXs),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.md),
          Column(
            children: [
              Text(
                time,
                style: const TextStyle(
                    color: AppColors.textHint, fontSize: AppSizes.fontSizeXs),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context, int subscriptionPrice, String expertEmail) {
    String? selectedPaymentMethod = 'سداد'; // Default selected payment method
    String? selectedDuration = 'المدة'; // Default selected duration
    int currentSubscriptionPrice = subscriptionPrice; // Initialize current price

    Map<String, int> durationInDays = {
      'شهري': 30,
      '3 شهور': 90,
      '6 شهور': 180,
    };

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Consumer<SubscriptionProvider>(
          builder: (context, subscriptionProvider, child) {
            return StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'تفاصيل الدفع',
                        style: TextStyle(
                          fontSize: AppSizes.fontSizeMd,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppSizes.md),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'د.ل$currentSubscriptionPrice',
                            style: const TextStyle(
                              fontSize: AppSizes.fontSizeLg,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: DropdownButton<String>(
                              value: selectedDuration,
                              items: <String>[
                                'المدة',
                                'شهري',
                                '3 شهور',
                                '6 شهور'
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedDuration = newValue;

                                  if (durationInDays.containsKey(newValue)) {
                                    int days = durationInDays[newValue]!;
                                    currentSubscriptionPrice = subscriptionPrice * (days ~/ 30);
                                  } else {
                                    currentSubscriptionPrice = 0;
                                  }
                                });
                              },
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              dropdownColor: AppColors.primaryColor,
                              iconEnabledColor: Colors.white,
                              underline: const SizedBox(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      Expanded(
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 1,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            List<String> paymentMethods = [
                              'ادفعلي',
                              'موبي كاش',
                              'سداد',
                              'ادفعلي'
                            ];
                            List<String> paymentImages = [
                              'assets/icons/logos/edfelieLogo.png',
                              'assets/icons/logos/mobicashLogo.png',
                              'assets/icons/logos/saddadLogo.png',
                              'assets/icons/logos/edfelieLogo.png'
                            ];

                            String method = paymentMethods[index];
                            String imagePath = paymentImages[index];

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedPaymentMethod = method;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: selectedPaymentMethod == method
                                        ? AppColors.primaryColor
                                        : AppColors.lightGray,
                                    width: 2.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        imagePath,
                                        width: 35,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        method,
                                        style: const TextStyle(
                                          color: AppColors.textPrimary,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          onPressed: selectedDuration != 'المدة' ? () async {
                            SubscriptionEntity subscription = SubscriptionEntity(
                              price: currentSubscriptionPrice,
                              expertEmail: expertEmail,
                              userEmail: Provider.of<CurrentUserProvider>(context, listen: false).email,
                              duration: durationInDays[selectedDuration]!,
                              paymentMethod: selectedPaymentMethod!,
                              status: "pending",
                            );
                            final provider = Provider.of<SubscriptionProvider>(context, listen: false);
                            await provider.addSubscription(subscription);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MainProgramScreen(
                                expertEmail: expertEmail,
                                status: "pending",
                              )),
                            );
                          } : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: const Text(
                            'اشترك',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: AppSizes.fontSizeSm,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

}
