import 'package:avg_ecom/constants/app_asset.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: content(),
      ),
    );
  }

  Widget content() {
    return Stack(children: [
      Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppAsset.splashImage), fit: BoxFit.cover),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Lottie.asset(
          AppAsset.loadingLottie,
          height: 120,
          width: 120,
        ),
      ),
    ]);
  }
}
