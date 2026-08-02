import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexora/core/di/injection.dart';
import 'package:nexora/features/music/presentation/cubit/music_cubit.dart';
import 'package:nexora/features/music/presentation/cubit/music_state.dart';
import 'package:nexora/features/music/presentation/widgets/music_player_bar.dart';
import 'package:nexora/shared/widgets/app_empty_view.dart';
import 'package:nexora/shared/widgets/app_error_view.dart';
import 'package:nexora/shared/widgets/app_loader.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MusicCubit>()..initialize(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Music')),
        body: BlocBuilder<MusicCubit, MusicState>(
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(height: 8),
                _SourceSelector(
                  selectedSource: state.source,
                  onSelected: (source) {
                    context.read<MusicCubit>().changeSource(source);
                  },
                ),
                if (state.errorMessage != null)
                  Expanded(
                    child: AppErrorView(
                      message: state.errorMessage!,
                      onRetry: () {
                        if (state.source == MusicSource.offline) {
                          context.read<MusicCubit>().loadOfflineSongs();
                        } else {
                          context.read<MusicCubit>().loadOnlineSongs();
                        }
                      },
                    ),
                  )
                else if (state.isLoading && state.activeSongs.isEmpty)
                  const Expanded(child: AppLoader())
                else if (state.activeSongs.isEmpty)
                  const Expanded(
                    child: AppEmptyView(message: 'No songs available'),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: state.activeSongs.length,
                      itemBuilder: (context, index) {
                        final song = state.activeSongs[index];
                        final isCurrent = state.currentSong?.id == song.id;

                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Icon(
                                isCurrent && state.isPlaying
                                    ? Icons.graphic_eq
                                    : Icons.music_note,
                              ),
                            ),
                            title: Text(song.title),
                            subtitle: Text(song.artist),
                            trailing: IconButton(
                              icon: Icon(
                                isCurrent && state.isPlaying
                                    ? Icons.pause_circle
                                    : Icons.play_circle,
                              ),
                              onPressed: () {
                                if (isCurrent) {
                                  context.read<MusicCubit>().togglePlayPause();
                                } else {
                                  context.read<MusicCubit>().playSong(song);
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                if (state.currentSong != null)
                  MusicPlayerBar(
                    song: state.currentSong!,
                    isPlaying: state.isPlaying,
                    position: state.position,
                    duration: state.duration,
                    onPlayPause: () {
                      context.read<MusicCubit>().togglePlayPause();
                    },
                    onSeek: (milliseconds) {
                      context.read<MusicCubit>().seek(
                            Duration(milliseconds: milliseconds.toInt()),
                          );
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SourceSelector extends StatelessWidget {
  const _SourceSelector({
    required this.selectedSource,
    required this.onSelected,
  });

  final MusicSource selectedSource;
  final ValueChanged<MusicSource> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: _SourceButton(
              label: 'Offline',
              selected: selectedSource == MusicSource.offline,
              onTap: () => onSelected(MusicSource.offline),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _SourceButton(
              label: 'Online',
              selected: selectedSource == MusicSource.online,
              onTap: () => onSelected(MusicSource.online),
            ),
          ),
        ],
      ),
    );
  }
}

class _SourceButton extends StatelessWidget {
  const _SourceButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        backgroundColor:
            selected ? Theme.of(context).colorScheme.primaryContainer : null,
      ),
      child: Text(label),
    );
  }
}
