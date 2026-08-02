import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexora/app/app_cubit.dart';
import 'package:nexora/features/ai/presentation/pages/ai_page.dart';
import 'package:nexora/features/chat/presentation/pages/chat_page.dart';
import 'package:nexora/features/home/presentation/pages/home_page.dart';
import 'package:nexora/features/live_matches/presentation/pages/live_matches_page.dart';
import 'package:nexora/features/music/presentation/pages/music_page.dart';
import 'package:nexora/features/profile/presentation/pages/profile_page.dart';

class MainShellPage extends StatelessWidget {
  const MainShellPage({super.key});

  static const List<Widget> _pages = [
    HomePage(),
    LiveMatchesPage(),
    ChatPage(),
    MusicPage(),
    AiPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.currentTab,
            children: _pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.currentTab,
            onTap: context.read<AppCubit>().changeTab,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sports_soccer_outlined),
                label: 'Live',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.music_note_outlined),
                label: 'Music',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.smart_toy_outlined),
                label: 'AI',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
