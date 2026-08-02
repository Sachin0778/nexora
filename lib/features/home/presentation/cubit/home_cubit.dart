import 'package:flutter_bloc/flutter_bloc.dart';

class HomeState {
  const HomeState({required this.cards});

  final List<String> cards;
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(
          const HomeState(
            cards: [
              'Go to Live Matches',
              'Open Chat',
              'Start Music',
              'Use AI Assistant',
              'View Profile',
            ],
          ),
        );
}
