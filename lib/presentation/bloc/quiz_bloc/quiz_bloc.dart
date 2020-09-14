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
import 'package:flutter/foundation.dart';
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
  int _wordsCount = 0;
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
        _currentWord = event.word.copyWith(wordStatus: WordStatus.success);
        final words = _quizWords.map((e) {
          if (e.id == _currentWord.id) {
            return _currentWord;
          }
          return e;
        }).toList();
        _stateSink.add(Success(currentWord: _currentWord, quizWords: words));
        await event.controller
            .forward()
            .then((value) => event.controller.reset());
        await Future.delayed(const Duration(milliseconds: 300));
        await UpdateWord(vocabularyRepository: getIt<IVocabularyRepository>())
            .execute(
                params: event.word.copyWith(wordStatus: WordStatus.success));
        _isSecondsTry = false;
        _count++;
        if (_count >= 5) {
          _count = 0;
          _stateSink.add(QuizEnded(
              congratulation: _congratulation,
              scoreInPercent: _scoreInPercent));
        } else {
          eventSink.add(InitQuiz());
        }
      } else {
        final words = _quizWords.map((e) {
          if (event.word.id == e.id) {
            return event.word.copyWith(wordStatus: WordStatus.mistake);
          }
          return e;
        }).toList();
        _stateSink.add(Mistake(currentWord: _currentWord, quizWords: words));
        await event.controller
            .forward()
            .then((value) => event.controller.reset());
        await Future.delayed(const Duration(milliseconds: 300));
        if (_isSecondsTry) {
          await UpdateWord(vocabularyRepository: getIt<IVocabularyRepository>())
              .execute(
                  params: event.word.copyWith(wordStatus: WordStatus.mistake));
          _stateSink.add(QuizEnded(
              congratulation: _congratulation,
              scoreInPercent: _scoreInPercent));
        } else {
          _isSecondsTry = true;
          eventSink.add(InitQuiz());
        }
      }
    }
  }

  Future<void> _loadQuizData() async {
    if (_quizWords.isNotEmpty) {
      _quizWords.clear();
    }
    await _loadCurrentWord();
    _wordsCount = await GetWordsCount(
            vocabularyRepository: getIt<IVocabularyRepository>())
        .execute();
    while (_quizWords.length < 3) {
      _quizWords.addAll(
        await GetWords(vocabularyRepository: getIt<IVocabularyRepository>())
            .execute(
          params: Finder(
            filter: Filter.and(<Filter>[
              Filter.notEquals('id', _currentWord.id),
              Filter.byKey(Random().nextInt(_wordsCount))
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
    _currentWord = await _getCurrentWord(wordStatus: WordStatus.unused);
    _currentWord ??= await _getCurrentWord(wordStatus: WordStatus.mistake);
    _currentWord ??= await _getCurrentWord(wordStatus: WordStatus.success);
  }

  Future<WordEntity> _getCurrentWord({@required WordStatus wordStatus}) async {
    final words =
        await GetWords(vocabularyRepository: getIt<IVocabularyRepository>())
            .execute(
                params: Finder(
                    filter: Filter.equals(
                      'status',
                      wordStatus.statusString,
                    ),
                    limit: 1));
    if (words.isNotEmpty) {
      return words.first;
    }
    return null;
  }

  String get _congratulation {
    if (_scoreInPercent < 60) {
      return 'Можете Лучше!';
    }
    return 'Поздравляем!';
  }

  int get _scoreInPercent {
    return _count ~/ _totalAmount * 100;
  }

  @override
  void dispose() {
    _eventStreamController.close();
    _stateStreamController.close();
  }
}
