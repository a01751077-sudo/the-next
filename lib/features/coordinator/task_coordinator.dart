import 'dart:async';
import 'dart:convert';

/// Task Coordinator - distributes tasks across AI agents
/// Part of PINC Network Platform

class TaskCoordinator {
  final Map<String, Task> _tasks = {};
  final Map<String, AgentStatus> _agentStatus = {};
  final List<TaskQueue> _queues = {
    TaskQueue.phases: TaskQueue(name: 'phases', priority: 1),
    TaskQueue.parallel: TaskQueue(name: 'parallel', priority: 2),
  };

  /// Submit a new task to the coordinator
  String submitTask({
    required String taskName,
    required String agentId,
    required TaskType type,
    required Map<String, dynamic> payload,
    TaskPriority priority = TaskPriority.normal,
  }) {
    final taskId = _generateTaskId();
    final task = Task(
      id: taskId,
      name: taskName,
      agentId: agentId,
      type: type,
      priority: priority,
      payload: payload,
      status: TaskStatus.pending,
      createdAt: DateTime.now(),
    );
    _tasks[taskId] = task;
    return taskId;
  }

  /// Get task status
  Task? getTask(String taskId) => _tasks[taskId];

  /// Get all tasks for an agent
  List<Task> getTasksForAgent(String agentId) {
    return _tasks.values.where((t) => t.agentId == agentId).toList();
  }

  /// Get tasks by status
  List<Task> getTasksByStatus(TaskStatus status) {
    return _tasks.values.where((t) => t.status == status).toList();
  }

  /// Update task status
  void updateTaskStatus(String taskId, TaskStatus status, {String? result}) {
    final task = _tasks[taskId];
    if (task != null) {
      _tasks[taskId] = task.copyWith(
        status: status,
        result: result,
        completedAt: status == TaskStatus.completed ? DateTime.now() : null,
      );
    }
  }

  /// Get aggregated results
  Map<String, dynamic> getAggregatedResults() {
    final completed = getTasksByStatus(TaskStatus.completed);
    return {
      'total': _tasks.length,
      'completed': completed.length,
      'failed': getTasksByStatus(TaskStatus.failed).length,
      'inProgress': getTasksByStatus(TaskStatus.inProgress).length,
      'results': completed.map((t) => {'id': t.id, 'name': t.name, 'result': t.result}).toList(),
    };
  }

  /// Register an agent
  void registerAgent(String agentId, String name, List<String> capabilities) {
    _agentStatus[agentId] = AgentStatus(
      agentId: agentId,
      name: name,
      capabilities: capabilities,
      status: AgentState.idle,
      lastUpdate: DateTime.now(),
    );
  }

  /// Update agent status
  void updateAgentStatus(String agentId, AgentState state) {
    final agent = _agentStatus[agentId];
    if (agent != null) {
      _agentStatus[agentId] = agent.copyWith(
        status: state,
        lastUpdate: DateTime.now(),
      );
    }
  }

  String _generateTaskId() {
    return 'task_${DateTime.now().millisecondsSinceEpoch}';
  }
}

enum TaskQueue { phases, parallel }

enum TaskType {
  identity,
  security,
  financial,
  p2p,
  communication,
  gaming,
  jobs,
  coordination,
  research,
}

enum TaskPriority { low, normal, high, critical }

enum TaskStatus { pending, inProgress, completed, failed }

enum AgentState { idle, busy, offline }

class Task {
  final String id;
  final String name;
  final String agentId;
  final TaskType type;
  final TaskPriority priority;
  final Map<String, dynamic> payload;
  final TaskStatus status;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? result;

  Task({
    required this.id,
    required this.name,
    required this.agentId,
    required this.type,
    required this.priority,
    required this.payload,
    required this.status,
    required this.createdAt,
    this.completedAt,
    this.result,
  });

  Task copyWith({
    String? id,
    String? name,
    String? agentId,
    TaskType? type,
    TaskPriority? priority,
    Map<String, dynamic>? payload,
    TaskStatus? status,
    DateTime? createdAt,
    DateTime? completedAt,
    String? result,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      agentId: agentId ?? this.agentId,
      type: type ?? this.type,
      priority: priority ?? this.priority,
      payload: payload ?? this.payload,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      result: result ?? this.result,
    );
  }
}

class AgentStatus {
  final String agentId;
  final String name;
  final List<String> capabilities;
  final AgentState status;
  final DateTime lastUpdate;

  AgentStatus({
    required this.agentId,
    required this.name,
    required this.capabilities,
    required this.status,
    required this.lastUpdate,
  });

  AgentStatus copyWith({
    String? agentId,
    String? name,
    List<String>? capabilities,
    AgentState? status,
    DateTime? lastUpdate,
  }) {
    return AgentStatus(
      agentId: agentId ?? this.agentId,
      name: name ?? this.name,
      capabilities: capabilities ?? this.capabilities,
      status: status ?? this.status,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }
}