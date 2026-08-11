import 'package:asood/app/di/auth_module.dart';
import 'package:asood/app/di/commerce_module.dart';
import 'package:asood/app/di/core_module.dart';
import 'package:asood/app/di/market_module.dart';
import 'package:asood/app/di/presentation_module.dart';
import 'package:asood/app/di/workspace_module.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

Future<void> locatorSetup() async {
  registerCoreModule(locator);
  registerAuthModule(locator);
  registerWorkspaceModule(locator);
  registerMarketModule(locator);
  registerCommerceModule(locator);
  registerPresentationModule(locator);
}
