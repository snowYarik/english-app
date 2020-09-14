import 'package:english_app/presentation/bloc/quiz_bloc/quiz_bloc.dart';
import 'package:english_app/presentation/bloc/quiz_bloc/quiz_bloc_event.dart';
import 'package:english_app/presentation/bloc/quiz_bloc/quiz_bloc_state.dart';
import 'package:english_app/presentation/pages/result_page.dart';
import 'package:english_app/presentation/widgets/bubble_bar_widget.dart';
import 'package:english_app/presentation/widgets/current_quiz_word_widget.dart';
import 'package:english_app/presentation/widgets/progress_widget.dart';
import 'package:english_app/presentation/widgets/quiz_grid_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final _quizBloc = QuizBloc();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _quizBloc.eventSink.add(InitQuiz()));
  }

  @override
  Widget build(BuildContext context) {
    return Provider<QuizBloc>(
      create: (context) => _quizBloc,
      child: CupertinoPageScaffold(
        backgroundColor: Theme.of(context).primaryColor,
        navigationBar: CupertinoNavigationBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.keyboard_arrow_left,
              size: 40.0,
            ),
          ),
          middle: Text('Find word'),
        ),
        child: SafeArea(
          child: Material(
            child: Column(
              children: [
                BubbleBarWidget(),
                ProgressWidget(questionNumber: 1),
                StreamBuilder<QuizBlocState>(
                  stream: _quizBloc.stateStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active &&
                        !snapshot.hasError) {
                      if (snapshot.data is Inited) {
                        final Inited data = snapshot.data;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CurrentQuizWordWidget(word: data.currentWord.word),
                            const SizedBox(
                              height: 70.0,
                            ),
                            QuizGridWidget(
                              words: data.quizWords,
                            ),
                          ],
                        );
                      } else if (snapshot.data is QuizEnded) {
                        final QuizEnded data = snapshot.data;
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _navigateToResultPage(
                              congratulation: data.congratulation,
                              scoreInPercent: data.scoreInPercent);
                        });
                        return const SizedBox.shrink();
                      }
                    }
                    return Center(child: const CircularProgressIndicator());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToResultPage(
      {@required String congratulation, @required int scoreInPercent}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => ResultPage(
                  congratulation: congratulation,
                  scoreInPercent: scoreInPercent,
                )),
        (route) => false);
  }

  @override
  void dispose() {
    _quizBloc.dispose();
    super.dispose();
  }
}
