import 'package:english_app/data/models/word_model.dart';

abstract class IWordLocalDataSource {
  Future<List<WordModel>> getWords();
}
