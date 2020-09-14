import 'package:english_app/domain/entities/word_entity.dart';
import 'package:english_app/domain/entities/word_status.dart';
import 'package:english_app/presentation/resources/images.dart';
import 'package:flutter/material.dart';

class VocabularyTileWidget extends StatelessWidget {
  const VocabularyTileWidget({
    Key key,
    @required WordEntity wordEntity,
  })  : _wordEntity = wordEntity,
        super(key: key);

  final WordEntity _wordEntity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: _statusColor,
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Image.network(
                  _wordEntity.imagePath ?? '',
                  loadingBuilder: (context, widget, event) {
                    return const CircularProgressIndicator();
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(placeholderPath);
                  },
                ),
              ),
              Flexible(
                flex: 3,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_wordEntity.word, softWrap: true),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          _wordEntity.translation,
                          softWrap: true,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(_wordEntity.sentence, softWrap: true),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(top: 5.0, right: 10.0),
            child: Icon(
              Icons.volume_up,
              size: 30.0,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }

  Color get _statusColor {
    switch (_wordEntity.status) {
      case WordStatus.unused:
        return Colors.white;
        break;
      case WordStatus.success:
        return Colors.green.shade200;
        break;
      case WordStatus.mistake:
        return Colors.red.shade200;
        break;
      default:
        return Colors.white;
    }
  }
}
