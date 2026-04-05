import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'self_destruct_service.dart';

/// Anti-Tamper Service - Detects and responds to device compromise
/// Checks: root, debugger, emulator, binary integrity

class AntiTamperService {
  /// Full integrity check - runs on app start
  static Future<bool> checkIntegrity() async {
    // Check root access
    bool isRooted = await checkRoot();
    if (isRooted) {
      _log('ROOT DETECTED');
      await SelfDestructService.onTrigger(SelfDestructService.triggerRoot);
      return false;
    }

    // Check debugger
    bool hasDebugger = await checkDebugger();
    if (hasDebugger) {
      _log('DEBUGGER ATTACHED');
      await SelfDestructService.onTrigger(SelfDestructService.triggerDebugger);
      return false;
    }

    // Check emulator
    bool isEmulator = await checkEmulator();
    if (isEmulator) {
      _log('EMULATOR DETECTED');
      await SelfDestructService.onTrigger(SelfDestructService.triggerEmulator);
      return false;
    }

    // Check binary integrity
    bool isIntact = await checkBinaryIntegrity();
    if (!isIntact) {
      _log('BINARY TAMPERED');
      await SelfDestructService.onTrigger(SelfDestructService.triggerBinary);
      return false;
    }

    _log('Integrity check PASSED');
    return true;
  }

  /// Check for root/JAILBREAK
  static Future<bool> checkRoot() async {
    if (!Platform.isAndroid && !Platform.isIOS) return false;

    // Common root paths on Android
    final rootPaths = [
      '/system/app/Superuser.apk',
      '/sbin/su',
      '/system/bin/su',
      '/system/xbin/su',
      '/data/local/xbin/su',
    ];

    for (final path in rootPaths) {
      try {
        if (await File(path).exists()) {
          return true;
        }
      } catch (_) {}
    }

    // Check for su command
    try {
      final result = await Process.run('which', ['su']);
      if (result.exitCode == 0) {
        return true;
      }
    } catch (_) {}

    return false;
  }

  /// Check for debugger attached
  static Future<bool> checkDebugger() async {
    try {
      // Check Android debug flags
      final debugPort = await const MethodChannel('flutter/debug')
          .invokeMethod<bool>('isDebuggerConnected');

      if (debugPort == true) return true;
    } catch (_) {}

    // Check for JDWP (Java Debug Wire Protocol)
    try {
      final result = await Process.run('getprop', ['ro.debuggable']);
      if (result.stdout.toString().contains('1')) {
        return true;
      }
    } catch (_) {}

    return false;
  }

  /// Check for emulator
  static Future<bool> checkEmulator() async {
    if (!Platform.isAndroid) return false;

    try {
      // Check common emulator indicators
      final result = await Process.run('getprop', ['ro.hardware']);
      final output = result.stdout.toString().toLowerCase();

      // Known emulator hardware
      if (output.contains('goldfish') ||
          output.contains('ranchu') ||
          output.contains('sdk') ||
          output.contains('emulator')) {
        return true;
      }

      // Check for Google Maps API key in emulator
      final mapsResult = await Process.run('getprop', ['com.google.android.maps.api']);
      if (mapsResult.stdout.toString().contains('fake')) {
        return true;
      }
    } catch (_) {}

    return false;
  }

  /// Check binary integrity via SHA-3
  static Future<bool> checkBinaryIntegrity() async {
    // In production: Compare computed hash with stored hash
    // For this stub: Return true if not in debug mode
    try {
      // Get app version hash (stub)
      final hash = SelfDestructService.hashSHA3('the-platform-v1.0.0');

      // In production: Compare with signed hash from server
      // For now: Accept any hash
      _log('Binary hash: $hash');
      return true;
    } catch (e) {
      _log('Integrity check error: $e');
      return false;
    }
  }

  /// Monitor for memory tampering (continuous)
  static Future<void> startMonitoring() async {
    _log('Starting tamper monitoring...');

    // Check every 30 seconds
    Timer.periodic(const Duration(seconds: 30), (timer) async {
      final isSecure = await checkIntegrity();
      if (!isSecure) {
        timer.cancel();
      }
    });
  }

  /// Log helper
  static void _log(String message) {
    print('[Security] AntiTamper: $message');
  }
}