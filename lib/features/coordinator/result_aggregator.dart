import 'dart:convert';

/// Result Aggregator - combines and reports results from all AI agents
/// Part of PINC Network Platform

class ResultAggregator {
  final Map<String, AgentResult> _results = {};
  final Map<String, String> _logs = {};

  /// Aggregate a result from an agent
  void aggregateResult(String agentId, Map<String, dynamic> result) {
    _results[agentId] = AgentResult(
      agentId: agentId,
      data: result,
      timestamp: DateTime.now(),
    );
  }

  /// Get result for an agent
  AgentResult? getResult(String agentId) => _results[agentId];

  /// Get all results
  List<AgentResult> getAllResults() => _results.values.toList();

  /// Add a log entry
  void addLog(String agentId, String message) {
    final timestamp = DateTime.now().toIso8601String();
    _logs[agentId] = '[$timestamp] $message';
  }

  /// Get logs for an agent
  String? getLogs(String agentId) => _logs[agentId];

  /// Get all logs
  Map<String, String> getAllLogs() => _logs;

  /// Generate full report
  Map<String, dynamic> generateReport() {
    return {
      'generatedAt': DateTime.now().toIso8601String(),
      'totalAgents': _results.length,
      'results': _results.map((key, value) => MapEntry(key, value.data)),
      'logs': _logs,
    };
  }

  /// Export as JSON
  String exportAsJson() {
    return jsonEncode(generateReport());
  }
}

class AgentResult {
  final String agentId;
  final Map<String, dynamic> data;
  final DateTime timestamp;

  AgentResult({
    required this.agentId,
    required this.data,
    required this.timestamp,
  });
}