import 'package:asood/features/create_workspace/domain/entities/workspace_draft.dart';

abstract interface class WorkspaceDraftRepository {
  Future<WorkspaceDraft?> load();
  Future<void> save(WorkspaceDraft draft);
  Future<void> clear();
}
