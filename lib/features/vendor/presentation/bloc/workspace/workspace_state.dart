part of 'workspace_bloc.dart';

class WorkspaceState {
  final CWSStatus status;
  final List<MarketModel> storesList;
  final int? selectedMarket;

  final int activeTabIndex;

  final bool showInvoice;
  final int invoiceOption;
  final bool invoiceConfirm;

  const WorkspaceState({
    required this.status,
    required this.storesList,
    this.selectedMarket,

    required this.activeTabIndex,

    required this.showInvoice,
    required this.invoiceOption,
    required this.invoiceConfirm,
  });

  factory WorkspaceState.initial() {
    return const WorkspaceState(
      status: CWSStatus.initial,
      storesList: [],
      activeTabIndex: 0,

      showInvoice: false,
      invoiceOption: -1,
      invoiceConfirm: false,
    );
  }

  WorkspaceState copyWith({
    CWSStatus? status,
    List<MarketModel>? storesList,
    int? selectedMarket,

    int? activeTabIndex,

    bool? showInvoice,
    int? invoiceOption,
    bool? invoiceConfirm,
  }) {
    return WorkspaceState(
      status: status ?? this.status,
      storesList: storesList ?? this.storesList,
      selectedMarket: selectedMarket ?? this.selectedMarket,

      activeTabIndex: activeTabIndex ?? this.activeTabIndex,

      showInvoice: showInvoice ?? this.showInvoice,
      invoiceOption: invoiceOption ?? this.invoiceOption,
      invoiceConfirm: invoiceConfirm ?? this.invoiceConfirm,
    );
  }

  @override
  List<Object> get props => [
    status,
    storesList,
    activeTabIndex,
    showInvoice,
    invoiceOption,
    invoiceConfirm,
  ];
}
