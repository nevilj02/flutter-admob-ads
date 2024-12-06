import 'dart:ui';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppLifecycleReactor {
  final VoidCallback onAppForeground;

  AppLifecycleReactor({required this.onAppForeground}) {
    listenToAppStateChanges();
  }

  void listenToAppStateChanges() {
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream
        .forEach((state) => _onAppStateChanged(state));
  }

  void _onAppStateChanged(AppState appState) {
    if (appState == AppState.foreground) {
      onAppForeground.call();
    }
  }
}
