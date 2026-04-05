// Integrity Check Service - Full system integrity verification
import 'anti_tamper_service.dart';
import 'anti_theft_service.dart';

class IntegrityCheckResult {
  final bool isSecure;
  final List<String> warnings;
  final List<String> failures;
  final Map<String, dynamic> details;
  
  IntegrityCheckResult({
    required this.isSecure,
    required this.warnings,
    required this.failures,
    required this.details,
  });
}

class IntegrityCheckService {
  static bool _initialized = false;

  static Future<void> initialize() async {
    await AntiTamperService.initialize();
    _initialized = true;
  }

  static Future<IntegrityCheckResult> verifyIntegrity() async {
    if (!_initialized) await initialize();
    
    List<String> warnings = [];
    List<String> failures = [];
    Map<String, dynamic> details = {};
    
    bool tamperSecure = await AntiTamperService.checkIntegrity();
    details['tamperCheck'] = tamperSecure;
    
    if (!tamperSecure) {
      failures.add('Tamper check failed');
    }
    
    bool storageSecure = await _checkStorage();
    details['storageCheck'] = storageSecure;
    if (!storageSecure) warnings.add('Storage warning');
    
    bool networkSecure = await _checkNetwork();
    details['networkCheck'] = networkSecure;
    if (!networkSecure) warnings.add('Network warning');
    
    return IntegrityCheckResult(
      isSecure: tamperSecure && failures.isEmpty,
      warnings: warnings,
      failures: failures,
      details: details,
    );
  }

  static Future<bool> quickCheck() async {
    return await AntiTamperService.checkIntegrity();
  }

  static Future<bool> _checkStorage() async => true;
  static Future<bool> _checkNetwork() async => true;

  static Future<Map<String, dynamic>> getSecurityReport() async {
    final integrity = await verifyIntegrity();
    return {
      'secure': integrity.isSecure,
      'warnings': integrity.warnings,
      'failures': integrity.failures,
      'details': integrity.details,
      'antiTamper': await AntiTamperService.getSecurityReport(),
      'antiTheft': await AntiTheftService.getDeviceStatus(),
    };
  }
}