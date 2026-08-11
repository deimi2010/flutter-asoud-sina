part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final CartModel cart;

  const CartLoaded({required this.cart});

  CartLoaded copyWith({
    CartModel? cart,
  }) {
    return CartLoaded(
      cart: cart ?? this.cart,
    );
  }

  @override
  List<Object?> get props => [cart];
}

class CartError extends CartState {
  final String message;

  const CartError({required this.message});

  @override
  List<Object?> get props => [message];
}

class CartCheckoutLoading extends CartState {}

class CartCheckoutSuccess extends CartState {
  final String message;

  const CartCheckoutSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class CartCheckoutError extends CartState {
  final String message;

  const CartCheckoutError({required this.message});

  @override
  List<Object?> get props => [message];
}

