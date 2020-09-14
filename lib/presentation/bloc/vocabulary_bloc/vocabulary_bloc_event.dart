import 'package:equatable/equatable.dart';

abstract class VocabularyBlocEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadWords extends VocabularyBlocEvent {}
