import 'package:english_app/data/app_database.dart';
import 'package:english_app/data/data_sources/word_local_data_source/i_word_local_data_source.dart';
import 'package:english_app/data/models/word_model.dart';
import 'package:injectable/injectable.dart';
import 'package:sembast/sembast.dart';

@Injectable(as: IWordLocalDataSource)
class WordLocalDataSource extends IWordLocalDataSource {
  @override
  Future<List<WordModel>> getWords() async {
    final database = await AppDatabase.instance.database;
    final wordsFolder = intMapStoreFactory.store('Words');
    final records = await wordsFolder.find(database);
    return records
        .map((snapshot) => WordModel.fromJson(json: snapshot.value))
        .toList();
  }
}
