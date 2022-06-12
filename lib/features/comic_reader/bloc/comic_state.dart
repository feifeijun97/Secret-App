part of 'comic_bloc.dart';

enum ComicStatus { initial, loading, success, failure }

class ComicState extends Equatable {
  final ComicStatus status;
  final Comic comic;
  final bool isFirstEpisod;
  final bool isLastEpisod;

  const ComicState({
    this.status = ComicStatus.initial,
    this.comic = const Comic(),
    this.isFirstEpisod = false,
    this.isLastEpisod = false,
  });

  ComicState copyWith(
      {ComicStatus? status,
      Comic? comic,
      bool? isFirstEpisod,
      bool? isLastEpisod}) {
    return ComicState(
      status: status ?? this.status,
      comic: comic ?? this.comic,
      isFirstEpisod: isFirstEpisod ?? this.isFirstEpisod,
      isLastEpisod: isLastEpisod ?? this.isLastEpisod,
    );
  }

  @override
  List<Object> get props => [status, comic, isFirstEpisod, isLastEpisod];
}
