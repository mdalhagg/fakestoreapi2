import 'package:fakestoreapi/components/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:fakestoreapi/components/app_component.dart';
import 'package:fakestoreapi/controllers/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.controller});
  final HomeController controller;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeController _homeController;

  @override
  void initState() {
    super.initState();
    _homeController = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      extendBody: true,
      body: PageView(children: [
        Column(children: [
          InkWell(
            onTap: () {
              context.push('/search-products');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/svg/filter.svg'),
                  const SearchCard(),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              controller: _homeController.refreshController,
              onRefresh: () async {
                await _homeController.refresh();
                setState(() {});
              },
              footer: const ClassicFooter(
                height: 0,
              ),
              child: _homeController.isLoading
                  ? const LoadingCard()
                  : _homeController.noData
                      ? const NoInternetCard()
                      : SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              Wrap(
                                  children: List.generate(
                                _homeController.home?.length ?? 0,
                                (index) => ProductCard(
                                    data: _homeController.home[index]),
                              )),
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(
                                indent: 20,
                                endIndent: 20,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
            ),
          ),
        ]),
      ]),
    );
  }
}
