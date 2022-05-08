part of 'theme_cubit.dart';

enum ThemeStatus { initial, loading, success, failure }

extension ThemeStatusX on ThemeStatus {
  bool get isInitial => this == ThemeStatus.initial;
  bool get isLoading => this == ThemeStatus.loading;
  bool get isSuccess => this == ThemeStatus.success;
  bool get isFailure => this == ThemeStatus.failure;
}

@JsonSerializable()
class ThemeState extends Equatable {
  final AppTheme appTheme;
  final ThemeStatus status;

  const ThemeState({AppTheme? appTheme, this.status = ThemeStatus.initial})
      : appTheme = appTheme ?? AppTheme.light;

  ThemeState copyWith({AppTheme? appTheme, ThemeStatus? status}) {
    return ThemeState(
      appTheme: appTheme ?? this.appTheme,
      status: status ?? this.status,
    );
  }

  factory ThemeState.fromJson(Map<String, dynamic> json) =>
      _$ThemeStateFromJson(json);
  Map<String, dynamic> toJson() => _$ThemeStateToJson(this);

  @override
  List<Object?> get props => [appTheme, status];
}
