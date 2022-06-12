import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gamaverse/features/comic_reader/model/comic.dart';

part 'comic_event.dart';
part 'comic_state.dart';

class ComicBloc extends Bloc<ComicEvent, ComicState> {
  ComicBloc() : super(const ComicState()) {
    on<ComicEvent>((event, emit) {
      on<FetchComic>(_onFetchComic);
    });
  }

  Future<void> _onFetchComic(FetchComic event, Emitter<ComicState> emit) async {
    if (state.isFirstEpisod || state.isLastEpisod) return;

    emit(state.copyWith(status: ComicStatus.loading));

    try {
      final comic = await Comic.getComic(event.id);
      return emit(state.copyWith(
        status: ComicStatus.success,
        comic: comic,
        isFirstEpisod: false,
        isLastEpisod: false,
      ));
    } catch (_) {
      return emit(state.copyWith(
        status: ComicStatus.failure,
      ));
    }
  }
}
