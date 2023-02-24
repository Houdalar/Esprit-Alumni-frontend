import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';

Future<void> initUniLinks() async {
  try {
    final initialLink = await getInitialLink();
    if (initialLink != null) {
      // Handle the initial link here
      print(initialLink);
    }
  } on PlatformException {
    // Handle any errors that might occur while getting the initial link
  }

  // Listen for incoming links while the app is running
  uriLinkStream.listen((Uri uri) {
    // Handle the incoming link here
    print(uri);
  });
}

void main() {
  // Initialize uni_links before running the app
  initUniLinks();

  runApp(MyApp());
}
