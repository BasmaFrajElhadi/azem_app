import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/icons_path.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../home/presentation/pages/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  bool _isPasswordVisible = false;

  OutlineInputBorder _textFieldBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.grey, width: 1),
    );
  }

  final List<String> imgList = [
    'assets/images/userManagement/login1.png',
    'assets/images/userManagement/login2.png',
    'assets/images/userManagement/login3.png',
    'assets/images/userManagement/login4.png',
    'assets/images/userManagement/login5.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.lg, horizontal: AppSizes.xl),
          child: ListView(
            children: [
              // Carousel Slider
              CarouselSlider(
                options: CarouselOptions(
                  height: 180,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  enlargeCenterPage: true,
                ),
                items: imgList.map((item) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(item),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                )).toList(),
              ),
              const SizedBox(height: AppSizes.spaceBetweenItemsMd),
              // Email Field
              Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.spaceBetweenItemsMd),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    controller: emailController, // Set the controller here
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      labelText: 'البريد الإلكتروني',
                      labelStyle: const TextStyle(fontSize: 16, color: AppColors.textHint),
                      prefixIcon: Image.asset(IconsPath.emailIcon),
                      border: _textFieldBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppColors.primaryColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Password Field
              Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.spaceBetweenItemsMd),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    controller: passwordController, // Set the controller here
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      labelText: 'الرمز السري',
                      labelStyle: const TextStyle(fontSize: 16, color: AppColors.textHint),
                      suffixIcon: IconButton(
                        icon: Image.asset(
                          _isPasswordVisible ? IconsPath.eyeIcon : IconsPath.eyeCrossIcon,
                          height: AppSizes.iconMd,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      prefixIcon: Image.asset(IconsPath.lockIcon),
                      border: _textFieldBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppColors.primaryColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Remember Me & Forgot Password
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          onChanged: (value) {
                            setState(() {
                              rememberMe = value!;
                            });
                          },
                          activeColor: AppColors.primaryColor,
                        ),
                        const Text('تذكرني', style: TextStyle(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w400,
                          fontSize: AppSizes.fontSizeSm,
                        )),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        // Implement forgot password functionality here
                      },
                      child: const Text('نسيت كلمة المرور؟',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w400,
                              fontSize: AppSizes.fontSizeSm
                          )),
                    ),
                  ],
                ),
              ),

              // Login Button
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () async {
                      String email = emailController.text.trim(); // Get email
                      String password = passwordController.text.trim(); // Get password
                      try {
                        final UserCredential credential = await auth.signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == '=====user-not-found') {
                          print('====No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('=====Wrong password provided for that user.');
                        }
                      } catch (e) {
                        print(e);
                      }

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'تسجيل الدخول',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),

              // Divider with 'أو' in the center
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  children: [
                    Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text('أو', style: TextStyle(color: Colors.grey)),
                    ),
                    Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                  ],
                ),
              ),

              // Google Login Button
              Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: SizedBox(
                  height: 45,
                  child: OutlinedButton(
                    onPressed: () {
                      // Implement Google login functionality here
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primaryColor, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(IconsPath.googleIcon, height: AppSizes.iconSm),
                        const SizedBox(width: AppSizes.spaceBetweenItemsSm),
                        const Text(
                          'تسجيل الدخول باستخدام قوقل',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: AppSizes.fontSizeSm,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Account Creation Text
              Center(
                child: Text.rich(
                  TextSpan(
                    text: 'ليس لديك حساب؟ ',
                    children: [
                      TextSpan(
                        text: 'انشاء حساب',
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.pushReplacementNamed(context, 'singUp');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
