import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:gamaverse/features/splash_screen/views/splash_screen.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  return HydratedBlocOverrides.runZoned(
    () => runApp(const SplashScreen()),
    storage: storage,
  );
}
