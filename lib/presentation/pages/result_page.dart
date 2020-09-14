import 'package:english_app/presentation/pages/vocabulary_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({
    Key key,
    @required String congratulation,
    @required int scoreInPercent,
  })  : _congratulation = congratulation,
        _scoreInPercent = scoreInPercent,
        super(key: key);

  final String _congratulation;
  final int _scoreInPercent;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Theme.of(context).primaryColor,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Result'),
      ),
      child: SafeArea(
        child: Material(
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_congratulation),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text('$_scoreInPercent%'),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton(
                  onPressed: () {
                    _navigateToVocabulatyPage(context: context);
                  },
                  child: const Text('Vocabulary page'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToVocabulatyPage({@required BuildContext context}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => VocabularyPage()),
        (route) => false);
  }
}
