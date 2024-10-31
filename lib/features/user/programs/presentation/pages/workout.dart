import 'dart:async'; // Import the dart:async package for Timer
import 'dart:ui';
import 'package:azem/core/widgets/text_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/widgets/bottom_bar.dart';


class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({super.key});

  @override
  _WorkoutsScreenState createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  late VideoPlayerController _controller;
  Timer? _timer; // Timer to update the UI

  final List<String> titles = [
    'تمرين الضغط',
    'تمرين السكوات',
    'تمرين البلانك',
    'تمرين الاندفاع',
  ];

  final List<String> texts = [
    'تمرين الضغط: يساعد على تقوية عضلات الصدر، الأكتاف، والذراعين. يُنفذ عن طريق رفع الجسم بواسطة اليدين، مع الحفاظ على استقامة الظهر.',
    'تمرين السكوات: يعمل على تقوية عضلات الأرجل والأرداف، ويعزز التوازن والاستقرار. يُنفذ عبر الجلوس بشكل جزئي وكأنك تجلس على كرسي.',
    'تمرين البلانك: تمرين أساسي لتقوية عضلات البطن والظهر. يُنفذ بالاستلقاء على البطن، ثم رفع الجسم مستنداً على الساعدين وأصابع القدمين مع الحفاظ على استقامة الجسم.',
    'تمرين الاندفاع: يركز على عضلات الأرجل والأرداف ويعزز التوازن. يُنفذ بخطوة للأمام مع ثني الركبة والعودة للوضع الأولي بالتناوب بين الساقين.',
  ];

  @override
  void initState() {
    super.initState();
    // Initialize video controller with a network or asset video
    _controller = VideoPlayerController.asset(
      'assets/videos/running.mp4', // Replace with your video path
    )
      ..initialize().then((_) {
        setState(() {}); // Ensure the video is displayed after initialization
      });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when done
    _controller.dispose(); // Dispose the controller when done
    super.dispose();
  }

  String formatDuration(Duration position) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(position.inHours);
    final minutes = twoDigits(position.inMinutes.remainder(60));
    final seconds = twoDigits(position.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  void _startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_controller.value.isPlaying) {
        setState(() {}); // Update the UI every second
      }
    });
  }

  @override
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
      // Glassmorphism effect across the screen
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
        child: ListView(
              children: [
                const TextAppBar(title: ''),
                const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                // Video Player Container with Rounded Corners
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.hardEdge, // Clips the child widget to the border radius
                  child: _controller.value.isInitialized
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Apply rounded corners
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  )
                      : const SizedBox(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBetweenItemsMd),

                // Counter showing the current position of the video
                _controller.value.isInitialized
                    ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      // Counter Text
                      Text(
                        formatDuration(_controller.value.position),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSizes.spaceBetweenItemsMd), // Space between counter and button
                      // Play/Pause button
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_controller.value.isPlaying) {
                              _controller.pause();
                            } else {
                              _controller.play();
                              _startTimer(); // Start timer when playing
                            }
                          });
                        },
                        child: CircleAvatar(
                          radius: 30, // Size of the circle
                          backgroundColor: Theme.of(context).primaryColor, // Circle color
                          child: Icon(
                            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                    : Container(),
                const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                const Text(
                  "الفيديوهات التالية",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBetweenItemsMd),
                // Insert TimelineCards here
                ...List.generate(titles.length, (i) {
                  return TimelineCard(
                    title: titles[i],
                    text: texts[i],
                    imagePath: 'assets/images/Squats.jpg',
                    id: i,
                  );
                }),
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
}

class TimelineCard extends StatelessWidget {
  final String title;
  final String text;
  final String imagePath;
  final int id;

  const TimelineCard({
    super.key,
    required this.title,
    required this.text,
    required this.imagePath,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white, // Set card color to white
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row to align the image and text
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Expanded widget to allow text to take available space
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        text,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        maxLines: 2, // Limit the number of lines for the text to prevent overflow
                        overflow: TextOverflow.ellipsis, // Add ellipsis for overflowed text
                      ),
                      const SizedBox(height: 8),
                      // Button below the text
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to the WorkoutsScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const WorkoutsScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor, // Adjust button color
                        ),
                        child: const Text("ابدأ التمرين",style: TextStyle(color:Colors.white),),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Image on the right side, wrapped in Flexible to handle overflow
                Flexible(
                  flex: 2,
                  child: Image.asset(
                    imagePath,
                    width: 80,
                    height: 100,
                    fit: BoxFit.cover,
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

