import 'package:flutter/material.dart';
import 'package:fakestoreapi/components/app_component.dart';
import 'package:fakestoreapi/controllers/cart.dart';
import 'package:fakestoreapi/controllers/product_details_controller.dart';
import 'package:fakestoreapi/models/product.dart';
import 'package:fakestoreapi/models/product_cart.dart';
import 'package:fakestoreapi/views/product_details/appbar_product_details.dart';
import 'package:fakestoreapi/theme/light_theme.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, this.data});
  final Product? data;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsController productDetailsController =
      ProductDetailsController();
  final CartController cartController = CartController();
  Product? product;

  int? quantity = 1;
  @override
  @override
  void initState() {
    super.initState();
    initialize();
    productDetailsController.addListener(refreshState);
  }

  void initialize() async {
    if (widget.data != null) {
      await productDetailsController.getProductDetails(widget.data?.id ?? 0);
      product = productDetailsController.product;
    }
  }

  void refreshState() {
    if (mounted) setState(() {});
  }

  init() async {
    await productDetailsController.getProductDetails(widget.data?.id ?? 0);

    product = productDetailsController.product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 1,
      ),
      body: PageView(
        children: [
          Column(
            children: [
              CustomAppBarCard(widget: widget),
              const SizedBox(height: 20),
              productDetailsController.isLoading == true
                  ? const LoadingCard()
                  : productDetailsController.noData
                      ? const NoInternetCard()
                      : Expanded(
                          child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.data?.title ?? '',
                                        style: TextStyle(
                                                color: LightTheme.textBlack,
                                                fontSize: 25)
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        widget.data?.description ?? '',
                                      ),
                                      const SizedBox(height: 20),
                                      // price
                                      Text("${widget.data?.price ?? ''}"),
                                      const SizedBox(height: 20),
                                    ]),
                              )),
                        ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              LightTheme.background.withOpacity(0.9),
              LightTheme.background.withOpacity(0.5).withAlpha(100),
              LightTheme.main.withOpacity(0.1).withAlpha(90),
            ],
          ),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: LightTheme.textBlack.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, -2),
            )
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            height: kMinInteractiveDimension,
            child: productDetailsController.isLoading == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                if (!mounted) return;

                                setState(() {
                                  if (quantity! > 1) {
                                    quantity = quantity! - 1;
                                  }
                                });
                              },
                            ),
                            Text(
                              quantity.toString(),
                              style: LightTheme.textStyle(fontSize: 18),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                if (!mounted) return;

                                setState(() {
                                  quantity = quantity! + 1;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () async {
                            // if (mounted) {
                            //   settingsController.user == null
                            //       ? LoginDialog()
                            //           .loginDialogConfirm(context)
                            //       : await cartController
                            //           .add(
                            //           context,
                            //           item: ProductCart(
                            //             quantity: quantity,
                            //             productId: product?.id,
                            //             productOptionId:
                            //                 selectedProductOption?.id,
                            //             name: product?.name,
                            //             media: product?.media,
                            //             productOption:
                            //                 selectedProductOption,
                            //             optionDetails:
                            //                 product?.optionDetails,
                            //           ),
                            //           shopId: product?.shopId ?? 0,
                            //         )
                            //           .then((value) {
                            //           if (mounted) setState(() {});
                            //         });
                            // }
                          },
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: LightTheme.main,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Text(
                                'إضافه للسله',
                                style: LightTheme.textStyle(
                                    fontSize: 16, color: LightTheme.textWhite),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                if (!mounted) return;

                                setState(() {
                                  if (quantity! > 1) {
                                    quantity = quantity! - 1;
                                  }
                                });
                              },
                            ),
                            Text(
                              quantity.toString(),
                              style: LightTheme.textStyle(fontSize: 18),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                if (!mounted) return;

                                setState(() {
                                  quantity = quantity! + 1;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () async {
                            if (mounted) {
                              await cartController
                                  .add(
                                context,
                                item: ProductCart(
                                  quantity: quantity,
                                  productId: product?.id,
                                  title: widget.data?.title,
                                  price: widget.data?.price,
                                  category: widget.data?.category,
                                  image: widget.data?.image,
                                ),
                              )
                                  .then((value) {
                                if (mounted) setState(() {});
                              });
                            }
                          },
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: LightTheme.main,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Text(
                                'إضافه للسله',
                                style: LightTheme.textStyle(
                                    fontSize: 16, color: LightTheme.textWhite),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
