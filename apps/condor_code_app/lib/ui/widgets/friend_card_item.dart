import 'package:ui_kit/ui_kit.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class FriendCardItem extends StatelessWidget {
  final Friend friendData;

  const FriendCardItem({super.key, required this.friendData});

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.all(6),
    child: GestureDetector(
      child: Container(
        width: 136,
        decoration: BoxDecoration(
          color: context.colors.surface,
          border: Border.all(color: context.colors.accent, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Stack(
            children: [
              Positioned(
                top: -14,
                right: -14,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.highlight_remove,
                    color: context.colors.textPrimary,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (friendData.imageUrl.isNotEmpty)
                    SizedBox(
                      height: 46,
                      width: 46,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(friendData.imageUrl),
                      ),
                    ),
                  if (friendData.imageUrl.isEmpty)
                    const SizedBox(
                      height: 46,
                      width: 46,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/images/1000_F_353110097_nbpmfn9iHlxef4EDIhXB1tdTD0lcWhG9.jpg',
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(friendData.name, style: AppTextStyles.body2),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      friendData.description,
                      style: AppTextStyles.body3,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: ElevatedButton(
                      style: AppButtonStyles.mainButtonStyle(context),
                      onPressed: () {},
                      child: Text(
                        'subscribe',
                        style: TextStyle(
                          color: context.colors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
