import 'package:asood/features/business_card/presentation/bloc/business_bloc.dart';
import 'package:asood/features/customer/presentation/blocs/customer/customer_bloc.dart';
import 'package:asood/features/customer/presentation/blocs/profile/profile_bloc.dart';
import 'package:asood/features/product/blocs/product_bloc.dart';
import 'package:asood/features/splash/blocs/splash_bloc.dart';
import 'package:get_it/get_it.dart';

void registerPresentationModule(GetIt locator) {
  locator.registerFactory(SplashBloc.new);
  locator.registerFactory(BusinessBloc.new);
  locator.registerFactory(ProfileBloc.new);
  locator.registerFactory(CustomerBloc.new);
  locator.registerFactory(ProductBloc.new);
}
