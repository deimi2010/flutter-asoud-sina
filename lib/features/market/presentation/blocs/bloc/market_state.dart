part of 'market_bloc.dart';

class MarketState {
  final CWSStatus status;
  final List<TemplateModel> templateList;
  final bool showTemplates;
  final int templateIndex;
  final String marketId;
  final bool templatePendingSync;

  const MarketState({
    required this.status,
    required this.templateList,
    required this.showTemplates,
    required this.templateIndex,
    required this.marketId,
    required this.templatePendingSync,
  });

  factory MarketState.initial() {
    return const MarketState(
      status: CWSStatus.initial,
      templateList: [],
      showTemplates: false,
      templateIndex: 0,
      marketId: '',
      templatePendingSync: false,
    );
  }

  MarketState copyWith({
    CWSStatus? status,
    List<TemplateModel>? templateList,
    bool? showTemplates,
    int? templateIndex,
    String? marketId,
    bool? templatePendingSync,
  }) {
    return MarketState(
      status: status ?? this.status,
      templateList: templateList ?? this.templateList,
      showTemplates: showTemplates ?? this.showTemplates,
      templateIndex: templateIndex ?? this.templateIndex,
      marketId: marketId ?? this.marketId,
      templatePendingSync: templatePendingSync ?? this.templatePendingSync,
    );
  }
}
