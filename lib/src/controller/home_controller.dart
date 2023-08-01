import 'dart:async';
import 'package:avg_ecom/src/view/home/home_screen.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  final websiteUrl = "https://shop.akijvg.net/";
  // final websiteUrl = "https://www.akijtakafullife.com.bd/cliam_individual_form";

  setLoading(bool value) {
    isLoading(value);
  }

  launchWebsite() async {
    var url = Uri.parse("https://dev-client-ecom.vercel.app/");
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw 'Could not launch $url';
    }
  }

  startTimer() {
    var duration = const Duration(seconds: 2);
    return Timer(
        duration,
        () => Get.offAll(() => const HomeScreen(),
            duration: const Duration(milliseconds: 300),
            transition: Transition.rightToLeftWithFade));
  }

  getPermission() async {
    await Permission.storage.request();
    await Permission.location.request();
    // await FlutterDownloader.initialize(debug: true);
  }

  @override
  void onInit() {
    getPermission();
    super.onInit();
    startTimer();
  }

  // @override
  // void onInit() {
  //   launchWebsite();
  //   super.onInit();
  // }
}
