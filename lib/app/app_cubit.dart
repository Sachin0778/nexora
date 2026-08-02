import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppState {
  const AppState({
    required this.currentTab,
    required this.themeMode,
  });

  final int currentTab;
  final ThemeMode themeMode;

  AppState copyWith({
    int? currentTab,
    ThemeMode? themeMode,
  }) {
    return AppState(
      currentTab: currentTab ?? this.currentTab,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}

class AppCubit extends Cubit<AppState> {
  AppCubit()
      : super(
          const AppState(
            currentTab: 0,
            themeMode: ThemeMode.system,
          ),
        );

  void changeTab(int index) => emit(state.copyWith(currentTab: index));

  void toggleTheme() {
    final nextMode =
        state.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    emit(state.copyWith(themeMode: nextMode));
  }
}
