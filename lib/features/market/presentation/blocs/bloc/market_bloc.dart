import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/core/helper/market_customization_storage.dart';
import 'package:asood/features/market/data/model/market_model.dart';
import 'package:asood/features/market/domain/repository/product_repository.dart';
import 'package:bloc/bloc.dart';

part 'market_event.dart';
part 'market_state.dart';

class MarketBloc extends Bloc<MarketEvent, MarketState> {
  final ProductRepository productRepository;
  MarketBloc({required this.productRepository}) : super(MarketState.initial()) {
    on<MarketEvent>((event, emit) {});

    on<AddTemplateEvent>(_addTemplate);
    on<ChangeTemplateEvent>(_changeTemplate);
    on<LoadTemplateEvent>(_loadTemplate);
    on<RemoveTemplateEvent>(_removeTemplate);
    on<ShowTemplatesEvent>(_showTemplates);
  }

  _addTemplate(AddTemplateEvent event, Emitter<MarketState> emit) async {
    emit(
      state.copyWith(
        status: CWSStatus.loading,
        templateIndex: event.template,
        marketId: event.marketId,
      ),
    );
    await MarketCustomizationStorage.saveTemplateIndex(
      event.marketId,
      event.template,
      pendingSync: true,
    );
    try {
      final res = await productRepository.createMarketTheme(
        event.marketId,
        event.template,
      );

      if (res is Success) {
        await MarketCustomizationStorage.saveTemplateIndex(
          event.marketId,
          event.template,
          pendingSync: false,
        );

        /// لود تم وقتی سیو انجام شد
        await _loadTemplate(LoadTemplateEvent(marketId: event.marketId), emit);
        return;
      } else {
        emit(
          state.copyWith(
            status: CWSStatus.success,
            showTemplates: false,
            templatePendingSync: true,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: CWSStatus.success,
          showTemplates: false,
          templatePendingSync: true,
        ),
      );
    }
  }

  _loadTemplate(LoadTemplateEvent event, Emitter<MarketState> emit) async {
    emit(state.copyWith(status: CWSStatus.loading));
    final localTemplate = await MarketCustomizationStorage.loadTemplateIndex(
      event.marketId,
    );
    final pendingSync = await MarketCustomizationStorage.isTemplatePending(
      event.marketId,
    );
    var stillPending = pendingSync;
    if (localTemplate != null) {
      emit(
        state.copyWith(
          templateIndex: localTemplate,
          marketId: event.marketId,
          templatePendingSync: pendingSync,
        ),
      );
    }
    try {
      if (localTemplate != null && pendingSync) {
        final syncResult = await productRepository.createMarketTheme(
          event.marketId,
          localTemplate,
        );
        if (syncResult is Success) {
          await MarketCustomizationStorage.saveTemplateIndex(
            event.marketId,
            localTemplate,
            pendingSync: false,
          );
          stillPending = false;
        }
      }
      final res = await productRepository.getMarketTheme(event.marketId);

      if (res is Success) {
        final initList = res.response as List<dynamic>;
        final templateList =
            initList.map((e) => TemplateModel.fromJson(e)).toList();
        print("----------------------------------------");
        print(templateList);
        emit(
          state.copyWith(
            status: CWSStatus.success,
            templateList: templateList,
            marketId: event.marketId,
            showTemplates: false,
            templatePendingSync: stillPending,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status:
                localTemplate == null ? CWSStatus.failure : CWSStatus.success,
            marketId: event.marketId,
            templatePendingSync: stillPending,
          ),
        );
      }
    } catch (e) {
      print("exeeeeeeeeeeeeeeeeeeeeeeeeee");
      print(e.toString());
      emit(
        state.copyWith(
          status: localTemplate == null ? CWSStatus.failure : CWSStatus.success,
          marketId: event.marketId,
          templatePendingSync: stillPending,
        ),
      );
    }
  }

  _changeTemplate(ChangeTemplateEvent event, Emitter<MarketState> emit) {
    emit(state.copyWith(templateIndex: event.template));
  }

  _removeTemplate(RemoveTemplateEvent event, Emitter<MarketState> emit) {
    state.templateList.removeAt(event.index);
    // print(state.templateList);
    emit(state.copyWith(templateList: state.templateList));
  }

  _showTemplates(ShowTemplatesEvent event, Emitter<MarketState> emit) {
    emit(state.copyWith(showTemplates: event.isShow));
  }
}
