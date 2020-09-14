import 'package:english_app/domain/entities/word_entity.dart';
import 'package:english_app/presentation/bloc/vocabulary_bloc/vocabulary_bloc.dart';
import 'package:english_app/presentation/bloc/vocabulary_bloc/vocabulary_bloc_event.dart';
import 'package:english_app/presentation/bloc/vocabulary_bloc/vocabulary_bloc_state.dart';
import 'package:english_app/presentation/pages/quiz_page.dart';
import 'package:english_app/presentation/widgets/vocabulary_tile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VocabularyPage extends StatefulWidget {
  @override
  _VocabularyPageState createState() => _VocabularyPageState();
}

class _VocabularyPageState extends State<VocabularyPage> {
  final _vocabularyBloc = VocabularyBloc();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => _vocabularyBloc.eventSink.add(LoadWords()));
  }

  @override
  Widget build(BuildContext context) {
    return Provider<VocabularyBloc>(
      create: (context) => _vocabularyBloc,
      child: CupertinoPageScaffold(
        backgroundColor: Theme.of(context).primaryColor,
        navigationBar: CupertinoNavigationBar(
          leading: Icon(
            Icons.keyboard_arrow_left,
            size: 40.0,
          ),
          middle: Text('Vocabulary'),
        ),
        child: SafeArea(
          child: Material(
            child: SingleChildScrollView(
              child: StreamBuilder<VocabularyBlocState>(
                stream: _vocabularyBloc.stateStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active &&
                      !snapshot.hasError) {
                    if (snapshot.data is WordsLoaded) {
                      final WordsLoaded data = snapshot.data;
                      return Column(
                        children: [
                          ListView.builder(
                            itemCount: data.words.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(0.0),
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 5.0),
                                child: VocabularyTileWidget(
                                  wordEntity: data.words[index],
                                ),
                              );
                            },
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 10.0),
                            child: RaisedButton(
                              onPressed: () {
                                _navigateToQuizPage();
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              color: Colors.blue,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: Text(
                                  'Start Lesson',
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                        ],
                      );
                    }
                  }
                  return Center(child: const CircularProgressIndicator());
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToQuizPage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => QuizPage(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  void dispose() {
    _vocabularyBloc.dispose();
    super.dispose();
  }
}
