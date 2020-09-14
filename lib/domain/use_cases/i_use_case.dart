import 'package:equatable/equatable.dart';

abstract class IUseCase<Type, Params> {
  const IUseCase();

  Future<Type> execute({Params params});
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
