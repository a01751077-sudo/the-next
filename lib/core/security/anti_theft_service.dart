// Anti-Theft Service - Device protection
import 'self_destruct_service.dart';

class AntiTheftService {
  static bool _shutdownProtectionEnabled = false;
  static bool _trackingEnabled = false;

  static void enableShutdownProtection() {
    _shutdownProtectionEnabled = true;
  }

  static void disableShutdownProtection() {
    _shutdownProtectionEnabled = false;
  }

  static Future<void> remoteLock({String? message, String? pincId}) async {}
  
  static Future<void> remoteWipe() async {
    await SelfDestructService.onTrigger('tamperedBinaryHash');
  }

  static Future<void> enableTracking() async {
    _trackingEnabled = true;
  }

  static Future<void> disableTracking() async {
    _trackingEnabled = false;
  }

  static Future<void> capturePhoto() async {}
  static Future<void> alertTrustedContacts({required List<String> contactIds, String? message}) async {}
  static Future<Map<String, double>?> getLastLocation() async => null;
  static Future<bool> isDeviceOnline() async => true;
  static Future<void> playAlarm() async {}

  static Future<Map<String, dynamic>> getDeviceStatus() async {
    return {
      'shutdownProtection': _shutdownProtectionEnabled,
      'tracking': _trackingEnabled,
      'online': await isDeviceOnline(),
      'lastLocation': await getLastLocation(),
    };
  }
}