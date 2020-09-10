import 'package:english_app/domain/entities/word_entity.dart';
import 'package:flutter/material.dart';

class VocabularyTileWidget extends StatelessWidget {
  const VocabularyTileWidget({
    Key key,
    @required String imagePath,
    @required String word,
    @required String wordTranslation,
    @required String sentence,
    @required String pronounceUrl,
    WordStatus wordStatus = WordStatus.unused,
  })  : _imagePath = imagePath,
        _word = word,
        _wordTranslation = wordTranslation,
        _sentence = sentence,
        _pronounceUrl = pronounceUrl,
        _wordStatus = wordStatus,
        super(key: key);

  final String _imagePath;
  final String _word;
  final String _wordTranslation;
  final String _sentence;
  final String _pronounceUrl;
  final WordStatus _wordStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _statusColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            _imagePath,
            loadingBuilder: (context, widget, event) {
              return CircularProgressIndicator();
            },
            errorBuilder: (context, error, stackTrace) {
              return null;
            },
          ),
          Column(
            children: [
              Text(_word, softWrap: true),
              Text(_wordTranslation, softWrap: true),
              Text(_sentence, softWrap: true),
            ],
          ),
          Icon(Icons.volume_up),
        ],
      ),
    );
  }

  Color get _statusColor {
    switch (_wordStatus) {
      case WordStatus.unused:
        return Colors.white;
        break;
      case WordStatus.success:
        return Colors.green;
        break;
      case WordStatus.error:
        return Colors.red;
        break;
      default:
        return Colors.white;
    }
  }
}
