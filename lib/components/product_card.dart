
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:fakestoreapi/models/product.dart';
import 'package:fakestoreapi/theme/light_theme.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, this.index, this.data, this.then});
  final int? index;
  final Product? data;
  final Future<void> Function(Object?)? then;
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context
            .push('/product-details', extra: widget.data)
            .then(widget.then ?? (_) {});
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                Container(
                  width: 80,
                  height: 80,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: widget.data?.image == null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: const Image(
                            image: AssetImage('assets/img/product_logo.webp'),
                          ),
                        )
                      : CachedNetworkImage(
                          imageUrl: widget.data?.image ?? "",
                          imageBuilder: (context, imageProvider) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                          placeholder: (context, url) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[200]!,
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.red,
                                ),
                              ),
                            );
                          },
                          errorWidget: (context, url, error) => ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: const Image(
                              image: AssetImage('assets/img/product_logo.webp'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.data?.title ?? '',
                          style: LightTheme.textStyle(fontSize: 18)),
                      SizedBox(
                        width: 150,
                        child: Text(widget.data?.description ?? '',
                            style: LightTheme.textStyle(fontSize: 14).copyWith(
                                fontWeight: FontWeight.w100,
                                overflow: TextOverflow.ellipsis)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(10),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: LightTheme.main),
              child: SvgPicture.asset(
                'assets/svg/cart.svg',
                color: LightTheme.textWhite,
              ),
            )
          ],
        ),
      ),
    );
  }
}
