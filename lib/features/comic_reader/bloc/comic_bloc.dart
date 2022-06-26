import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gamaverse/features/comic_reader/model/comic.dart';

part 'comic_event.dart';
part 'comic_state.dart';

class ComicBloc extends Bloc<ComicEvent, ComicState> {
  ComicBloc() : super(const ComicState()) {
    on<FetchComic>(_onFetchComic);
  }

  Future<void> _onFetchComic(FetchComic event, Emitter<ComicState> emit) async {
    if (state.hasReachedFirst || state.hasReachedLast) return;

    emit(state.copyWith(status: ComicStatus.loading));

    try {
      final comic = await Comic.getComic(event.id);
      switch (event.direction) {
        case FetchDirection.next:
          return emit(state.copyWith(
            status: ComicStatus.success,
            comics: List.of(state.comics)..add(comic),
            nextEpisodId: comic.nextId,
            hasReachedLast: comic.nextId.isEmpty,
            pageCountList: List.of(state.pageCountList)
              ..add(state.pageCountList
                      .reduce((value, element) => value + element) +
                  comic.pageCount),
          ));
        case FetchDirection.previous:
          return emit(state.copyWith(
              status: ComicStatus.success,
              comics: [comic, ...state.comics],
              prevEpisodId: comic.prevId,
              hasReachedFirst: comic.prevId.isEmpty,
              pageCountList: [
                comic.pageCount,
                ...state.pageCountList.map((e) => e + comic.pageCount).toList()
              ]));
        default:
          return emit(state.copyWith(
              status: ComicStatus.success,
              comics: [comic],
              prevEpisodId: comic.prevId,
              nextEpisodId: comic.nextId,
              hasReachedFirst: comic.prevId.isEmpty,
              hasReachedLast: comic.nextId.isEmpty,
              pageCountList: [comic.pageCount]));
      }
    } catch (_) {
      return emit(state.copyWith(
        status: ComicStatus.failure,
      ));
    }
  }
}
