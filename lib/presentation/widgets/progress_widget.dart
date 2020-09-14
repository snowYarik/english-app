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
      width: double.infinity,
      height: 10.0,
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 100.0,
          height: 10.0,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
