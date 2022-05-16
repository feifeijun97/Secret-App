import 'package:easy_localization/easy_localization.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gamaverse/features/splash_screen/cubit/theme_cubit.dart';
import 'package:gamaverse/utils/routers/fluro_application.dart';
import 'package:gamaverse/utils/routers/router.dart';
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

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  _SplashScreenViewState() {
    final router = FluroRouter();
    Routers.configureRoutes(router);
    FluroApplication.router = router;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => context.read<ThemeCubit>().fetchTheme());
    // print('asdf');
    // print(context.read<ThemeCubit>().state);
    // context.read<ThemeCubit>().fetchTheme();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeCubit, ThemeState>(
      listener: (context, state) {
        print(state);
        if (state.status.isSuccess) {
          // print('asdf');
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(SnackBar(content: Text(state.appTheme.name)));
          print('qwerqwer');

          // FluroApplication.router.navigateTo(
          //   context,
          //   'comic_reader',
          // );
        } else {
          print('zxcv');
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(SnackBar(content: Text(state.appTheme.name)));
        }
      },
      builder: (context, state) {
        if (state.status.isFailure) {
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(SnackBar(content: Text(state.appTheme.name)));
          //TODO: show error and quit
        }
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: appThemeData[state.appTheme],
          onGenerateRoute: FluroApplication.router.generator,
          home: Scaffold(
            backgroundColor: Colors.black,
            body: Center(
                child: Image(image: AssetImage('assets/images/logo.png'))),
          ),
        );
      },
    );
  }
}
