import 'package:english_app/presentation/widgets/vocabulary_tile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VocabularyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.backpack),
          title: Text('Vocabulary'),
        ),
        body: Column(
          children: [
            ListView.builder(
              itemCount: 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return VocabularyTileWidget(
                  imagePath: null,
                  pronounceUrl: null,
                  sentence: null,
                  word: null,
                  wordTranslation: null,
                );
              },
            ),
            RaisedButton(
              onPressed: null,
              child: Text('Start Lesson'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
