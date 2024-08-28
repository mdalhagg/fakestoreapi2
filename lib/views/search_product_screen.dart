import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:fakestoreapi/components/app_component.dart';
import 'package:fakestoreapi/controllers/home_controller.dart';
import 'package:fakestoreapi/router.dart';
import 'package:fakestoreapi/views/search_product/product_search_card.dart';
import 'package:fakestoreapi/theme/light_theme.dart';

class SearchProductsScreen extends StatefulWidget {
  const SearchProductsScreen({super.key});

  @override
  State<SearchProductsScreen> createState() => SearchProductsScreenState();
}

class SearchProductsScreenState extends State<SearchProductsScreen> {
  final HomeController _homeController = HomeController();

  TextEditingController name = TextEditingController(text: '');
  @override
  void initState() {
    super.initState();
    _homeController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    icon: SvgPicture.asset(
                      'assets/svg/cart.svg',
                      color: LightTheme.textBlack,
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
        body: PageView(
          children: [
            Column(children: [
              ProductSearchCard(name: name, controller: _homeController),
              const SizedBox(height: 10),
              Expanded(
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  controller: _homeController.refreshController,
                  onRefresh: () async {
                    // LoadingDialog.loadingDialog(context);
                    name.text = '';
                    setState(() {});
                    await _homeController.refresh();
                    // context.pop();
                  },
                  footer: const ClassicFooter(
                    height: 0,
                  ),
                  child: _homeController.isLoading == true
                      ? const LoadingCard()
                      : // if empty
                      _homeController.home?.isEmpty == true
                          ? const NoDataCard()
                          : _homeController.noData
                              ? const NoInternetCard()
                              : ProductSearchCard(
                                  name: name, controller: _homeController),
                ),
              ),
            ]),
          ],
        ));
  }
}
