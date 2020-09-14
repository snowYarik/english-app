import 'package:english_app/domain/entities/word_entity.dart';
import 'package:english_app/domain/repository/i_vocabulary_repository.dart';
import 'package:english_app/domain/use_cases/i_use_case.dart';
import 'package:flutter/foundation.dart';

class UpdateWord extends IUseCase<void, WordEntity> {
  const UpdateWord({
    @required IVocabularyRepository vocabularyRepository,
  }) : _vocabularyRepository = vocabularyRepository;

  final IVocabularyRepository _vocabularyRepository;

  @override
  Future<void> execute({@required WordEntity params}) {
    return _vocabularyRepository.updateWord(wordEntity: params);
  }
}
