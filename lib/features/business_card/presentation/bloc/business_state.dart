part of 'business_bloc.dart';

class BusinessState {
  const BusinessState({
    required this.status,
    required this.location,
    required this.isSelected,
    required this.message,
  });

  final CWSStatus status;
  final LatLng location;
  final bool isSelected;
  final String message;

  factory BusinessState.initial() {
    return const BusinessState(
      status: CWSStatus.initial,
      location: LatLng(0, 0),
      isSelected: false,
      message: '',
    );
  }

  BusinessState copyWith({
    CWSStatus? status,
    LatLng? location,
    bool? isSelected,
    String? message,
  }) {
    return BusinessState(
      status: status ?? this.status,

      location: location ?? this.location,
      isSelected: isSelected ?? this.isSelected,
      message: message ?? this.message,
    );
  }
}
