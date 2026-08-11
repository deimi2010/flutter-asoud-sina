part of 'customer_bloc.dart';

class CustomerState {
  final CWSStatus status;
  final List<MarketModel>? markets;
  final List<CustomerReqModel>? request;
  final List? orders;
  const CustomerState({
    required this.status,
    this.markets,
    this.request,
    this.orders,
  });

  factory CustomerState.initial() => const CustomerState(
    status: CWSStatus.initial,
    markets: [],
    request: [],
    orders: [],
  );

  CustomerState copyWith({
    CWSStatus? status,
    List<MarketModel>? markets,
    List<CustomerReqModel>? request,
    List? orders,
  }) {
    return CustomerState(
      status: status ?? this.status,
      markets: markets ?? this.markets,
      request: request ?? this.request,
      orders: orders ?? this.orders,
    );
  }
}
