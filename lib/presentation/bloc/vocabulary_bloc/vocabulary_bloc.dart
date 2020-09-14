import 'dart:async';

import 'package:english_app/domain/entities/word_entity.dart';
import 'package:english_app/domain/repository/i_vocabulary_repository.dart';
import 'package:english_app/domain/use_cases/get_words.dart';
import 'package:english_app/injector.dart';
import 'package:english_app/presentation/bloc/i_bloc.dart';
import 'package:english_app/presentation/bloc/vocabulary_bloc/vocabulary_bloc_event.dart';
import 'package:english_app/presentation/bloc/vocabulary_bloc/vocabulary_bloc_state.dart';
import 'package:rxdart/rxdart.dart';

class VocabularyBloc extends IBloc {
  VocabularyBloc() {
    _eventStream.listen(_handleEvents);
  }

  final words = <WordEntity>[];
  final _eventStreamController = BehaviorSubject<VocabularyBlocEvent>();
  Stream<VocabularyBlocEvent> get _eventStream => _eventStreamController.stream;
  Sink<VocabularyBlocEvent> get eventSink => _eventStreamController.sink;
  final _stateStreamController = BehaviorSubject<VocabularyBlocState>();
  Stream<VocabularyBlocState> get stateStream => _stateStreamController.stream;
  Sink<VocabularyBlocState> get _stateSink => _stateStreamController.sink;

  Future<void> _handleEvents(VocabularyBlocEvent event) async {
    if (event is LoadWords) {
      await _loadWords();
      _stateSink.add(WordsLoaded(words: words));
    }
  }

  Future<void> _loadWords() async {
    if (words.isNotEmpty) {
      words.clear();
    }
    words.addAll(
        await GetWords(vocabularyRepository: getIt<IVocabularyRepository>())
            .execute());
  }

  @override
  void dispose() {
    _eventStreamController.close();
    _stateStreamController.close();
  }
}
