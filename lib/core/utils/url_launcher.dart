import 'dart:io';
// import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class URLLauncherClass {
  ///---------------------///
  ///----Launching Url----///
  ///---------------------///
  static Future<void> luanchUrl(String path) async {
    String newPath = path.substring(8);
    final Uri params = Uri(
      scheme: 'https',
      path: newPath,
    );

    Uri url = params;

    if (await canLaunchUrl(url).then((value) => true)) {
      await launchUrl(url,
          mode: LaunchMode.platformDefault,
          webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: true,
            headers: {
              'Accept': 'application/json',
            },
          ));
    } else {
      throw 'Could not launch $url';
    }
  }

  ///------------------///
  ///----Send Email----///
  ///------------------///
  static Future<void> sendEmail(String path) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: path,
      query:
          'subject=App Feedback&body=App Version 3.23', //add subject and body here
    );

    Uri url = params;
    if (await canLaunchUrl(url).then((value) => true)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  ///------------------///
  ///----Phone Call----///
  ///------------------///
  static Future<void> phoneCall(String url) async {
    Uri uri = Uri.parse('tel:$url');

    if (await canLaunchUrl(uri).then((value) => true)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  ///----------------------------///
  ///----Open Map Coordinates----///
  ///----------------------------///
  static Future<void> openMapCoordinates(
      String latitude, String longitude) async {
// MapsLauncher.launchCoordinates(double.parse(latitude), double.parse(longitude));
    ///----This url to open in web
    //  Uri uri = Uri.parse(
    //         'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
    Uri uri = Uri();
    if (Platform.isAndroid) {
      uri = Uri.parse('google.navigation:q=$latitude,$longitude&mode=d');
    } else {
      uri = Uri.parse('https://maps.apple.com/?q=$latitude,$longitude');
    }

    if (await canLaunchUrl(uri).then((value) => true)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  ///------------------------///
  ///----Open Map Address----///
  ///------------------------///
  // static openMapAddress(String address) {
  //   MapsLauncher.launchQuery(address);
  // }
}
