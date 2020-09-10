import 'package:flutter/material.dart';

class ProgressWidget extends StatefulWidget {
  const ProgressWidget({
    Key key,
    @required int questionNumber,
  })  : _questionNumber = questionNumber,
        super(key: key);

  final int _questionNumber;

  @override
  _ProgressWidgetState createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget>
    with SingleTickerProviderStateMixin {
  final _totalPregress = 100.0;
  double _currentProgress;
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _currentProgress = _totalPregress / widget._questionNumber;
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _animation =
        Tween<double>(begin: 0.0, end: _currentProgress).animate(_controller)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        width: _animation.value,
        color: Colors.blue,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
