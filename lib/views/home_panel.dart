import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:fakestoreapi/controllers/home_controller.dart';
import 'package:fakestoreapi/router.dart';
import 'package:fakestoreapi/theme/light_theme.dart';
import 'package:fakestoreapi/views/home_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;

  final HomeController _homeController = HomeController();

  @override
  void initState() {
    super.initState();

    settingsController.addListener(() {
      if (mounted) setState(() {});
    });
    _homeController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    _homeController.getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    onButtonPressed(int index) {
      setState(() {
        _selectedIndex = index;
      });
      _pageController.animateToPage(_selectedIndex,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutQuad);
    }

    final List<Widget> bottomBarPages = [
      HomeScreen(controller: _homeController),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/img/logo.png', width: 100),
        shadowColor: Colors.transparent,
        actions: [
          Builder(builder: (BuildContext context) {
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
                    
                        context.push('/cart');
                    
                  },
                  icon:  SvgPicture.asset(
                          'assets/svg/cart.svg',
                        ),
                ),
              ],
            );
          }),
        ],
      ),
      body: PageView(
        scrollBehavior:
            const ScrollBehavior().copyWith(overscroll: true, scrollbars: true),
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 50,
              color: Colors.white.withOpacity(.9),
            )
          ],
        ),
        child: SafeArea(
          bottom: true,
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () => onButtonPressed(0),
                  child: SizedBox(
                    height: 80,
                    width: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svg/home.svg',
                          color: _selectedIndex == 0
                              ? LightTheme.main
                              : LightTheme.textBlack,
                          width: 20,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'الرئيسية',
                          style: LightTheme.textStyle(fontSize: 13),
                        )
                      ],
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
