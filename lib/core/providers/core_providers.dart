import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/remote_config_service.dart';

// FutureProvider will initialize RemoteConfigService and provide it to the app
// UI will wait for the Future to complete before trying to read any values
final remoteConfigProvider = FutureProvider<RemoteConfigService>((ref) async {
  final service = RemoteConfigService();
  await service.initialize();
  return service;
});