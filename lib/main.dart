import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:gamaverse/features/splash_screen/views/splash_screen.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  return HydratedBlocOverrides.runZoned(
    () => runApp(EasyLocalization(
        path: 'assets/translations',
        supportedLocales: const [Locale('en', 'US'), Locale('zh', 'CN')],
        fallbackLocale: const Locale('en', 'US'),
        child: const SplashScreen())),
    storage: storage,
  );
}
