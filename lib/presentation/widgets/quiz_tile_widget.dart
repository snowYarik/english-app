import 'package:flutter/material.dart';

class QuizTileWidget extends StatelessWidget {
  const QuizTileWidget({
    Key key,
    @required String imagePath,
    @required String word,
  })  : _imagePath = imagePath,
        _word = word,
        super(key: key);

  final String _imagePath;
  final String _word;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: [
          Image.network(_imagePath),
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
              child: Text(_word),
            ),
          )
        ],
      ),
    );
  }
}
