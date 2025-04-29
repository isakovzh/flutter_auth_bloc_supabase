Developer & User Documentation
1. Project Overview
The Kyrgyz Educational App is a mobile application built using Flutter and Clean Architecture principles. 
It is designed to help users explore and learn the epic of Manas through interactive lessons, quizzes, and character-based games.

2. Technologies Used

- Flutter (Dart): UI and logic
- BLoC: State management
- Hive: Local storage for offline use
- Supabase: Authentication
- JSON: Content storage for lessons and quizzes
- Figma: UI/UX design

3. Folder Structure

- lib/
  - core/: Common styles, widgets, utils
  - feature/: Modules like auth, profile, lesson, quiz
    - data/: Models, datasources, repositories
    - domain/: Entities, use cases, repository interfaces
    - presentation/: UI, bloc, pages, widgets

4. Setup Instructions (Developer)

1. Clone the repository:
   git clone https://github.com/isakovzh/flutter_auth_bloc_supabase.git

2. Navigate to the project directory:
   cd flutter_auth_bloc_supabase

3. Install dependencies:
   flutter pub get

4. Run the project:
   flutter run

5. User Guide

- Log in or sign up using email/password
- Choose a lesson to study
- Tap “Open” to read the text and listen to the audio
- Complete the quiz after reading to earn XP and level up
- Go to Profile to see your stats, achievements, and change avatar
- Try to guess characters by reading clues in the character section

6. Notes

- App supports offline data via Hive (except login)
- All lessons and quizzes are stored in local JSON files
- Localization for English and Kyrgyz is implemented

