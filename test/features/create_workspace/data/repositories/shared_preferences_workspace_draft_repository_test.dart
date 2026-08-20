import 'package:asood/features/create_workspace/data/repositories/shared_preferences_workspace_draft_repository.dart';
import 'package:asood/features/create_workspace/domain/entities/workspace_draft.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('saves and restores both working intervals for a day', () async {
    final repository = SharedPreferencesWorkspaceDraftRepository();
    const draft = WorkspaceDraft(
      currentStep: 1,
      completedSteps: {0},
      values: {'businessId': 'my-shop'},
      socialLinks: {'instagram': 'my_shop'},
      schedules: [
        WorkspaceSchedule(
          day: '1',
          intervalIndex: 1,
          start: '08:00',
          end: '12:00',
        ),
        WorkspaceSchedule(
          day: '1',
          intervalIndex: 2,
          start: '14:00',
          end: '18:00',
        ),
      ],
    );

    await repository.save(draft);
    final restored = await repository.load();

    expect(restored?.currentStep, 1);
    expect(restored?.completedSteps, {0});
    expect(restored?.values['businessId'], 'my-shop');
    expect(restored?.socialLinks['instagram'], 'my_shop');
    expect(restored?.schedules, hasLength(2));
    expect(restored?.schedules[0].intervalIndex, 1);
    expect(restored?.schedules[1].intervalIndex, 2);
  });
}
