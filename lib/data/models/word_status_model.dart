import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class WordStatusModel extends Equatable {
  const WordStatusModel({
    @required this.id,
    @required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object> get props => [
        id,
        name,
      ];
}
