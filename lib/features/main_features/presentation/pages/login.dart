import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/icons_path.dart';
import '../../../../core/constants/sizes.dart';
import '../../../user/home/presentation/pages/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance; // Firestore instance
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  bool _isPasswordVisible = false;
  String? _emailError; // To display email validation error
  String? _passwordError; // To display password validation error
  String? _emailExistsError; // To show if the email does not exist

  // Regular expression for validating email format
  final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

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
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Check if the email already exists in Firestore
  Future<bool> _checkEmailExists(String email) async {
    if (email.isNotEmpty) {
      try {
        // Query Firestore to check if the email exists
        QuerySnapshot querySnapshot = await firestore.collection('Users').where('email', isEqualTo: email).get();
        return querySnapshot.docs.isNotEmpty;
      } catch (e) {
        setState(() {
          _emailExistsError = 'حدث خطأ أثناء التحقق من البريد الإلكتروني';
        });
      }
    }
    return false; // Email does not exist
  }

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

              // Email Field with validation
              Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.spaceBetweenItemsMd),
                child: SizedBox(
                  height: _emailExistsError != null || _emailError != null ? 100 : 70, // Adjust height based on error presence
                  child: Column(
                    children: [
                      TextField(
                        controller: emailController,
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
                        onChanged: (value) {
                          // Validate the email format on change
                          if (!_emailRegExp.hasMatch(value)) {
                            setState(() {
                              _emailError = 'البريد الإلكتروني غير صالح'; // Invalid email
                            });
                          } else {
                            setState(() {
                              _emailError = null; // Clear error if valid
                            });
                          }
                        },
                      ),
                      // Show error messages only if they exist
                      if (_emailExistsError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            _emailExistsError!,
                            style: const TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                      if (_emailError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            _emailError!,
                            style: const TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Password Field with validation
              Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.spaceBetweenItemsMd),
                child: SizedBox(
                  height: _passwordError != null ? 100 : 70, // Adjust height based on error presence
                  child: Column(
                    children: [
                      TextField(
                        controller: passwordController,
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
                      // Show error message only if it exists
                      if (_passwordError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            _passwordError!,
                            style: const TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                    ],
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
                      String email = emailController.text.trim();
                      String password = passwordController.text.trim();

                      setState(() {
                        // Basic validations
                        _emailError = email.isEmpty ? 'البريد الإلكتروني مطلوب' : null;
                        _passwordError = password.isEmpty ? 'الرمز السري مطلوب' : null;

                        // Validate email format
                        if (!_emailRegExp.hasMatch(email)) {
                          _emailError = 'البريد الإلكتروني غير صالح';
                        }
                      });

                      // Additional email existence check if no errors
                      if (_emailError == null) {
                        bool emailExists = await _checkEmailExists(email);
                        if (!emailExists) {
                          setState(() {
                            _emailExistsError = 'البريد الإلكتروني غير موجود';
                          });
                          return; // Stop execution if email doesn't exist
                        } else {
                          setState(() {
                            _emailExistsError = null; // Clear error if email exists
                          });
                        }

                        // Proceed with login if email exists
                        try {
                          UserCredential userCredential = await auth.signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const HomeScreen()), // Navigate to home screen
                          );
                        } catch (e) {
                          setState(() {
                            _passwordError = 'فشل تسجيل الدخول: تأكد من البريد الإلكتروني والرمز السري'; // Adjust error message as necessary
                          });
                        }
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
                      style: TextStyle(
                        fontSize: AppSizes.fontSizeMd,
                        fontWeight: FontWeight.bold,
                      ),
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
                    onPressed: () async {
                      try {
                        // Attempt to sign in with Google
                        UserCredential userCredential = await signInWithGoogle();

                        // If the sign-in is successful, navigate to the HomeScreen
                        if (userCredential.user != null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const HomeScreen()), // Navigate to home screen
                          );
                        }
                      } catch (e) {
                        // Handle any errors that occur during sign-in
                        print('Error signing in with Google: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('فشل تسجيل الدخول باستخدام Google')),
                        );
                      }
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

              // Sign Up Link
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'ليس لديك حساب؟ ',
                    style: const TextStyle(color: AppColors.textSecondary),
                    children: [
                      TextSpan(
                        text: 'سجل الآن',
                        style: const TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
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
