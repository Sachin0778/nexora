# Nexora

Flutter app scaffolded with clean architecture and feature-based modules.

## Day 1 Implemented

- Core folders and feature-first structure
- Dio `ApiClient` and baseline failure classes
- Dependency injection setup with `get_it` + `injectable`
- Bottom navigation with 6 tabs using `IndexedStack`
- Home dashboard with `HomeCubit` and dummy cards
- Placeholder pages for Live Matches, Chat, Music, AI, and Profile
- Shared state widgets (`AppLoader`, `AppErrorView`, `AppEmptyView`)

## Project Structure

```text
lib/
  app/
  core/
    di/
    error/
    network/
    utils/
  shared/
    constants/
    theme/
    widgets/
  features/
    home/
    live_matches/
    chat/
    music/
    ai/
    profile/
```

## Run

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```
