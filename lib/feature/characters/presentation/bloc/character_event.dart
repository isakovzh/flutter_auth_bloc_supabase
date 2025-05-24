part of 'character_bloc.dart';

abstract class CharacterEvent extends Equatable {
  const CharacterEvent();

  @override
  List<Object> get props => [];
}

class LoadCharactersEvent extends CharacterEvent {
  final String languageCode;

  const LoadCharactersEvent(this.languageCode);

  @override
  List<Object> get props => [languageCode];
}

class UnlockCharacterEvent extends CharacterEvent {
  final String id;

  const UnlockCharacterEvent(this.id);

  @override
  List<Object> get props => [id];
}
