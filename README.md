# Mimosa

MIMOSA Study Prototype App

## Getting Started

This project uses Flutter and Dart. To run the project, you need to have Flutter installed on your machine. You can follow the instructions on the [official Flutter website](https://flutter.dev/docs/get-started/install) to install Flutter..

### Running the App

To run the app, you need to have an emulator running on your machine. You can use an Android emulator or an iOS emulator. You can also connect a physical device to your machine and run the app on the device.

To run the app, use the following command:

```bash

flutter run

```

### Building the App

To build the app, use the following command:

```bash

flutter build apk

```

This command will generate an APK file that you can install on an Android device.

### General

- The app uses the `flutter_bloc` package for state management.
  - Bloc is used for the RTN animation game. Each animation component is its own state, actions are triggered based on a timer, and the state is updated accordingly. The change in state triggers a targetted rebuild of the widget tree, making the animations efficient.
- The app uses the `audioplayers` package for playing audio files.
- The app uses the `shared_preferences` package for storing user and app data locally.
  - Settings data (time taken for each animation, etc.) is stored locally using shared preferences. This can later be transferred to Firebase for cloud storage.
- The app uses the `sqflite` package for storing user data locally. (WIP)
  - User data is stored locally using SQLite. This can later be transferred to Firebase for cloud storage.

The Face Preference Game does not use the BLoC pattern. This was an early implementation and can be refactored to use the BLoC pattern. Therefore, this game is more computationally expensive than the RTN Animation game, and can be optimized.

- The follow-up questions for parents are a prototype and not fully functional. This is a design prototype and can be expanded further.
- A login screen is being implemented to allow for multiple users to use the app. This is a work in progress.

### Project Structure

The codebase is structured as follows:

```bash
.
│   app_ui.dart
│   landing_page.dart
│   main.dart
│   routes.dart
│   settings.dart
│
├───children
│   │   children_home.dart
│   │   face_pref_game.dart
    │   face_pref_animations.dart
│   │
│   └───rtn_animation
│       │   rtn_animation.dart
│       │
│       ├───bloc
│       │       bloc.dart
│       │       rtn_animation_bloc.dart
│       │       rtn_animation_event.dart
│       │       rtn_animation_state.dart
│       │
│       ├───view
│       │       rtn_animation_page.dart
│       │
│       └───widgets
│               rtn_animation_body.dart
│               widgets.dart
│
├───models
│   │   audio_data.dart
│   │   constants.dart
│   │   image_data.dart
│   │   p_two_question_set.dart
│   │   question_set.dart
│   │   shared.dart
│   │
│   └───questions
│           phase_one_question.dart
│           phase_two_question.dart
│
├───parents
│       m_chat_instructions.dart
│       phase_two.dart
│       phase_two_instructions.dart
│       qa_page.dart
│       score_next_step.dart
│
├───services
│   └───crud
│           crud_constants.dart
│           crud_exceptions.dart
│           database_note.dart
│           database_user.dart
│           db_service.dart
│
└───ui
    │   colors.dart
    │   theme.dart
    │
    ├───typography
    │       font_weights.dart
    │       text_styles.dart
    │       typography.dart
    │
    └───widgets
            widgets.dart
```

In order of the widget tree:

- `app_ui.dart` contains export information for the UI.
- `landing_page.dart` is the first screen that the user sees when they open the app.
- `main.dart` is the entry point of the app.
- `routes.dart` contains the routes for the app, paths can be added and modified here.
- `settings.dart` contains the settings for the app, such as the time taken for each animation.

- children

  - `children_home.dart` is the home screen for selecting the games.
  - `face_pref_game.dart` is the face preference game.
    - `face_pref_animations.dart` contains the animations for the face preference game.
  - `rtn_animation`
    - `rtn_animation.dart` is the main file for the RTN Animation game.
    - `bloc` contains the BLoC pattern files for the RTN Animation game.
    - `view` contains the view files for the RTN Animation game.
    - `widgets` contains the widgets for the RTN Animation game.

- models
  - `audio_data.dart` contains the audio data paths.
  - `constants.dart` contains the shared preferences keys for app settings.
  - `image_data.dart` contains the image data paths.
  - `p_two_question_set.dart` contains the phase two question set model.
  - `question_set.dart` contains the question set model.
  - `shared.dart` contains the getters and setters for shared preferences.
  - `questions` contains the question models for the app.
- parents
  - `m_chat_instructions.dart` contains the instructions for the M-CHAT questionnaire.
  - `phase_two.dart` contains the phase two questionnaire.
  - `phase_two_instructions.dart` contains the instructions for the phase two questionnaire.
  - `qa_page.dart` contains the question and answer page for the questionnaires.
  - `score_next_step.dart` contains the next steps after the questionnaires.
- services
  - `crud` contains the CRUD operations for the app.
- ui
  - `colors.dart` contains the color palette for the app.
  - `theme.dart` contains the theme for the app.
  - `typography` contains the typography for the app.
  - `widgets` contains the widgets for the app.

### Testing

The app has been tested on an Android emulator and a physical Android device. The app has not been tested on an iOS device.

### Future Work

- Implement the login screen for multiple users.
- Implement the follow-up questions for parents.
- Refactor the Face Preference Game to use the BLoC pattern.
- Integrate the SQLite database for storing user data.

### License

This project is licensed under the MIT License.

### Notes (10 June 2024):

- Single gender avatar
- Bibi's Home = response to name task
  - Spatially aligned audio (left to left audio)
  - distraction from the other side
  - Avatar says child's name
- Face preference task (Psych Toolbox):
  - Animation between images
  - Image duration 5s

Tofu's Bag

- Warning sign
- Tofu's Bag writing
- Bag shakes, opens, image
- marbles, next image
- repeat 4 times
- bag closes, balloons

1. Tofu's Bag
2. Bag gets closer, (see what's inside), bag opens
3. Image
4. Marbles
5. Repeat 4 times, bag closes, balloons

Bibi's Home

- Person to left/right
- Object falls on opposite side
- Person moves to center
- Person looks left, forward, top left, up, top right, down, points to sides
- 6 directions with objects on each side

- For level 1, there is no background animation
