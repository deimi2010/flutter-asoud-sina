import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/core/models/market_model.dart';
import 'package:asood/features/create_workspace/domain/repository/create_market_repository.dart';
import 'package:bloc/bloc.dart';

part 'workspace_event.dart';
part 'workspace_state.dart';

class WorkspaceBloc extends Bloc<WorkspaceEvent, WorkspaceState> {
  final CreateMarketRepository marketRepo;

  WorkspaceBloc(this.marketRepo) : super(WorkspaceState.initial()) {
    on<LoadStores>(_getStores);
    on<ChangeTabView>(_changeActiveTab);

    on<ShowInvoice>(_changeInvoiceView);
    on<InvoiceOption>(_invoiceOptionView);
    on<InvoiceConfirm>(_invoiceConfirmView);

    on<SelectMarket>(_selectMarket);
    on<GetProducts>(_getProducts);
    on<ContactUs>(_contactUs);
    on<GetComments>(_getComments);
    on<GetSpecialProducts>(_getSpecialProducts);
    on<GetDiscounts>(_getDiscounts);
    on<DeleteDiscount>(_deleteDiscount);
    on<CreateDiscount>(_createDiscount);
    on<ChangeColorAndFont>(_changeColorAndFont);
    on<ChangeProductTheme>(_changeProductTheme);
    on<ChangeThemeColors>(_changeThemeColors);
    on<EditeWorkSpaceInfo>(_editeWorkSpaceInfo);
  }

  _changeActiveTab(ChangeTabView event, Emitter<WorkspaceState> emit) async {
    emit(state.copyWith(activeTabIndex: event.activeTabIndex));
  }

  _changeInvoiceView(ShowInvoice event, Emitter<WorkspaceState> emit) async {
    emit(state.copyWith(showInvoice: event.isShow));
  }

  _invoiceOptionView(InvoiceOption event, Emitter<WorkspaceState> emit) async {
    emit(state.copyWith(invoiceOption: event.option));
  }

  _invoiceConfirmView(
    InvoiceConfirm event,
    Emitter<WorkspaceState> emit,
  ) async {
    emit(state.copyWith(invoiceConfirm: event.isConfirm));
  }

  _getStores(LoadStores event, Emitter<WorkspaceState> emit) async {
    emit(state.copyWith(status: CWSStatus.loading));
    try {
      final res = await marketRepo.getMarketList();
      if (res is Success) {
        final initList = res.response as List;
        final storesList =
            initList.map((e) => MarketModel.fromJson(e)).toList();
        emit(state.copyWith(status: CWSStatus.success, storesList: storesList));
      } else {
        emit(state.copyWith(status: CWSStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(status: CWSStatus.failure));
    }
  }

  _selectMarket(SelectMarket event, Emitter<WorkspaceState> emit) {
    emit(state.copyWith(selectedMarket: event.marketId));
  }

  _getProducts(GetProducts event, Emitter<WorkspaceState> emit) {
    emit(state.copyWith(status: CWSStatus.loading));
    try {
      final res = Success();
      emit(state.copyWith(status: CWSStatus.success));
    } catch (e) {
      emit(state.copyWith(status: CWSStatus.failure));
    }
  }

  _contactUs(ContactUs event, Emitter<WorkspaceState> emit) {
    emit(state.copyWith(status: CWSStatus.loading));
    try {
      final res = Success();
      emit(state.copyWith(status: CWSStatus.success));
    } catch (e) {
      emit(state.copyWith(status: CWSStatus.failure));
    }
  }

  _getComments(GetComments event, Emitter<WorkspaceState> emit) {
    emit(state.copyWith(status: CWSStatus.loading));
    try {
      final res = Success();
      emit(state.copyWith(status: CWSStatus.success));
    } catch (e) {
      emit(state.copyWith(status: CWSStatus.failure));
    }
  }

  _getSpecialProducts(GetSpecialProducts event, Emitter<WorkspaceState> emit) {
    emit(state.copyWith(status: CWSStatus.loading));
    try {
      final res = Success();
      emit(state.copyWith(status: CWSStatus.success));
    } catch (e) {
      emit(state.copyWith(status: CWSStatus.failure));
    }
  }

  _getDiscounts(GetDiscounts event, Emitter<WorkspaceState> emit) {
    emit(state.copyWith(status: CWSStatus.loading));
    try {
      final res = Success();
      emit(state.copyWith(status: CWSStatus.success));
    } catch (e) {
      emit(state.copyWith(status: CWSStatus.failure));
    }
  }

  _deleteDiscount(DeleteDiscount event, Emitter<WorkspaceState> emit) {
    emit(state.copyWith(status: CWSStatus.loading));
    try {
      final res = Success();
      emit(state.copyWith(status: CWSStatus.success));
    } catch (e) {
      emit(state.copyWith(status: CWSStatus.failure));
    }
  }

  _createDiscount(CreateDiscount event, Emitter<WorkspaceState> emit) {
    emit(state.copyWith(status: CWSStatus.loading));
    try {
      final res = Success();
      emit(state.copyWith(status: CWSStatus.success));
    } catch (e) {
      emit(state.copyWith(status: CWSStatus.failure));
    }
  }

  _changeColorAndFont(ChangeColorAndFont event, Emitter<WorkspaceState> emit) {
    emit(state.copyWith(status: CWSStatus.loading));
    try {
      final res = Success();
      emit(state.copyWith(status: CWSStatus.success));
    } catch (e) {
      emit(state.copyWith(status: CWSStatus.failure));
    }
  }

  _editeWorkSpaceInfo(EditeWorkSpaceInfo event, Emitter<WorkspaceState> emit) {
    emit(state.copyWith(status: CWSStatus.loading));
    try {
      final res = Success();
      emit(state.copyWith(status: CWSStatus.success));
    } catch (e) {
      emit(state.copyWith(status: CWSStatus.failure));
    }
  }

  _changeProductTheme(ChangeProductTheme event, Emitter<WorkspaceState> emit) {
    emit(state.copyWith(status: CWSStatus.loading));
    try {
      final res = Success();
      emit(state.copyWith(status: CWSStatus.success));
    } catch (e) {
      emit(state.copyWith(status: CWSStatus.failure));
    }
  }

  _changeThemeColors(ChangeThemeColors event, Emitter<WorkspaceState> emit) {
    emit(state.copyWith(status: CWSStatus.loading));
    try {
      final res = Success();
      emit(state.copyWith(status: CWSStatus.success));
    } catch (e) {
      emit(state.copyWith(status: CWSStatus.failure));
    }
  }
}
