import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gamaverse/features/splash_screen/cubit/theme_cubit.dart';
import 'package:gamaverse/utils/theme/theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: const SplashScreenView(),
    );
  }
}

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ThemeCubit>().fetchTheme();

    return BlocConsumer<ThemeCubit, ThemeState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          //TODO: navigate
        }
      },
      builder: (context, state) {
        if (state.status.isFailure) {
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(SnackBar(content: Text(state.appTheme.name)));
          //TODO: show error and quit
        }
        return MaterialApp(
          theme: appThemeData[state.appTheme],
          home: Scaffold(
            body: Center(child: Text(state.appTheme.name)),
          ),
        );
      },
    );
  }
}
