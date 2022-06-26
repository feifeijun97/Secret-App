part of 'comic_bloc.dart';

enum ComicStatus { initial, loading, success, failure }

class ComicState extends Equatable {
  final ComicStatus status;
  final List<Comic> comics;
  final String nextEpisodId;
  final String prevEpisodId;
  final bool hasReachedFirst;
  final bool hasReachedLast;
  //store accumulate pages of all comic, use to find respective chapter in listview.
  final List<int> pageCountList;

  const ComicState({
    this.status = ComicStatus.initial,
    this.comics = const [],
    this.nextEpisodId = '',
    this.prevEpisodId = '',
    this.hasReachedFirst = false,
    this.hasReachedLast = false,
    this.pageCountList = const [],
  });

  ComicState copyWith({
    ComicStatus? status,
    List<Comic>? comics,
    String? nextEpisodId,
    String? prevEpisodId,
    bool? hasReachedFirst,
    bool? hasReachedLast,
    List<int>? pageCountList,
  }) {
    return ComicState(
      status: status ?? this.status,
      comics: comics ?? this.comics,
      nextEpisodId: nextEpisodId ?? this.nextEpisodId,
      prevEpisodId: prevEpisodId ?? this.prevEpisodId,
      hasReachedFirst: hasReachedFirst ?? this.hasReachedFirst,
      hasReachedLast: hasReachedLast ?? this.hasReachedLast,
      pageCountList: pageCountList ?? this.pageCountList,
    );
  }

  @override
  List<Object> get props => [
        status,
        comics,
        nextEpisodId,
        prevEpisodId,
        hasReachedFirst,
        hasReachedLast,
        pageCountList,
      ];
}
