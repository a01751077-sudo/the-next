import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Anti-Theft Service - Device theft protection
/// Features: Shutdown protection, Remote lock/wipe, Location tracking, Camera capture, Trusted contacts

class AntiTheftService {
  // Trusted contacts
  static final List<String> _trustedContacts = [];

  // Tracking enabled
  static bool _trackingEnabled = false;

  // Photo captured (for theft evidence)
  static List<int>? _capturedPhoto;

  /// Enable shutdown protection
  static Future<void> enableShutdownProtection() async {
    _log('Shutdown protection enabled');

    // In production: Use system alarm to prevent shutdown
    // Show confirmation dialog before shutdown
  }

  /// Remote lock - lock device
  static Future<void> remoteLock({String? message}) async {
    _log('Remote lock initiated');

    // Show lock screen with custom message
    // In production: Use device admin or screen pinning

    _showLockScreen(message ?? 'Device locked by PINC Security');
  }

  /// Show lock screen
  static void _showLockScreen(String message) {
    // In production: Navigate to lock screen
    _log('Lock screen: $message');
  }

  /// Remote wipe - erase all data
  static Future<void> remoteWipe() async {
    _log('Remote wipe initiated');

    // 1. Corrupt storage
    await _corruptStorage();

    // 2. Delete all data
    await _deleteAllData();

    // 3. Factory reset (if possible)
    await _factoryReset();
  }

  /// Corrupt storage
  static Future<void> _corruptStorage() async {
    _log('Corrupting storage...');

    // In production: Overwrite all storage
  }

  /// Delete all data
  static Future<void> _deleteAllData() async {
    _log('Deleting all data...');

    // In production: Clear Hive, secure storage, databases
  }

  /// Factory reset
  static Future<void> _factoryReset() async {
    _log('Factory reset...');

    // In production: Use device admin
  }

  /// Enable location tracking
  static Future<void> enableTracking() async {
    _log('Location tracking enabled');
    _trackingEnabled = true;

    // In production: Start GPS tracking
    Timer.periodic(const Duration(minutes: 5), (timer) async {
      if (_trackingEnabled) {
        await _sendLocation();
      } else {
        timer.cancel();
      }
    });
  }

  /// Disable tracking
  static Future<void> disableTracking() async {
    _trackingEnabled = false;
    _log('Location tracking disabled');
  }

  /// Send location to server
  static Future<void> _sendLocation() async {
    // In production: Get GPS and send to P2P
    _log('Location sent');
  }

  /// Capture silent photo
  static Future<void> capturePhoto() async {
    _log('Capturing photo...');

    try {
      // In production: Use camera without preview
      // final camera = CameraController();
      // await camera.takePicture();
      _capturedPhoto = [];
      _log('Photo captured');
    } catch (e) {
      _log('Photo capture failed: $e');
    }
  }

  /// Add trusted contact
  static void addTrustedContact(String identifier) {
    _trustedContacts.add(identifier);
    _log('Added trusted contact: $identifier');
  }

  /// Remove trusted contact
  static void removeTrustedContact(String identifier) {
    _trustedContacts.remove(identifier);
    _log('Removed trusted contact: $identifier');
  }

  /// Alert all trusted contacts
  static Future<void> alertTrustedContacts() async {
    for (final contact in _trustedContacts) {
      await _sendAlert(contact);
    }
  }

  /// Send alert to contact
  static Future<void> _sendAlert(String contact) async {
    _log('Alert sent to: $contact');

    // In production: Send via P2P/notification
  }

  /// Get location permission
  static Future<bool> requestLocationPermission() async {
    // In production: Request location permission
    return true;
  }

  /// Get camera permission
  static Future<bool> requestCameraPermission() async {
    // In production: Request camera permission
    return true;
  }

  /// Get trusted contacts
  static List<String> getTrustedContacts() => List.unmodifiable(_trustedContacts);

  /// Get tracking status
  static bool isTracking() => _trackingEnabled;

  /// Log helper
  static void _log(String message) {
    print('[Security] AntiTheft: $message');
  }
}

/// Shutdown interceptor widget
/// In production: Wrap main app with this
class ShutdownProtection extends StatefulWidget {
  final Widget child;

  const ShutdownProtection({super.key, required this.child});

  @override
  State<ShutdownProtection> createState() => _ShutdownProtectionState();
}

class _ShutdownProtectionState extends State<ShutdownProtection>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _enableProtection();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _enableProtection() {
    AntiTheftService.enableShutdownProtection();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Track app backgrounding
  }

  @override
  Widget build(BuildContext context) => widget.child;
}