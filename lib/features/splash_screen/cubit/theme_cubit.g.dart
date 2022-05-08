// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThemeState _$ThemeStateFromJson(Map<String, dynamic> json) => ThemeState(
      appTheme: $enumDecodeNullable(_$AppThemeEnumMap, json['appTheme']),
      status: $enumDecodeNullable(_$ThemeStatusEnumMap, json['status']) ??
          ThemeStatus.initial,
    );

Map<String, dynamic> _$ThemeStateToJson(ThemeState instance) =>
    <String, dynamic>{
      'appTheme': _$AppThemeEnumMap[instance.appTheme],
      'status': _$ThemeStatusEnumMap[instance.status],
    };

const _$AppThemeEnumMap = {
  AppTheme.light: 'light',
  AppTheme.dark: 'dark',
};

const _$ThemeStatusEnumMap = {
  ThemeStatus.initial: 'initial',
  ThemeStatus.loading: 'loading',
  ThemeStatus.success: 'success',
  ThemeStatus.failure: 'failure',
};
