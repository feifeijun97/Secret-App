part of 'comic_bloc.dart';

enum FetchDirection { current, next, previous }

abstract class ComicEvent extends Equatable {
  const ComicEvent();

  @override
  List<Object> get props => [];
}

class FetchComic extends ComicEvent {
  final String id;
  final FetchDirection direction;

  const FetchComic({required this.id, this.direction = FetchDirection.current});

  @override
  List<Object> get props => [id, direction];
}
