import 'package:english_app/domain/entities/word_entity.dart';
import 'package:english_app/domain/repository/i_vocabulary_repository.dart';
import 'package:english_app/domain/use_cases/i_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:sembast/sembast.dart';

class GetWords extends IUseCase<List<WordEntity>, Finder> {
  const GetWords({
    @required IVocabularyRepository vocabularyRepository,
  }) : _vocabularyRepository = vocabularyRepository;

  final IVocabularyRepository _vocabularyRepository;

  @override
  Future<List<WordEntity>> execute({Finder params}) {
    return _vocabularyRepository.getWords(finder: params);
  }
}
