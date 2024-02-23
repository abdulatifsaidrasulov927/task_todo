import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

// Eventler
abstract class BottomSheetEvent {}

class ToggleColorEvent extends BottomSheetEvent {
  final int index;

  ToggleColorEvent(this.index);
}

// State
class BottomSheetState {
  List<Color> containerColors;

  BottomSheetState(this.containerColors);
}

// Cubit
class BottomSheetCubit extends Cubit<BottomSheetState> {
  BottomSheetCubit() : super(BottomSheetState(List.filled(5, Colors.white)));

  void toggleColor(int index) {
    List<Color> updatedColors = state.containerColors;
    updatedColors[index] =
        updatedColors[index] == Colors.white ? Colors.blue : Colors.white;
    emit(BottomSheetState(updatedColors));
  }
}
