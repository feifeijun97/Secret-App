part of 'comic_bloc.dart';

abstract class ComicEvent extends Equatable {
  const ComicEvent();

  @override
  List<Object> get props => [];
}

class FetchComic extends ComicEvent {
  final String id;

  const FetchComic({required this.id});

  @override
  List<Object> get props => [id];
}
