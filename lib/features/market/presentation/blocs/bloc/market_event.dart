part of 'market_bloc.dart';

sealed class MarketEvent {
  const MarketEvent();
}

class AddTemplateEvent extends MarketEvent {
  final String marketId;
  final int template;

  const AddTemplateEvent({required this.marketId, required this.template});
}

class ShowTemplatesEvent extends MarketEvent {
  final bool isShow;

  const ShowTemplatesEvent({required this.isShow});
}

class ChangeTemplateEvent extends MarketEvent {
  final int template;

  const ChangeTemplateEvent({required this.template});
}

class LoadTemplateEvent extends MarketEvent {
  final String marketId;

  const LoadTemplateEvent({required this.marketId});
}

class RemoveTemplateEvent extends MarketEvent {
  final int index;

  const RemoveTemplateEvent({required this.index});
}
