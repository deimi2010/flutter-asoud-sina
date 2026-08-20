class WorkspaceDraft {
  const WorkspaceDraft({
    required this.currentStep,
    required this.completedSteps,
    required this.values,
    required this.socialLinks,
    required this.schedules,
  });

  final int currentStep;
  final Set<int> completedSteps;
  final Map<String, String> values;
  final Map<String, String> socialLinks;
  final List<WorkspaceSchedule> schedules;
}

class WorkspaceSchedule {
  const WorkspaceSchedule({
    required this.day,
    required this.intervalIndex,
    required this.start,
    this.end,
  });

  final String day;
  final int intervalIndex;
  final String start;
  final String? end;
}
