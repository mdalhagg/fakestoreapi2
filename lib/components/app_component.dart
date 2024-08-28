import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:fakestoreapi/theme/light_theme.dart';

class NoInternetCard extends StatelessWidget {
  const NoInternetCard({super.key, this.width});
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/svg/no_internet.svg', width: width ?? 150),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'تاكد من اتصالك بالانترنت',
            style: LightTheme.textStyle(color: LightTheme.main, fontSize: 20),
          ),
        ),
        const SizedBox(height: 60)
      ],
    ));
  }
}

class NoDataCard extends StatelessWidget {
  const NoDataCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/no_products.svg',
            width: 150,
          ),
          const SizedBox(height: 10),
          Text(
            'لا يوجد بيانات',
            style: LightTheme.textStyle(
              color: LightTheme.main,
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingCard extends StatelessWidget {
  const LoadingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingAnimationWidget.threeArchedCircle(
            color: LightTheme.main, size: 100));
  }
}

class SearchCard extends StatelessWidget {
  const SearchCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: LightTheme.background,
          border: Border.all(color: LightTheme.textBlack.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: LightTheme.textBlack.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ]),
      width: MediaQuery.of(context).size.width * 0.8,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.search, color: LightTheme.textBlack),
          const SizedBox(
            width: 10,
          ),
          Text(
            'بحث',
            style:
                LightTheme.textStyle(fontSize: 16, color: LightTheme.textGray)
                    .copyWith(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

class LoadingTimeWorkCard extends StatelessWidget {
  const LoadingTimeWorkCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: LoadingAnimationWidget.threeArchedCircle(
          color: LightTheme.main, size: 20),
    );
  }
}

class NoDataCart extends StatelessWidget {
  const NoDataCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/no_products.svg',
            width: 200,
          ),
          const SizedBox(height: 20),
          Text(
            'سلتك فارغه الرجاء متابعه التسوق',
            style: LightTheme.textStyle(color: LightTheme.main, fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class NoDataCartCard extends StatelessWidget {
  const NoDataCartCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/no_products.svg',
            width: 200,
          ),
          const SizedBox(height: 20),
          Text(
            'سلتك فارغه الرجاء متابعه التسوق',
            style: LightTheme.textStyle(color: LightTheme.main, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
