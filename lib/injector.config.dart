// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'domain/repository/i_vocabulary_repository.dart';
import 'data/data_sources/word_local_data_source/i_word_local_data_source.dart';
import 'data/repository/vocabulary_repository.dart';
import 'data/data_sources/word_local_data_source/word_local_data_source.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.factory<IWordLocalDataSource>(() => WordLocalDataSource());
  gh.factory<IVocabularyRepository>(() =>
      VocabulatyRepository(wordLocalDataSource: get<IWordLocalDataSource>()));
  return get;
}
