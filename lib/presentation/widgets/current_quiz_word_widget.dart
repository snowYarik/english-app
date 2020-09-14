import 'package:flutter/material.dart';

class CurrentQuizWordWidget extends StatelessWidget {
  const CurrentQuizWordWidget({
    Key key,
    @required String word,
  })  : _word = word,
        super(key: key);

  final String _word;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      margin: EdgeInsets.only(top: 40.0, left: 50.0, right: 50.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
      ),
      child: Center(
        child: Text(_word),
      ),
    );
  }
}
