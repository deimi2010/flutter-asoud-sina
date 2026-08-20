import 'package:asood/features/create_workspace/domain/entities/workspace_draft.dart';

abstract interface class WorkspaceDraftRepository {
  Future<WorkspaceDraft?> load({String? marketId});
  Future<void> save(WorkspaceDraft draft, {String? marketId});
  Future<void> clear({String? marketId});
}
