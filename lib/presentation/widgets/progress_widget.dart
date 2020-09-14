import 'package:flutter/material.dart';

//Not implemented
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
  final _totalProgress = 100.0;
  double _currentProgress = 0.0;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _currentProgress = _totalProgress / widget._questionNumber;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 10.0,
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget child) => Container(
            width: _animationController.value * 200.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
