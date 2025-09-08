import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  // Getter to easily access the flag value
  bool get showEpisodeCount => _remoteConfig.getBool('showEpisodeCount');

  Future<void> initialize() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      // Use low values for easy testing
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(seconds: 10),
    ));

    // Set default values so the app has a value on very first run
    await _remoteConfig.setDefaults(const {
      'showEpisodeCount': false,
    });

    // Fetch and activate the latest config from the server
    await _remoteConfig.fetchAndActivate();
  }
}