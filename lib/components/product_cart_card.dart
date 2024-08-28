
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:fakestoreapi/components/dialogs/cart_delete_dialog.dart';
import 'package:fakestoreapi/components/snackbar.dart';
import 'package:fakestoreapi/controllers/cart.dart';
import 'package:fakestoreapi/models/product_cart.dart';
import 'package:fakestoreapi/theme/light_theme.dart';

class ProductCartCard extends StatefulWidget {
  const ProductCartCard({super.key, required this.data, this.index});
  final ProductCart? data;
  final int? index;

  @override
  State<ProductCartCard> createState() => _ProductCartCardState();
}

class _ProductCartCardState extends State<ProductCartCard> {
  final CartController cartController = CartController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsetsDirectional.only(end: 8, bottom: 8),
          height: 100,
          decoration: BoxDecoration(
              color: LightTheme.background,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: LightTheme.textBlack.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.data?.image ?? '',
                    imageBuilder: (context, imageProvider) => Container(
                      width: 80,
                      height: 80,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                              widget.data?.image ?? ''),
                        ),
                      ),
                    ),
                    placeholder: (context, url) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[200]!,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.red,
                          ),
                        ),
                      );
                    },
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/img/splash/logo.png',
                      width: LightTheme.mediaQueryData.size.width * 0.5,
                    ),
                    fit: BoxFit.contain,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.data?.title ?? '',
                            style: LightTheme.textStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        cartController.isLoading = true;
                        setState(() {});
                        await cartController.changeQuantity(context,
                            index: widget.index ?? 0,
                            quantity: (widget.data?.quantity ?? 0) + 1);
                        // update widget.data
                        widget.data?.quantity =
                            cartController.cart?[widget.index ?? 0].quantity;

                        setState(() {});
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.all(10),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: LightTheme.main),
                        child: Icon(
                          Icons.add,
                          color: LightTheme.textWhite,
                          size: 22,
                        ),
                      ),
                    ),
                    cartController.isLoading == false
                        ? Container(
                            padding: const EdgeInsets.all(10),
                            child: Text('${widget.data?.quantity ?? 0}',
                                style: LightTheme.textStyle(fontSize: 20)),
                          )
                        : Container(
                            padding: const EdgeInsets.all(10),
                            child: LoadingAnimationWidget.threeArchedCircle(
                                color: LightTheme.main, size: 10),
                          ),
                    InkWell(
                      onTap: () async {
                        cartController.isLoading = true;
                        setState(() {});
                        if (widget.data?.quantity == 1) {
                          errorSnackbar(context,
                              message: 'لقد وصلت للحد الاقصى');
                        } else {
                          await cartController.changeQuantity(context,
                              index: widget.index ?? 0,
                              quantity: (widget.data?.quantity ?? 0) - 1);
                        }
                        widget.data?.quantity =
                            cartController.cart?[widget.index ?? 0].quantity;

                        setState(() {});
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.all(10),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: LightTheme.textGray2),
                        child: Icon(
                          Icons.remove,
                          color: LightTheme.main,
                          size: 22,
                        ),
                      ),
                    )
                  ])
            ],
          ),
        ),
        Positioned(
            top: 5,
            right: 5,
            child: InkWell(
              onTap: () async {
                await CartDialog.cartDeleteDialogConfirm(context, () async {
                  await cartController.remove(context,
                      index: widget.index ?? 0);
                  Navigator.pop(context);
                });
              },
              child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: LightTheme.red,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(Icons.close,
                      size: 18, color: LightTheme.background)),
            ))
      ],
    );
  }
}
