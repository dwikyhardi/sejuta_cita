import 'package:url_launcher/url_launcher.dart';

class LaunchAnotherApp {
  Future<void> call(String? urlToApps) async {
    if (urlToApps != null) {
      await canLaunch(urlToApps).then((isCan) async{
        if (isCan) {
        await launch(urlToApps);
        } else {
        throw 'Cant Launch Url $urlToApps';
        }
      });
    } else {
      throw 'Cant Launch empty url';
    }
  }
}
