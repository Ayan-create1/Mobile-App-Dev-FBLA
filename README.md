
# Space Words

Space Words is a **gamified grammar-learning mobile app** designed to help students strengthen essential grammar skills through interactive games, lessons, and challenges. Set in an **immersive space-exploration environment** featuring Astro, the app mascot, Space Words combines educational content with game mechanics to make practicing grammar more engaging.

Students can practice punctuation, sentence structure, and verb tenses through interactive game modes such as **Gravity Drop** and **Uranian Search**, complete grammar lessons and quizzes, and receive instant feedback on their answers. An AI assistant powered using **OpenAI's API** helps students ask grammar questions and provides additional semantic validation. Students can also share completed puzzles and achievements directly to social media platforms such as Instagram, Discord, and Snapchat, adding a social element to the learning experience. *(Note: The social sharing feature is not shown in the video demo below for privacy reasons.)*

The app also includes **progress tracking and various gamification features**, allowing students to earn points, unlock customizable themes and tile skins, and track their learning progress. With **secure authentication** using email, Google, and Facebook and a Supabase backend for storing user progress and preferences, Space Words provides an interactive and personalized approach to grammar practice.


## Demo
Watch a quick 2 minute video showcasing how the app works!
https://drive.google.com/file/d/1ZdyytWCFVRzLqTq2FxhRdQ86mel3gSKN/view?usp=sharing

## Installation

### Prerequisites

Before installing the application, make sure you have the following installed:

* [Flutter](https://flutter.dev/docs/get-started/install)
* Dart SDK (included with Flutter)
* Android Studio or Xcode for running on a mobile device or emulator

### Setup

1. Clone the repository:

```bash
git clone <https://github.com/Ayan-create1/Mobile-App-Dev-FBLA.git>
cd grammar_game
```

2. Install the required Flutter dependencies:

```bash
flutter pub get
```

3. Configure the required API keys and credentials.

Create the following configuration file:

```text
lib/config/api_keys.dart
```

Add the required credentials to this file:

* Supabase URL
* Supabase anon key
* OpenAI API key

**Important:** Do not commit API keys or other sensitive credentials to the repository.

4. Run the application:

```bash
flutter run
```

### Running on iOS

To run the application on an iOS simulator or physical device:

```bash
flutter run
```

To build the iOS application:

```bash
flutter build ios
```

    

    
## Run Locally

1. Clone the repository:

```bash
git clone <https://github.com/Ayan-create1/Mobile-App-Dev-FBLA.git>
cd grammar_game
```

2. Install the Flutter dependencies:

```bash
flutter pub get
```

3. Make sure your API keys and credentials are configured in the required configuration file.

4. Start an iOS simulator or connect a physical device.

5. Run the application:

```bash
flutter run
```

The application should launch on the connected device or simulator.

## License

This project is licensed under the MIT License.

