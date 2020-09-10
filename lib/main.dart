import 'package:english_app/data/app_database.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: initFakeData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasError) {
          return MaterialApp(
            title: 'English App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: null,
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  Future<void> initFakeData() async {
    final wordsFolder = intMapStoreFactory.store('Words');
    final database = await AppDatabase.instance.database;
    if (await wordsFolder.count(database) == 0) {
      return;
    }
    return wordsFolder.addAll(database, <Map<String, dynamic>>[
      {
        'word': 'Dog',
        'translation': 'Собака',
        'sentence': 'My dog is big',
        'status': 'unused'
      },
      {
        'word': 'Cat',
        'translation': 'Кот',
        'sentence': 'My cat is big',
        'status': 'unused'
      },
      {
        'word': 'Tree',
        'translation': 'Дерево',
        'sentence': 'My tree is big',
        'status': 'unused'
      },
      {
        'word': 'Bird',
        'translation': 'Птица',
        'sentence': 'My bird is small',
        'status': 'unused'
      },
      {
        'word': 'Book',
        'translation': 'Книга',
        'sentence': 'My book is small',
        'status': 'unused'
      },
      {
        'word': 'Cap',
        'translation': 'Шапка',
        'sentence': 'My cap is cool',
        'status': 'unused'
      },
      {
        'word': 'Cup',
        'translation': 'Чашка',
        'sentence': 'My cup is cool',
        'status': 'unused'
      },
      {
        'word': 'Computer',
        'translation': 'Компьютер',
        'sentence': 'My computer is strong',
        'status': 'unused'
      },
      {
        'word': 'Snow',
        'translation': 'Снег',
        'sentence': 'This snow is white',
        'status': 'unused'
      },
      {
        'word': 'Grass',
        'translation': 'Трава',
        'sentence': 'This grass is green',
        'status': 'unused'
      },
      {
        'word': 'Wolf',
        'translation': 'Волк',
        'sentence': 'This wolf is grey',
        'status': 'unused'
      },
      {
        'word': 'Lion',
        'translation': 'Лев',
        'sentence': 'This lion is big',
        'status': 'unused'
      },
      {
        'word': 'Spoon',
        'translation': 'Ложка',
        'sentence': 'My spoon is metal',
        'status': 'unused'
      },
      {
        'word': 'Notepad',
        'translation': 'Блокнот',
        'sentence': 'My notepad is godd',
        'status': 'unused'
      },
      {
        'word': 'Phone',
        'translation': 'Телефон',
        'sentence': 'My phone is smart',
        'status': 'unused'
      },
      {
        'word': 'Window',
        'translation': 'Окно',
        'sentence': 'My window is large',
        'status': 'unused'
      },
      {
        'word': 'Bed',
        'translation': 'Кровать',
        'sentence': 'My bed is large',
        'status': 'unused'
      },
      {
        'word': 'Eye',
        'translation': 'Глаз',
        'sentence': 'My eye is large',
        'status': 'unused'
      },
      {
        'word': 'Nose',
        'translation': 'Нос',
        'sentence': 'My nose is large',
        'status': 'unused'
      },
      {
        'word': 'Mouth',
        'translation': 'Рот',
        'sentence': 'My mouth is small',
        'status': 'unused'
      },
      {
        'word': 'Name',
        'translation': 'Имя',
        'sentence': 'My name is long',
        'status': 'unused'
      },
      {
        'word': 'Surname',
        'translation': 'Фамилия',
        'sentence': 'My surname is short',
        'status': 'unused'
      },
    ]);
  }
}
