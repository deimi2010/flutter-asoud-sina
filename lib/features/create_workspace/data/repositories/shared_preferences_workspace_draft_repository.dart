import 'dart:convert';

import 'package:asood/features/create_workspace/domain/entities/workspace_draft.dart';
import 'package:asood/features/create_workspace/domain/repositories/workspace_draft_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesWorkspaceDraftRepository
    implements WorkspaceDraftRepository {
  static const _storageKey = 'create_workspace_draft_v1';

  @override
  Future<WorkspaceDraft?> load() async {
    final preferences = await SharedPreferences.getInstance();
    final encoded = preferences.getString(_storageKey);
    if (encoded == null || encoded.isEmpty) return null;

    try {
      final json = jsonDecode(encoded) as Map<String, dynamic>;
      final values = Map<String, String>.from(
        json['values'] as Map<String, dynamic>? ?? const {},
      );
      final socialLinks = Map<String, String>.from(
        json['social_links'] as Map<String, dynamic>? ?? const {},
      );
      final schedules = (json['schedules'] as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(
            (item) => WorkspaceSchedule(
              day: item['day'] as String? ?? '',
              intervalIndex: item['interval_index'] as int? ?? 1,
              start: item['start'] as String? ?? '',
              end: item['end'] as String?,
            ),
          )
          .where((item) => item.day.isNotEmpty && item.start.isNotEmpty)
          .toList(growable: false);

      return WorkspaceDraft(
        currentStep: json['current_step'] as int? ?? 0,
        completedSteps: (json['completed_steps'] as List<dynamic>? ?? const [])
            .whereType<int>()
            .toSet(),
        values: values,
        socialLinks: socialLinks,
        schedules: schedules,
      );
    } on FormatException {
      await clear();
      return null;
    } on TypeError {
      await clear();
      return null;
    }
  }

  @override
  Future<void> save(WorkspaceDraft draft) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(
      _storageKey,
      jsonEncode({
        'current_step': draft.currentStep,
        'completed_steps': draft.completedSteps.toList()..sort(),
        'values': draft.values,
        'social_links': draft.socialLinks,
        'schedules': draft.schedules
            .map(
              (item) => {
                'day': item.day,
                'interval_index': item.intervalIndex,
                'start': item.start,
                if (item.end != null) 'end': item.end,
              },
            )
            .toList(growable: false),
      }),
    );
  }

  @override
  Future<void> clear() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_storageKey);
  }
}
