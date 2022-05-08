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
    emit(state.copyWith(appTheme: AppTheme.dark, status: ThemeStatus.success));
  }
}
