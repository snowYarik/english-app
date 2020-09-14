import 'dart:math';

import 'package:english_app/domain/entities/word_entity.dart';
import 'package:english_app/domain/entities/word_status.dart';
import 'package:english_app/domain/repository/i_vocabulary_repository.dart';
import 'package:english_app/domain/use_cases/get_words.dart';
import 'package:english_app/domain/use_cases/get_words_count.dart';
import 'package:english_app/domain/use_cases/update_word.dart';
import 'package:english_app/injector.dart';
import 'package:english_app/presentation/bloc/i_bloc.dart';
import 'package:english_app/presentation/bloc/quiz_bloc/quiz_bloc_event.dart';
import 'package:english_app/presentation/bloc/quiz_bloc/quiz_bloc_state.dart';
import 'package:rxdart/subjects.dart';
import 'package:sembast/sembast.dart';

class QuizBloc extends IBloc {
  QuizBloc() {
    _eventStream.listen(_handleEvents);
  }

  int _count = 0;
  final _totalAmount = 5;
  bool _isSecondsTry = false;
  WordEntity _currentWord;
  final _quizWords = <WordEntity>[];
  final _eventStreamController = BehaviorSubject<QuizBlocEvent>();
  Stream<QuizBlocEvent> get _eventStream => _eventStreamController.stream;
  Sink<QuizBlocEvent> get eventSink => _eventStreamController.sink;
  final _stateStreamController = BehaviorSubject<QuizBlocState>();
  Stream<QuizBlocState> get stateStream => _stateStreamController.stream;
  Sink<QuizBlocState> get _stateSink => _stateStreamController.sink;

  Future<void> _handleEvents(QuizBlocEvent event) async {
    if (event is InitQuiz) {
      await _loadQuizData();
      _stateSink.add(Inited(
        currentWord: _currentWord,
        quizWords: _quizWords,
      ));
    } else if (event is GiveAnswer) {
      if (event.word.id == _currentWord.id) {
        await UpdateWord(vocabularyRepository: getIt<IVocabularyRepository>())
            .execute(
                params: event.word.copyWith(wordStatus: WordStatus.success));
        _isSecondsTry = false;
        _count++;
        _stateSink.add(Success(
            currentWord: event.word.copyWith(wordStatus: WordStatus.mistake),
            quizWords: _quizWords));
        await Future.delayed(const Duration(milliseconds: 300));
        if (_count >= 5) {
          _stateSink.add(QuizEnded(
              congratulation: _congratulation,
              scoreInPercent: _scoreInpercent));
        } else {
          eventSink.add(InitQuiz());
        }
      } else {
        await Future.delayed(const Duration(milliseconds: 300));
        if (_isSecondsTry) {
          _stateSink.add(Mistake(
              currentWord: event.word.copyWith(wordStatus: WordStatus.mistake),
              quizWords: _quizWords));
          await UpdateWord(vocabularyRepository: getIt<IVocabularyRepository>())
              .execute(
                  params: event.word.copyWith(wordStatus: WordStatus.mistake));
          _stateSink.add(QuizEnded(
              congratulation: _congratulation,
              scoreInPercent: _scoreInpercent));
        } else {
          _stateSink.add(Mistake(
              currentWord: event.word.copyWith(wordStatus: WordStatus.mistake),
              quizWords: _quizWords));
          _isSecondsTry = true;
          _stateSink.add(Inited(
            currentWord: _currentWord,
            quizWords: _quizWords,
          ));
        }
      }
    }
  }

  Future<void> _loadQuizData() async {
    if (_quizWords.isNotEmpty) {
      _quizWords.clear();
    }
    await _loadCurrentWord();
    final wordsCount = await GetWordsCount(
            vocabularyRepository: getIt<IVocabularyRepository>())
        .execute();
    while (_quizWords.length < 3) {
      _quizWords.addAll(
        await GetWords(vocabularyRepository: getIt<IVocabularyRepository>())
            .execute(
          params: Finder(
            filter: Filter.and(<Filter>[
              Filter.notEquals('id', _currentWord.id),
              Filter.byKey(Random().nextInt(wordsCount))
            ]),
            limit: 1,
          ),
        ),
      );
    }
    _quizWords
      ..add(_currentWord)
      ..shuffle();
  }

  Future<void> _loadCurrentWord() async {
    _currentWord =
        await GetWords(vocabularyRepository: getIt<IVocabularyRepository>())
            .execute(
                params: Finder(
                    filter: Filter.equals(
                      'status',
                      WordStatus.unused.statusString,
                    ),
                    limit: 1))
            .then((value) => value.first);
    _currentWord ??=
        await GetWords(vocabularyRepository: getIt<IVocabularyRepository>())
            .execute(
                params: Finder(
                    filter: Filter.equals(
                      'status',
                      WordStatus.mistake.statusString,
                    ),
                    limit: 1))
            .then((value) => value.first);

    _currentWord ??=
        await GetWords(vocabularyRepository: getIt<IVocabularyRepository>())
            .execute(
                params: Finder(
                    filter: Filter.equals(
                      'status',
                      WordStatus.success.statusString,
                    ),
                    limit: 1))
            .then((value) => value.first);
  }

  String get _congratulation {
    if (_scoreInpercent < 60) {
      return 'Можете Лучше!';
    }
    return 'Поздравляем!';
  }

  int get _scoreInpercent {
    return _count ~/ _totalAmount * 100;
  }

  @override
  void dispose() {
    _eventStreamController.close();
    _stateStreamController.close();
  }
}
