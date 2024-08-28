import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:fakestoreapi/components/app_component.dart';
import 'package:fakestoreapi/controllers/user.dart';
import 'package:fakestoreapi/router.dart';
import 'package:fakestoreapi/views/profile/floating_image_card.dart';
import 'package:fakestoreapi/views/profile/setting_buttons.dart';
import 'package:fakestoreapi/theme/light_theme.dart';

class FloatingProfileCard extends StatelessWidget {
  const FloatingProfileCard({
    super.key,
    required this.userController,
  });

  final UserController userController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: LightTheme.textGray2,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                )
              ],
            ),
          ),
        ),
        userController.isLoading
            ? Center(
                child: LoadingAnimationWidget.threeArchedCircle(
                    color: LightTheme.main, size: 50),
              )
             : userController.noData
                ? const NoInternetCard()
                : Positioned(
                    top: 120,
                    left: 20,
                    right: 20,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => context.push('/edit-profile'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width -  200,
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  settingsController.user?.username ?? '',
                                  style: const TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(width: 8),
                              FaIcon(
                                FontAwesomeIcons.edit,
                                color: LightTheme.main,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          settingsController.user?.phone ?? '',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
        const FloatingImageCard(),
      ],
    );
  }
}
