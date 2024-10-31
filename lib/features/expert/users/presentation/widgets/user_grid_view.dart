import 'package:flutter/material.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/sizes.dart';
import '../../../../user/expert/domain/entities/user_subscription.dart';

class UserCard extends StatefulWidget {
  final UserSubscription user;

  const UserCard({
    super.key,
    required this.user,
  });

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  late bool isLiked;
  late int currentLoves;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ExpertProfileScreen(
        //       name: widget.name,
        //       email: widget.email,
        //       imagePath: widget.imagePath,
        //       role: widget.role,
        //       bio: widget.bio,
        //       likes: currentLoves,
        //       subscriptionPrice: widget.subscriptionPrice,
        //     ),
        //   ),
        // );
      },
      child: SizedBox(
        width: 180,
        height: 320,
        child: Container(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: Image.network(
                  'assets/images/expert/trainers/tranier5.jpg',
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.user.user.name,
                                style: const TextStyle(
                                  fontSize: AppSizes.fontSizeMd,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.user.status,
                                style: const TextStyle(
                                  fontSize: AppSizes.fontSizeXs,
                                  color: AppColors.gray,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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

class UserGridView extends StatelessWidget {
  final List<UserSubscription> userSubscriptionList;


  const UserGridView({super.key, required this.userSubscriptionList});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.55,
      ),
      itemCount: userSubscriptionList.length,
      itemBuilder: (context, index) {
        final user = userSubscriptionList[index];
        return UserCard(user:user);
      },
    );
  }
}
