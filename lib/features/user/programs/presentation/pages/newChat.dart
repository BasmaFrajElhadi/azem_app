import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:image_picker/image_picker.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../../core/widgets/bottom_bar.dart';
import '../widgets/chat_app_bar.dart';

class NewChatScreen extends StatefulWidget {
  const NewChatScreen({super.key});

  @override
  _NewChatScreenState createState() => _NewChatScreenState();
}

class _NewChatScreenState extends State<NewChatScreen> {
  final List<Map<String, dynamic>> messages = [];
  final TextEditingController _messageController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        messages.insert(0, {
          'text': _messageController.text,
          'time': intl.DateFormat.jm().format(DateTime.now()),
          'isSent': true,
        });
        _messageController.clear();
      });
    }
  }

  Future<void> _sendImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        messages.insert(0, {
          'text': 'Image sent',
          'time': intl.DateFormat.jm().format(DateTime.now()),
          'isSent': true,
          'imagePath': image.path,
        });
      });
    }
  }

  void _showImageDialog(String imagePath) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(imagePath)),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: CustomBottomBar(
        child: Directionality(
          textDirection: TextDirection.rtl,
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
                filter: ImageFilter.blur(
                  sigmaX: 30,
                  sigmaY: 30,
                ),
                child: Container(
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              // Adding the ProgramAppBar
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSizes.xl, horizontal: AppSizes.md),
                child: Column(
                  children: [
                    const ChatAppBar(title: '',userImage: 'assets/images/expert/nutritionist/nutritionist1.jpg',userName: 'أسامة محمد',),
                    const SizedBox(height: AppSizes.md),
                    Expanded(
                      child: messages.isEmpty
                          ? const Center(
                        child: Text(
                          'لا توجد رسائل بعد.',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      )
                          : ListView.builder(
                        itemCount: messages.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          final isSent = message['isSent'] as bool;
                          return Align(
                            alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: AppSizes.sm),
                              padding: const EdgeInsets.all(AppSizes.md),
                              decoration: BoxDecoration(
                                color: isSent ? AppColors.primaryColor : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    message['text'],
                                    style: TextStyle(
                                      color: isSent ? Colors.white : Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  if (message.containsKey('imagePath'))
                                    GestureDetector(
                                      onTap: () => _showImageDialog(message['imagePath']),
                                      child: Image.file(
                                        File(message['imagePath']),
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  const SizedBox(height: 5),
                                  Text(
                                    message['time'],
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppSizes.sm, horizontal: AppSizes.md),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.add, color: AppColors.primaryColor),
                            onPressed: _sendImage,
                          ),
                          Expanded(
                            child: TextField(
                              controller: _messageController,
                              decoration: InputDecoration(
                                hintText: 'اكتب رسالتك...',
                                hintStyle: const TextStyle(color: AppColors.textHint),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(color: AppColors.primaryColor),
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                              ),
                              onSubmitted: (_) => _sendMessage(),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.send, color: AppColors.primaryColor),
                            onPressed: _sendMessage,
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
      ),
    );
  }
}
