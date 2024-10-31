import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;
import '../../../../core/constants/colors.dart';
import '../provider/sign_in_provider.dart';
import '../provider/sign_up_provider.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            Positioned(
              height: 500,
              width: MediaQuery.of(context).size.width * 1.7,
              bottom: 130,
              right: 2,
              child: Image.asset('assets/images/welcome/spline.png'),
            ),
            const rive.RiveAnimation.asset('assets/riveImages/shapes.riv'),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: const SizedBox(),
              ),
            ),
            // Text for welcome screen
            const SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 60, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 250,
                      child: Column(
                        children: [
                          Text(
                            "اجعل صحتك أولويتك الأولى",
                            style: TextStyle(fontSize: 40, height: 1.2,color: AppColors.textPrimary),
                          ),
                          SizedBox(height: 30),
                          Text(
                            "اكتشف أفضل المدربين وخبراء التغذية لمساعدتك في الوصول إلى أهدافك الصحية",
                            style: TextStyle(fontSize: 16, height: 1.7,color: AppColors.textPrimary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Positioned Button at the Bottom
            Positioned(
              bottom: 150,
              right: 20,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      loginDialog(context);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: AppColors.primaryColor, width: 2),
                      ),
                    ),
                    child: const Text(
                      "ابدأ الآن",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Positioned(
              bottom: 60,
              right: 20,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9, // Set the desired width
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                      children: [
                        Text(
                          "احصل على دعم من أكثر من 100 خبير مختص لمساعدتك على تحسين صحتك "
                        "سواء كنت تبحث عن مدرب رياضي أو خبير تغذية، نحن هنا لتوفير أفضل الحلول لك "
                        "انطلق الآن في رحلة جديدة نحو حياة صحية وسعيدة",
                          style: TextStyle(fontSize: 12, height: 1.7,color: AppColors.textSecondary),
                          textAlign: TextAlign.right,
                        ),

                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Object?> loginDialog(BuildContext context) {
    return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "سجل الدخول",
      context: context,
      pageBuilder: (context, _, __) => Center(
        child: Container(
          height: 550,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.94),
            borderRadius: const BorderRadius.all(Radius.circular(40)),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              clipBehavior: Clip.none,
              children: [
                SingleChildScrollView( // Wrap the content in a ScrollView
                  child: Column(
                    children: [
                      // Title
                      const Text(
                        "سجل الدخول",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "معنا، كل يوم هو فرصة جديدة لتحقيق أهدافك الصحية",
                        style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                        textAlign: TextAlign.center,
                      ),
                      const LoginForm(),
                      const Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text("أو", style: TextStyle(color: AppColors.textHint)),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 24),
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 56),
                            side: const BorderSide(color: AppColors.primaryColor, width: 2),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                          child: const Text(
                            "سجل الدخول من خلال قوقل",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'ليس لديك حساب؟ ',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            TextSpan(
                              text: 'انشئ حساب',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                Navigator.pop(context);
                                FirstSignUpDialog(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: -80,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 2,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.white,
                      child: Icon(
                        Icons.close,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Object?> FirstSignUpDialog(BuildContext context) {
    return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "انشيء حساب",
      context: context,
      pageBuilder: (context, _, __) => Center(
        child: Container(
          height: 500,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.94),
            borderRadius: const BorderRadius.all(Radius.circular(40)),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              clipBehavior: Clip.none,
              children: [
                const SingleChildScrollView(
                  child: Column(
                    children: [
                      // Title
                      Text(
                        "انشيء حساب",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "معنا، كل يوم هو فرصة جديدة لتحقيق أهدافك الصحية",
                        style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                        textAlign: TextAlign.center,
                      ),
                      FirstSignUpForm(),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: -55,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 2,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.white,
                      child: Icon(
                        Icons.close,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Object?> SecondSignUpDialog(BuildContext context) {
    return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "انشيء حساب",
      context: context,
      pageBuilder: (context, _, __) => Center(
        child: Container(
          height: 350,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.94),
            borderRadius: const BorderRadius.all(Radius.circular(40)),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              clipBehavior: Clip.none,
              children: [
                const SingleChildScrollView(
                  child: Column(
                    children: [
                      // Title
                      Text(
                        "انشيء حساب",
                        style: TextStyle(fontSize: 20),
                      ),
                      SecondSignUpForm(),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: -55,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 2,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.white,
                      child: Icon(
                        Icons.close,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Object?> ThirdSignUpDialog(BuildContext context) {
    return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "انشيء حساب",
      context: context,
      pageBuilder: (context, _, __) => Center(
        child: Container(
          height: 350,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.94),
            borderRadius: const BorderRadius.all(Radius.circular(40)),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              clipBehavior: Clip.none,
              children: [
                const SingleChildScrollView(
                  child: Column(
                    children: [
                      // Title
                      Text(
                        "انشيء حساب",
                        style: TextStyle(fontSize: 20),
                      ),
                      ThirdSignUpForm(),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: -55,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 2,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.white,
                      child: Icon(
                        Icons.close,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Object?> ForthSignUpDialog(BuildContext context) {
    return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "انشيء حساب",
      context: context,
      pageBuilder: (context, _, __) => Center(
        child: Container(
          height: 460,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.94),
            borderRadius: const BorderRadius.all(Radius.circular(40)),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              clipBehavior: Clip.none,
              children: [
                const SingleChildScrollView(
                  child: Column(
                    children: [
                      // Title
                      Text(
                        "انشيء حساب",
                        style: TextStyle(fontSize: 20),
                      ),
                      FourthSignUpForm(),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: -55,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 2,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.white,
                      child: Icon(
                        Icons.close,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Object?> FifthSignUpDialog(BuildContext context) {
    return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "انشيء حساب",
      context: context,
      pageBuilder: (context, _, __) => Center(
        child: Container(
          height: 380,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.94),
            borderRadius: const BorderRadius.all(Radius.circular(40)),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              clipBehavior: Clip.none,
              children: [
                const SingleChildScrollView(
                  child: Column(
                    children: [
                      // Title
                      Text(
                        "انشيء حساب",
                        style: TextStyle(fontSize: 20),
                      ),
                      FifthSignUpForm(),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: -55,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 2,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.white,
                      child: Icon(
                        Icons.close,
                        color: AppColors.black,
                      ),
                    ),
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

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final signInProvider = Provider.of<SignInProvider>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              child: TextFormField(
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  labelText: "البريد الألكتروني",
                  labelStyle: const TextStyle(color: AppColors.textSecondary),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Image.asset('assets/icons/sign/email.png'),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                  ),
                ),
                onChanged: (value) {
                  signInProvider.updateEmail(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              child: TextFormField(
                obscureText: true,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  labelText: "الرمز السري",
                  labelStyle: const TextStyle(color: AppColors.textSecondary),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Image.asset('assets/icons/sign/lock.png'),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                  ),
                ),
                onChanged: (value) {
                  signInProvider.updatePassword(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                signInProvider.errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 24),
              child: ElevatedButton(
                onPressed: () {
                  signInProvider.signIn(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  minimumSize: const Size(double.infinity, 56),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                child: const Text(
                  "سجل الدخول",
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FirstSignUpForm extends StatefulWidget {
  const FirstSignUpForm({super.key});

  @override
  _FirstSignUpFormState createState() => _FirstSignUpFormState();
}

class _FirstSignUpFormState extends State<FirstSignUpForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _emailError; // Holds email error message if any
  bool _isButtonEnabled = false; // Track button enabled state

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Validation functions
  String? _validateFirstName(String? value) {
    if (value == null || value.length < 3) {
      return 'يجب أن يكون الاسم الأول على الأقل 3 أحرف';
    }
    return null;
  }

  String? _validateLastName(String? value) {
    if (value == null || value.length < 3) {
      return 'يجب أن لا يقل عن الاسم الأخير على الأقل 3 أحرف';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
      return 'يرجى إدخال بريد إلكتروني صالح';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.length < 6 || !RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$").hasMatch(value)) {
      return 'يجب أن تكون كلمة السر على الأقل 6 أحرف وتشمل أرقام وحروف';
    }
    return null;
  }

  Future<bool> _isEmailExisting(String email) async {
    try {
      final result = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      return result.docs.isNotEmpty;
    } catch (e) {
      print("Error checking email existence: $e");
      return false;
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final emailExists = await _isEmailExisting(_emailController.text);

      setState(() {
        _emailError = emailExists ? "البريد الإلكتروني مسجل بالفعل. يرجى استخدام بريد آخر." : null;
      });

      if (!emailExists) {
        // Navigate or proceed if email is unique
        const WelcomeScreen().SecondSignUpDialog(context);
      }
    }
  }

  void _updateButtonState() {
    // Check if all fields are filled and valid
    bool isValid = _formKey.currentState?.validate() ?? false;
    setState(() {
      _isButtonEnabled = isValid && _emailError == null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context, listen: false);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 16, left: 8),
                      child: TextFormField(
                        controller: _firstNameController,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          labelText: "الاسم الأول",
                          labelStyle: const TextStyle(color: AppColors.textSecondary),
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                          ),
                        ),
                        validator: _validateFirstName,
                        onChanged: (value) {
                          signUpProvider.updateFirstName(value);
                          _updateButtonState(); // Update button state
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 16, right: 8),
                      child: TextFormField(
                        controller: _lastNameController,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          labelText: "الاسم الأخير",
                          labelStyle: const TextStyle(color: AppColors.textSecondary),
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                          ),
                        ),
                        validator: _validateLastName,
                        onChanged: (value) {
                          signUpProvider.updateLastName(value);
                          _updateButtonState(); // Update button state
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              child: TextFormField(
                controller: _emailController,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  labelText: "البريد الإلكتروني",
                  labelStyle: const TextStyle(color: AppColors.textSecondary),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                  ),
                ),
                validator: _validateEmail,
                onChanged: (value) {
                  signUpProvider.updateEmail(value);
                  setState(() {
                    _emailError = null; // Reset error on email change
                  });
                  _updateButtonState(); // Update button state
                },
              ),
            ),
            if (_emailError != null) // Display email error if it exists
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  _emailError!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              child: TextFormField(
                controller: _passwordController,
                obscureText: true,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  labelText: "كلمة السر",
                  labelStyle: const TextStyle(color: AppColors.textSecondary),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                  ),
                ),
                validator: _validatePassword,
                onChanged: (value) {
                  signUpProvider.updatePassword(value);
                  _updateButtonState(); // Update button state
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 24),
              child: ElevatedButton(
                onPressed: _isButtonEnabled ? _submitForm : null, // Disable button if not enabled
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  minimumSize: const Size(double.infinity, 56),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                child: const Text(
                  "التالي",
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondSignUpForm extends StatefulWidget {
  const SecondSignUpForm({super.key});

  @override
  _SecondSignUpFormState createState() => _SecondSignUpFormState();
}

class _SecondSignUpFormState extends State<SecondSignUpForm> {
  final TextEditingController _dobController = TextEditingController();
  String? _selectedGender; // To keep track of the selected gender
  String? _errorMessage; // To hold the error message

  @override
  void dispose() {
    _dobController.dispose(); // Dispose the controller
    super.dispose();
  }

  // Function to check if the form is valid
  bool _isFormValid() {
    // Check if the DOB is not empty and gender is selected
    if (_dobController.text.isEmpty || _selectedGender == null) {
      _errorMessage = "يرجى ملء جميع الحقول.";
      return false;
    }

    // Calculate the age from the DOB
    DateTime? dob = _parseDate(_dobController.text);
    if (dob != null && _calculateAge(dob) < 15) {
      _errorMessage = "يجب أن تكون عمرك 15 سنة أو أكثر.";
      return false;
    }

    // If all validations pass, clear any error messages
    _errorMessage = null;
    return true;
  }

  // Function to parse the date from string
  DateTime? _parseDate(String date) {
    List<String> parts = date.split('/');
    if (parts.length == 3) {
      try {
        int day = int.parse(parts[0]);
        int month = int.parse(parts[1]);
        int year = int.parse(parts[2]);
        return DateTime(year, month, day);
      } catch (e) {
        return null; // Return null if parsing fails
      }
    }
    return null;
  }

  // Function to calculate age
  int _calculateAge(DateTime dob) {
    DateTime today = DateTime.now();
    int age = today.year - dob.year;
    if (today.month < dob.month || (today.month == dob.month && today.day < dob.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context, listen: false);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Date of Birth Field
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: TextFormField(
                controller: _dobController, // Assign the controller
                textAlign: TextAlign.right,
                readOnly: true, // Make it read-only to use a date picker
                decoration: InputDecoration(
                  labelText: "تاريخ الميلاد (يوم/شهر/سنة)",
                  labelStyle: const TextStyle(color: AppColors.textSecondary),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                  ),
                ),
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );

                  if (selectedDate != null) {
                    // Format the selected date as needed
                    String formattedDate =
                        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                    _dobController.text = formattedDate; // Update the text field
                    setState(() {});
                    signUpProvider.updateBirthdate(selectedDate);
                  }
                },
              ),
            ),
            // Gender Selection Cards
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GenderCard(
                    gender: "ذكر", // Male
                    isSelected: _selectedGender == "ذكر",
                    onTap: () {
                      setState(() {
                        _selectedGender = "ذكر";
                        signUpProvider.updateGender("ذكر");
                      });
                    },
                  ),
                  GenderCard(
                    gender: "أنثى", // Female
                    isSelected: _selectedGender == "أنثى",
                    onTap: () {
                      setState(() {
                        _selectedGender = "أنثى";
                        signUpProvider.updateGender("أنثى");
                      });
                    },
                  ),
                ],
              ),
            ),
            // Error Message Display
            if (_errorMessage != null) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ],
            // Submit Button
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 24),
              child: ElevatedButton(
                onPressed: _isFormValid() // Enable only if form is valid
                    ? () {
                  const WelcomeScreen().ThirdSignUpDialog(context);
                }
                    : null, // Disable button if form is not valid
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  minimumSize: const Size(double.infinity, 56),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                child: const Text(
                  "التالي",
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GenderCard extends StatelessWidget {
  final String gender;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderCard({super.key, 
    required this.gender,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          color: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isSelected ? AppColors.primaryColor : AppColors.lightGray,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  gender,
                  style: const TextStyle(
                    fontSize: 20,
                    color: AppColors.textSecondary,
                  ),
                ),
                // You can add an icon or image here if needed
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ThirdSignUpForm extends StatefulWidget {
  const ThirdSignUpForm({super.key});

  @override
  _ThirdSignUpFormState createState() => _ThirdSignUpFormState();
}

class _ThirdSignUpFormState extends State<ThirdSignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  bool _isButtonEnabled = false;

  void _validateForm() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, enable the button
      setState(() {
        _isButtonEnabled = true;
      });
    } else {
      // If the form is not valid, keep the button disabled
      setState(() {
        _isButtonEnabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context, listen: false);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Form(
        key: _formKey,
        onChanged: _validateForm, // Validate on any change
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Height Field
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              child: TextFormField(
                controller: _heightController,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  labelText: "طولك",
                  labelStyle: const TextStyle(color: AppColors.textSecondary),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Image.asset('assets/icons/sign/email.png'),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                  ),
                ),
                onChanged: (value) {
                  signUpProvider.updateHeight(value);
                  setState(() {}); // Update state when text changes
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال طولك';
                  }
                  final height = double.tryParse(value);
                  if (height == null || height <= 0) {
                    return 'الرجاء إدخال قيمة طول صحيحة';
                  }
                  return null;
                },
              ),
            ),
            // Weight Field
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              child: TextFormField(
                controller: _weightController,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  labelText: "وزنك",
                  labelStyle: const TextStyle(color: AppColors.textSecondary),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Image.asset('assets/icons/sign/lock.png'),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال وزنك';
                  }
                  final weight = double.tryParse(value);
                  if (weight == null || weight <= 0) {
                    return 'الرجاء إدخال قيمة وزن صحيحة';
                  }
                  return null;
                },
                onChanged: (value) {
                  signUpProvider.updateWeight(value);
                  setState(() {});
                },
              ),
            ),
            // Submit Button
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 24),
              child: ElevatedButton(
                onPressed: _isButtonEnabled
                    ? () {
                  if (_formKey.currentState!.validate()) {
                    const WelcomeScreen().ForthSignUpDialog(context);
                  }
                }
                    : null, // Disable the button when false
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  minimumSize: const Size(double.infinity, 56),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                child: const Text(
                  "التالي",
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FourthSignUpForm extends StatefulWidget {
  const FourthSignUpForm({super.key});

  @override
  _FourthSignUpFormState createState() => _FourthSignUpFormState();
}

class _FourthSignUpFormState extends State<FourthSignUpForm> {
  // List of goals
  final List<String> goals = ["خسارة الوزن","زيادة الوزن", "الحفاظ على الوزن","حياة صحية"];
  String? selectedGoal; // Track selected goal

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context, listen: false);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              "اختر هدفك",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          // Goal selection cards
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: goals.map((goal) {
                bool isSelected = goal == selectedGoal;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGoal = goal;
                        signUpProvider.updateGoal(goal);
                      });
                    },
                    child: Container(
                      width: 150,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: isSelected ? AppColors.primaryColor : AppColors.lightGray,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        goal,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isSelected ? AppColors.primaryColor : AppColors.textSecondary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          // Submit Button
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: ElevatedButton(
              onPressed: selectedGoal != null
                  ? () {
                const WelcomeScreen().FifthSignUpDialog(context);
              }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                minimumSize: const Size(double.infinity, 56),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              child: const Text(
                "التالي",
                style: TextStyle(color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FifthSignUpForm extends StatelessWidget {
  const FifthSignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context, listen: false);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Health Issue Field
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              child: TextFormField(
                textAlign: TextAlign.right,
                maxLines: 5, // Allows for multiple lines
                decoration: InputDecoration(
                  labelText: "مشاكل صحية",
                  labelStyle: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 18, // Larger label text
                  ),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(
                      Icons.health_and_safety,
                      color: AppColors.primaryColor,
                      size: 28, // Larger icon size
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16, // More padding for a larger input area
                  ),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      width: 2,
                    ),
                  ),

                ),
                style: const TextStyle(fontSize: 18),
                onChanged: (value) {
                  signUpProvider. updateHealthIssue(value);
                },
                // Larger input text size
              ),
            ),
            // Submit Button
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 24),
              child: ElevatedButton(
                onPressed: () {
                  signUpProvider.createAccount(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  minimumSize: const Size(double.infinity, 56),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                child: const Text(
                  "انشيء الحساب",
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
