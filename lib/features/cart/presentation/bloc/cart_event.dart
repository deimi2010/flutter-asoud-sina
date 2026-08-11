part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class LoadCart extends CartEvent {
  const LoadCart();
}

class AddItemToCart extends CartEvent {
  final Map<String, dynamic> data;

  const AddItemToCart(this.data);

  @override
  List<Object?> get props => [data];
}

class UpdateCartItem extends CartEvent {
  final String itemId;
  final Map<String, dynamic> data;

  const UpdateCartItem(this.itemId, this.data);

  @override
  List<Object?> get props => [itemId, data];
}

class RemoveCartItem extends CartEvent {
  final String itemId;

  const RemoveCartItem(this.itemId);

  @override
  List<Object?> get props => [itemId];
}

class CheckoutCart extends CartEvent {
  final Map<String, dynamic> data;

  const CheckoutCart(this.data);

  @override
  List<Object?> get props => [data];
}

class ClearCart extends CartEvent {
  const ClearCart();
}

