/// Master Task List - Tracks all AI agent tasks
/// Part of PINC Network Platform

/// Complete task lists for each AI
class MasterTaskList {
  /// All tasks that each AI must complete
  static const Map<String, List<String>> tasks = {
    'AI #1': [
      'Complete SYSTEM_SPEC.md',
      'Add build instructions',
      'Add RAM/Storage specs',
    ],
    'AI #2': [
      'Implement AES-256-GCM',
      'Add SHA-3 hashing',
      'Add Ed25519 signing',
    ],
    'AI #3': [
      'Implement Kademlia/DHT',
      'Add SLA tracking',
      'Fix encryption',
    ],
    'AI #4': [
      'Implement WebRTC',
      'Add E2E encryption',
      'Add group calls',
    ],
    'AI #5': [
      'Add QR generation',
      'Add QR scanning',
      'Add PayPal/Stripe',
    ],
    'AI #6': [
      'Verify all 6 games',
      'Add animations',
      'Add wager system',
    ],
    'AI #7': [
      'Verify jobs system',
      'Complete escrow',
      'Add disputes',
    ],
    'AI #8': [
      'CREATE SECURITY CODE',
      'Self-destruct (6 triggers)',
      'Anti-theft',
    ],
    'AI #9': [
      'Integrate all features',
      'Add security checks',
      'Build APK',
    ],
  };

  /// Get pending tasks for an AI
  static List<String> getTasksFor(String aiId) {
    return tasks[aiId] ?? [];
  }

  /// Get total task count
  static int get totalTasks => tasks.values.fold(0, (sum, list) => sum + list.length);
}

/// AI Status Tracking
class AIProgress {
  /// Current status of each AI
  static Map<String, AITaskStatus> aiStatus = {
    'AI #1': AITaskStatus.pending,
    'AI #2': AITaskStatus.pending,
    'AI #3': AITaskStatus.pending,
    'AI #4': AITaskStatus.pending,
    'AI #5': AITaskStatus.pending,
    'AI #6': AITaskStatus.pending,
    'AI #7': AITaskStatus.pending,
    'AI #8': AITaskStatus.pending,
    'AI #9': AITaskStatus.pending,
    'AI #10': AITaskStatus.inProgress,
  };

  /// Get status for an AI
  static AITaskStatus getStatus(String aiId) {
    return aiStatus[aiId] ?? AITaskStatus.unknown;
  }

  /// Update status
  static void updateStatus(String aiId, AITaskStatus status) {
    aiStatus[aiId] = status;
  }

  /// Check if all complete
  static bool get isAllComplete {
    return aiStatus.values.every((s) => s == AITaskStatus.completed);
  }

  /// Get completion percentage
  static double get completionPercentage {
    final completed = aiStatus.values.where((s) => s == AITaskStatus.completed).length;
    return (completed / aiStatus.length) * 100;
  }
}

enum AITaskStatus {
  pending,
  inProgress,
  completed,
  failed,
  unknown,
}

/// Merge Order - Tracks integration sequence
class MergeOrder {
  /// AI #8 MUST complete first - security is blocking
  static const List<String> priority = [
    'AI #8', // Security first
    'AI #2', // Crypto
    'AI #3', // P2P
    'AI #4', // Communication
    'AI #5', // Financial
    'AI #6', // Gaming
    'AI #7', // Jobs
    'AI #9', // Integration
    'AI #10', // Coordinate
  ];

  /// Get next AI to merge
  static String? getNextPending() {
    for (final aiId in priority) {
      if (AIProgress.getStatus(aiId) == AITaskStatus.pending) {
        return aiId;
      }
    }
    return null;
  }

  /// Get current priority index
  static int getCurrentPriority(String aiId) {
    return priority.indexOf(aiId);
  }
}