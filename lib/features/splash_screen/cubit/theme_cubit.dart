import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:gamaverse/utils/theme/theme.dart';

part 'theme_cubit.g.dart';
part 'theme_state.dart';

class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(const ThemeState());

  @override
  ThemeState fromJson(Map<String, dynamic> json) => ThemeState.fromJson(json);

  @override
  Map<String, dynamic> toJson(state) => state.toJson();

  Future<void> fetchTheme() async {
    sleep(Duration(seconds: 5));
    print(state);
    emit(state.copyWith(appTheme: AppTheme.dark, status: ThemeStatus.success));
    // print(state);
    // sleep(Duration(seconds: 2));
    // emit(state.copyWith(appTheme: AppTheme.light, status: ThemeStatus.initial));
    // print(state);
    // sleep(Duration(seconds: 2));
    // emit(state.copyWith(appTheme: AppTheme.light, status: ThemeStatus.success));
    // print(state);
    // // print(state);
    // emit(state.copyWith(appTheme: AppTheme.light, status: ThemeStatus.success));
    // print(state);
  }

  @override
  void onChange(Change<ThemeState> change) {
    super.onChange(change);
    print(change);
  }
}
