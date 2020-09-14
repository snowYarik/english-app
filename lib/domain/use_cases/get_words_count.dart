import 'package:english_app/domain/repository/i_vocabulary_repository.dart';
import 'package:english_app/domain/use_cases/i_use_case.dart';
import 'package:flutter/foundation.dart';

class GetWordsCount extends IUseCase<int, NoParams> {
  const GetWordsCount({
    @required IVocabularyRepository vocabularyRepository,
  }) : _vocabularyRepository = vocabularyRepository;

  final IVocabularyRepository _vocabularyRepository;
  @override
  Future<int> execute({NoParams params}) {
    return _vocabularyRepository.getWordsCount();
  }
}
