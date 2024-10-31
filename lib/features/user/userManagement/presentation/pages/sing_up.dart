import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../home/presentation/pages/home_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Store user input
  String _gender = '';
  String _goal = '';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  // Date picker for birth date
  DateTime? _selectedDate;

  // Form keys
  final _formKey = GlobalKey<FormState>();
  bool _genderError = false;
  bool _birthdateError = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              _buildFirstPage(),
              _buildSecondPage(),
              _buildThirdPage(),
              _buildFourthPage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFirstPage() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),
                  Image.asset('assets/images/onboardingImage.png'),
                  const SizedBox(height: 5),
                  _buildValidatedInputField(
                    controller: _nameController,
                    labelText: 'الاسم',
                    icon: Icons.person,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال الاسم';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildValidatedInputField(
                    controller: _emailController,
                    labelText: 'البريد الإلكتروني',
                    icon: Icons.email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال البريد الإلكتروني';
                      }
                      if (!RegExp(r'^[\w-]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) {
                        return 'البريد الإلكتروني غير صالح';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildValidatedInputField(
                    controller: _passwordController,
                    labelText: 'كلمة المرور',
                    icon: Icons.lock,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال كلمة المرور';
                      }
                      if (value.length < 6) {
                        return 'يجب أن تكون كلمة المرور على الأقل 6 أحرف';
                      }
                      if (!RegExp(r'^(?=.*?[A-Za-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{6,}$')
                          .hasMatch(value)) {
                        return 'كلمة المرور يجب أن تحتوي على حرف، ورقم، ورمز خاص';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          _buildBottomButton('استمر', () {
            if (_formKey.currentState!.validate()) {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          }),
        ],
      ),
    );
  }

  Widget _buildValidatedInputField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    required String? Function(String?) validator,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.right,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildSecondPage() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 50),
                const Text('اختر الجنس', style: TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildGenderCard('ذكر', Icons.male),
                    const SizedBox(width: 20),
                    _buildGenderCard('أنثى', Icons.female),
                  ],
                ),
                _genderError ? const Text('الرجاء اختيار الجنس', style: TextStyle(color: Colors.red)) : Container(),
                const SizedBox(height: 30),
                const Text(
                  'اختر تاريخ الميلاد',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 10),
                _buildDatePicker(),
                _birthdateError ? const Text('الرجاء اختيار تاريخ الميلاد', style: TextStyle(color: Colors.red)) : Container(),
              ],
            ),
          ),
        ),
        _buildBottomButton('استمر', () {
          setState(() {
            _genderError = _gender.isEmpty;
            _birthdateError = _selectedDate == null;
          });
          if (!_genderError && !_birthdateError) {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        }),
      ],
    );
  }

  Widget _buildDatePicker() {
    return ElevatedButton(
      onPressed: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime(1998, 4, 15),
          firstDate: DateTime(1900),
          lastDate: DateTime(2025),
        );
        if (picked != null) {
          setState(() {
            _selectedDate = picked;
          });
        }
      },
      child: Text(
        _selectedDate == null
            ? "اختر تاريخ الميلاد"
            : "${_selectedDate!.toLocal()}".split(' ')[0],
      ),
    );
  }

  Widget _buildThirdPage() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 50),
                  _buildValidatedInputField(
                    controller: _heightController,
                    labelText: 'الطول (سم)',
                    icon: Icons.height,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال الطول';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildValidatedInputField(
                    controller: _weightController,
                    labelText: 'الوزن (كجم)',
                    icon: Icons.fitness_center,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال الوزن';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          _buildBottomButton('استمر', () {
            if (_formKey.currentState!.validate()) {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          }),
        ],
      ),
    );
  }

  Widget _buildFourthPage() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 50),
                const Text('ما هو هدفك؟', style: TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                _buildGoalCard('إنقاص الوزن'),
                const SizedBox(height: 10),
                _buildGoalCard('زيادة الوزن'),
                const SizedBox(height: 10),
                _buildGoalCard('الحفاظ على الوزن'),
              ],
            ),
          ),
        ),
        _buildBottomButton('إنشاء الحساب', () {
          if (_goal.isNotEmpty) {
            _createAccount();
          }
        }),
      ],
    );
  }

  Widget _buildGoalCard(String goal) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _goal = goal;
        });
      },
      child: Card(
        color: _goal == goal ? Colors.green : Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(child: Text(goal, style: const TextStyle(fontSize: 18))),
        ),
      ),
    );
  }

  Widget _buildGenderCard(String gender, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _gender = gender;
        });
      },
      child: Card(
        color: _gender == gender ? Colors.green : Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Icon(icon, size: 60),
              const SizedBox(height: 10),
              Text(gender, style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(text, style: const TextStyle(fontSize: 16)),
        ),
      ),
    );
  }

  Future<void> _createAccount() async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      await FirebaseFirestore.instance.collection('Users').doc(userCredential.user!.uid).set({
        'name': _nameController.text,
        'email': _emailController.text,
        'gender': _gender,
        'birthdate': _selectedDate,
        'height': _heightController.text,
        'weight': _weightController.text,
        'goal': _goal,
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'حدث خطأ، الرجاء المحاولة مرة أخرى.';
      if (e.code == 'email-already-in-use') {
        errorMessage = 'البريد الإلكتروني مسجل مسبقًا.';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('حدث خطأ غير متوقع')));
    }
  }
}
