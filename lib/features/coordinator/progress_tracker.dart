import 'dart:async';

/// Progress Tracker - monitors AI agent task progress
/// Part of PINC Network Platform

class ProgressTracker {
  final Map<String, PhaseProgress> _phases = {};
  final Map<String, AgentProgress> _agentProgress = {};

  /// Initialize phases
  void initPhases(List<String> phaseNames) {
    for (var i = 0; i < phaseNames.length; i++) {
      _phases[phaseNames[i]] = PhaseProgress(
        name: phaseNames[i],
        order: i,
        status: PhaseStatus.pending,
        agents: [],
      );
    }
  }

  /// Start a phase
  void startPhase(String phaseName) {
    final phase = _phases[phaseName];
    if (phase != null) {
      _phases[phaseName] = phase.copyWith(status: PhaseStatus.running);
    }
  }

  /// Complete a phase
  void completePhase(String phaseName) {
    final phase = _phases[phaseName];
    if (phase != null) {
      _phases[phaseName] = phase.copyWith(status: PhaseStatus.completed);
    }
  }

  /// Get phase status
  PhaseProgress? getPhase(String phaseName) => _phases[phaseName];

  /// Get all phases
  List<PhaseProgress> getAllPhases() => _phases.values.toList()..sort((a, b) => a.order.compareTo(b.order));

  /// Track agent progress
  void updateAgentProgress(String agentId, String phase, AgentWorkStatus status, {String? message}) {
    _agentProgress[agentId] = AgentProgress(
      agentId: agentId,
      phase: phase,
      status: status,
      lastUpdate: DateTime.now(),
      message: message,
    );
  }

  /// Get agent progress
  AgentProgress? getAgentProgress(String agentId) => _agentProgress[agentId];

  /// Get overall status
  Map<String, dynamic> getOverallStatus() {
    final phases = getAllPhases();
    return {
      'phases': phases.map((p) => {'name': p.name, 'status': p.status.name}).toList(),
      'agents': _agentProgress.length,
      'completed': _agentProgress.values.where((a) => a.status == AgentWorkStatus.completed).length,
      'inProgress': _agentProgress.values.where((a) => a.status == AgentWorkStatus.inProgress).length,
    };
  }
}

enum PhaseStatus { pending, running, completed }

enum AgentWorkStatus { pending, inProgress, completed, failed }

class PhaseProgress {
  final String name;
  final int order;
  final PhaseStatus status;
  final List<String> agents;

  PhaseProgress({
    required this.name,
    required this.order,
    required this.status,
    required this.agents,
  });

  PhaseProgress copyWith({
    String? name,
    int? order,
    PhaseStatus? status,
    List<String>? agents,
  }) {
    return PhaseProgress(
      name: name ?? this.name,
      order: order ?? this.order,
      status: status ?? this.status,
      agents: agents ?? this.agents,
    );
  }
}

class AgentProgress {
  final String agentId;
  final String phase;
  final AgentWorkStatus status;
  final DateTime lastUpdate;
  final String? message;

  AgentProgress({
    required this.agentId,
    required this.phase,
    required this.status,
    required this.lastUpdate,
    this.message,
  });
}