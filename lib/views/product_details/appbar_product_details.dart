import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:fakestoreapi/router.dart';
import 'package:fakestoreapi/views/product_details_screen.dart';
import 'package:fakestoreapi/theme/light_theme.dart';

class CustomAppBarCard extends StatefulWidget {
  const CustomAppBarCard({
    super.key,
    required this.widget,
  });

  final ProductDetailsScreen widget;

  @override
  State<CustomAppBarCard> createState() => _CustomAppBarCardState();
}

class _CustomAppBarCardState extends State<CustomAppBarCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            widget.widget.data?.image ?? '',
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton(
                onPressed: () {
                  context.pop();
                },
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(LightTheme.main.withOpacity(0.6)),
                ),
                child:
                    Icon(Icons.arrow_back_ios_new, color: LightTheme.textWhite),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Builder(builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: LightTheme.third,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Builder(builder: (BuildContext context) {
                  return Stack(
                    children: [
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: LightTheme.main,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              settingsController.cart?.length.toString() ?? '0',
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          if (mounted) {
                            context.push('/cart');
                          }
                        },
                        icon: SvgPicture.asset(
                          'assets/svg/cart.svg',
                          color: LightTheme.textWhite,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            );
          }),
        ],
      ),
    );
  }
}
