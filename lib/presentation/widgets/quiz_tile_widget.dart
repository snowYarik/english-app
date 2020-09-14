import 'package:english_app/domain/entities/word_entity.dart';
import 'package:english_app/domain/entities/word_status.dart';
import 'package:english_app/presentation/bloc/quiz_bloc/quiz_bloc.dart';
import 'package:english_app/presentation/bloc/quiz_bloc/quiz_bloc_event.dart';
import 'package:english_app/presentation/resources/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizTileWidget extends StatefulWidget {
  const QuizTileWidget({
    Key key,
    @required WordEntity word,
  })  : _word = word,
        super(key: key);

  final WordEntity _word;

  @override
  _QuizTileWidgetState createState() => _QuizTileWidgetState();
}

class _QuizTileWidgetState extends State<QuizTileWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<QuizBloc>(context, listen: false).eventSink.add(
            GiveAnswer(word: widget._word, controller: _animationController));
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget child) => Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: _borderColor,
                  width: _animationController.value * 4,
                ),
              ),
              child: child),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                widget._word.imagePath ?? '',
                loadingBuilder: (context, widget, event) {
                  return const CircularProgressIndicator();
                },
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    placeholderPath,
                  );
                },
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Center(
                  child: Text(widget._word.translation),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color get _borderColor {
    switch (widget._word.status) {
      case WordStatus.unused:
        return Colors.transparent;
        break;
      case WordStatus.success:
        return Colors.green.shade200;
        break;
      case WordStatus.mistake:
        return Colors.red.shade200;
        break;
      default:
        return Colors.transparent;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
