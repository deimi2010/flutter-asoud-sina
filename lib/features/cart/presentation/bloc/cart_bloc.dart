import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:asood/core/http_client/api_client.dart';
import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/features/cart/data/data_source/cart_api_service.dart';
import 'package:asood/features/cart/domain/models/cart_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartApiService cartApiService;

  CartBloc({required this.cartApiService}) : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<AddItemToCart>(_onAddItemToCart);
    on<UpdateCartItem>(_onUpdateCartItem);
    on<RemoveCartItem>(_onRemoveCartItem);
    on<CheckoutCart>(_onCheckoutCart);
    on<ClearCart>(_onClearCart);
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final result = await cartApiService.getCart();
      if (result is Success) {
        final data = result.response;
        CartModel cart;
        
        if (data is Map && data.containsKey('success')) {
          cart = CartModel.fromJson(data['data'] ?? data);
        } else {
          cart = CartModel.fromJson(data);
        }
        
        emit(CartLoaded(cart: cart));
      } else if (result is Failure) {
        emit(CartError(message: result.errorResponse?.toString() ?? 'Failed to load cart'));
      }
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> _onAddItemToCart(AddItemToCart event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      emit(CartLoading());
    }
    
    try {
      final result = await cartApiService.addItem(event.data);
      if (result is Success) {
        add(LoadCart());
      } else if (result is Failure) {
        emit(CartError(message: result.errorResponse?.toString() ?? 'Failed to add item'));
        if (state is CartLoaded) {
          emit((state as CartLoaded).copyWith());
        }
      }
    } catch (e) {
      emit(CartError(message: e.toString()));
      if (state is CartLoaded) {
        emit((state as CartLoaded).copyWith());
      }
    }
  }

  Future<void> _onUpdateCartItem(UpdateCartItem event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      emit(CartLoading());
    }
    
    try {
      final result = await cartApiService.updateItem(event.itemId, event.data);
      if (result is Success) {
        add(LoadCart());
      } else if (result is Failure) {
        emit(CartError(message: result.errorResponse?.toString() ?? 'Failed to update item'));
        if (state is CartLoaded) {
          emit((state as CartLoaded).copyWith());
        }
      }
    } catch (e) {
      emit(CartError(message: e.toString()));
      if (state is CartLoaded) {
        emit((state as CartLoaded).copyWith());
      }
    }
  }

  Future<void> _onRemoveCartItem(RemoveCartItem event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      emit(CartLoading());
    }
    
    try {
      final result = await cartApiService.removeItem(event.itemId);
      if (result is Success) {
        add(LoadCart());
      } else if (result is Failure) {
        emit(CartError(message: result.errorResponse?.toString() ?? 'Failed to remove item'));
        if (state is CartLoaded) {
          emit((state as CartLoaded).copyWith());
        }
      }
    } catch (e) {
      emit(CartError(message: e.toString()));
      if (state is CartLoaded) {
        emit((state as CartLoaded).copyWith());
      }
    }
  }

  Future<void> _onCheckoutCart(CheckoutCart event, Emitter<CartState> emit) async {
    emit(CartCheckoutLoading());
    
    try {
      final result = await cartApiService.checkout(event.data);
      if (result is Success) {
        emit(CartCheckoutSuccess(message: result.message ?? 'Order placed successfully'));
        add(LoadCart());
      } else if (result is Failure) {
        emit(CartCheckoutError(message: result.errorResponse?.toString() ?? 'Checkout failed'));
      }
    } catch (e) {
      emit(CartCheckoutError(message: e.toString()));
    }
  }

  Future<void> _onClearCart(ClearCart event, Emitter<CartState> emit) async {
    emit(CartInitial());
  }
}

