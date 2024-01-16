import 'package:biz_invoice/shared/routing/app_router.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<AppRouter>(AppRouter());
}
