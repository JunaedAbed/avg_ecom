import 'package:avg_ecom/src/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final homeController = Get.find<HomeController>();

class _HomeScreenState extends State<HomeScreen> {
  late InAppWebViewController webview;
  // @override
  // void initState() {
  //   homeController.launchWebsite();
  //   Get.back();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest:
                  URLRequest(url: Uri.parse(homeController.websiteUrl)),
              onWebViewCreated: (InAppWebViewController controller) {
                webview = controller;
              },
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  useOnDownloadStart: true,
                  allowFileAccessFromFileURLs: true,
                ),
                android: AndroidInAppWebViewOptions(
                  geolocationEnabled: true,
                ),
                ios: IOSInAppWebViewOptions(
                  allowsInlineMediaPlayback: true,
                ),
              ),
              // shouldOverrideUrlLoading: (controller, navigationAction) async {
              //   var uri = navigationAction.request.url;
              //   if (uri != null &&
              //       uri.toString().startsWith(
              //           'https://www.akijtakafullife.com.bd/cliam_individual_form/download/')) {
              //     // Use url_launcher to open the download URL in the device's default browser or download manager
              //     if (await canLaunchUrl(uri)) {
              //       await launchUrl(uri);
              //       return NavigationActionPolicy
              //           .CANCEL; // Cancel the current navigation
              //     }
              //   }
              //   return NavigationActionPolicy
              //       .ALLOW; // Allow the current navigation
              // },
              onDownloadStartRequest: (controller, url) async {
                print("onDownloadStart ${url.url}");
                final taskId = await FlutterDownloader.enqueue(
                  url: url.url.toString(), // Convert Uri object to String
                  savedDir: (await getExternalStorageDirectory())!.path,
                  showNotification:
                      true, // show download progress in status bar (for Android)
                  openFileFromNotification:
                      true, // click on notification to open downloaded file (for Android)
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
