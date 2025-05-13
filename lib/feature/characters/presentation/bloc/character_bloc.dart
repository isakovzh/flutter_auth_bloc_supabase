import 'package:app/feature/characters/domain/entity/characters.dart';
import 'package:app/feature/characters/domain/usecase/character_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'character_event.dart';
part 'character_state.dart';


class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final GetAllCharactersUseCase getAllCharacters;
  final UnlockCharacterUseCase unlockCharacter;

  CharacterBloc({
    required this.getAllCharacters,
    required this.unlockCharacter,
  }) : super(CharacterInitial()) {
    on<LoadCharactersEvent>(_onLoadCharacters);
    on<UnlockCharacterEvent>(_onUnlockCharacter);
  }

  Future<void> _onLoadCharacters(
    LoadCharactersEvent event,
    Emitter<CharacterState> emit,
  ) async {
    emit(CharacterLoading());
    try {
      final characters = await getAllCharacters();
      emit(CharacterLoaded(characters));
    } catch (e) {
      emit(CharacterError("Failed to load characters: ${e.toString()}"));
    }
  }

  Future<void> _onUnlockCharacter(
    UnlockCharacterEvent event,
    Emitter<CharacterState> emit,
  ) async {
    try {
      await unlockCharacter(event.id);
      final characters = await getAllCharacters();
      emit(CharacterLoaded(characters));
    } catch (e) {
      emit(CharacterError("Failed to unlock character: ${e.toString()}"));
    }
  }
}