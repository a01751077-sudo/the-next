import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/identity_screen.dart';
import 'screens/p2p_screen.dart';
import 'screens/communication_screen.dart';
import 'screens/financial_screen.dart';
import 'screens/gaming_screen.dart';
import 'screens/jobs_screen.dart';
import 'theme/app_theme.dart';

/// Resource Governor - Enforces system limits
class ResourceGovernor {
  static const double maxRAM = 0.20; // 20% of available RAM
  static const double maxStorage = 0.03; // 3% of storage
  static const int maxThreads = 8;

  static Future<bool> checkResources() async {
    // Placeholder for resource checking
    // In production: monitor RAM, storage, threads
    return true;
  }
}

/// Security check before app starts
Future<bool> performSecurityCheck() async {
  // Check for tampering, verify integrity
  // In production: verify signatures, check root/jailbreak
  return true;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Security check BEFORE running app
  bool secure = await performSecurityCheck();
  if (!secure) {
    runApp(const BlockedApp());
    return;
  }

  // Check resource limits
  bool resourcesOk = await ResourceGovernor.checkResources();
  if (!resourcesOk) {
    runApp(const ResourceLimitApp());
    return;
  }

  runApp(const ThePlatformApp());
}

class ThePlatformApp extends StatelessWidget {
  const ThePlatformApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'THE PLATFORM',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const IdentityScreen(),
    const P2PScreen(),
    const CommunicationScreen(),
    const FinancialScreen(),
    const GamingScreen(),
    const JobsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Identity',
          ),
          NavigationDestination(
            icon: Icon(Icons.device_hub_outlined),
            selectedIcon: Icon(Icons.device_hub),
            label: 'P2P',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_outlined),
            selectedIcon: Icon(Icons.chat),
            label: 'Chat',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet),
            label: 'Finance',
          ),
          NavigationDestination(
            icon: Icon(Icons.sports_esports_outlined),
            selectedIcon: Icon(Icons.sports_esports),
            label: 'Gaming',
          ),
          NavigationDestination(
            icon: Icon(Icons.work_outline),
            selectedIcon: Icon(Icons.work),
            label: 'Jobs',
          ),
        ],
      ),
    );
  }
}/// App shown when security check fails
class BlockedApp extends StatelessWidget {
  const BlockedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'THE PLATFORM - BLOCKED',
      theme: AppTheme.darkTheme,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock,
                size: 80,
                color: AppTheme.errorColor,
              ),
              const SizedBox(height: 24),
              const Text(
                'Security Check Failed',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.errorColor,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Device failed security verification',
                style: TextStyle(color: AppTheme.textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// App shown when resource limits exceeded
class ResourceLimitApp extends StatelessWidget {
  const ResourceLimitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'THE PLATFORM - RESOURCE LIMIT',
      theme: AppTheme.darkTheme,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.memory,
                size: 80,
                color: AppTheme.warningColor,
              ),
              const SizedBox(height: 24),
              const Text(
                'Resource Limit Exceeded',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.warningColor,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'System resources exceeded limits',
                style: TextStyle(color: AppTheme.textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
