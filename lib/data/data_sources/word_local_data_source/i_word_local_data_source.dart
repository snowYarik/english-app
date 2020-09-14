import 'package:english_app/data/models/word_model.dart';
import 'package:flutter/foundation.dart';
import 'package:sembast/sembast.dart';

abstract class IWordLocalDataSource {
  Future<List<WordModel>> getWords({Finder finder});
  Future<int> getWordsCount();
  Future<void> updateWord({@required WordModel wordModel});
}
