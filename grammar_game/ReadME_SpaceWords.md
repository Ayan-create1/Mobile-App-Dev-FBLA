Space Words 🚀
A gamified grammar learning app that promotes adventure through space exploration! Help students master grammar fundamentals with interactive games, quizzes, and progress tracking in an immersive space-themed environment.
Table of Contents

Problem Statement
Installation
Features
Game Modes
Architecture
Security & Privacy
Development Process
Contributing
Sources
License

Problem Statement
According to the National Assessment of Educational Progress, over 70% of American Middle School students aren't proficient in grammar. Since grammar is the foundation of communication, education, and our society itself, Space Words addresses this critical need through gamified learning.
Installation
Prerequisites

Flutter SDK (latest stable version)
Dart SDK
Android Studio or VS Code with Flutter extensions
Git

Setup Instructions

Clone the repository

bashgit clone https://github.com/[your-username]/space-words.git
cd space-words

Install dependencies

bashflutter pub get

Configure Supabase


Create a Supabase project
Add your Supabase URL and anon key to the app configuration
Set up authentication providers (Google, Facebook)


Run the app

bashflutter run
Usage
bash# Basic usage example
[command or code example]
[Explain how to use your project with examples]
Features

🎮 Interactive Game Modes: Gravity Drop and Uranian Search word games
🎨 Customizable Experience: Shop system with tile skins and themes
📚 Grammar Modules: Comprehensive lessons on punctuation and sentence structure
🤖 AI Assistant: Neptaid AI chatbot for grammar questions and semantic validation
🏆 Progress Tracking: Point accumulation and rewards system
📱 Social Sharing: Share puzzles directly to social media platforms
🔐 Secure Authentication: Email/password and social media login (Google, Facebook)
🎯 Targeted Learning: Focus on punctuation errors and tense conjugation
🌌 Space Theme: Immersive adventure environment with Astro the mascot

Game Modes
Gravity Drop

N-tier Architecture: Presentation layer (UI), logic layer (validation), data layer (storage)
Dynamic Visual Elements: Customizable tile colors, background effects mimicking Jupiter's storms
Real-time Validation: Drag and drop mechanics with instant feedback

Uranian Search

Word Search Mechanics: Find grammar-related words in a grid
State Management: Real-time cell highlighting (purple for selection, green for correct)
Reusable Components: Modular pop-up system and grid management

Grammar Modules

Drag and Drop Activities: Interactive tense conjugation exercises
Typing Validation: Syntactical validation with case-insensitive checking
AI Integration: Semantic validation through Neptaid chatbot

Architecture
Space Words implements a modular N-tier architecture pattern:
Presentation Layer

UI elements (answer boxes, backgrounds, tiles)
Dynamic visual components (tile color changes, background effects)
Flutter widgets and custom animations

Logic Layer

Input validation and interaction mechanics
Game logic and scoring systems
State management for real-time updates

Data Layer

Supabase backend for user data and progress
Question databases and content management
Point accumulation and shop item storage

Security & Privacy
Data Protection

Database: Supabase with ACID-compliant PostgreSQL
Encryption: AES-256 end-to-end encryption for data in transit
Access Control: Row Level Security (RLS) policies ensure users only access their own data

Data Collection
We only collect:

User name and email
Encrypted passwords (hidden from developers)
Game progress and points

Authentication

Secure email/password system
OAuth integration with Google and Facebook
Password encryption through Supabase

Development Process
Space Words was developed using an AGILE methodology, which according to Harvard Business Review can compress innovation project cycle times by 75%.
1. Market Research & Needs Assessment

Interviewed high school humanities teachers
Consulted with CU Boulder Professor Annie Margaret (social media mental health expert)
Identified key pain points: punctuation errors and tense conjugation
Discovered design insights: bright color schemes and reward systems boost retention

2. Ideation Phase

Decided on word search and drag-and-drop game mechanics
Incorporated space theme for curiosity and engagement

3. Prototyping

Created wireframes focusing on user flows
Designed UI elements to enhance user engagement
Developed user experience mockups

4. Development Sprint

Used abstraction methods to break project into manageable pieces
Implemented modular components for reusability
Applied object-oriented programming principles

Examples
Basic Game Flow
dart// Example of state management in Word Grid
class WordGridState extends State<WordGrid> {
  void highlightCell(int row, int col) {
    setState(() {
      cells[row][col].isHighlighted = true;
    });
  }
}
Adding Points to User
dart// Component for updating user points
void addPointsToUser(int points) {
  // Update user points in Supabase
  // Refresh UI to show new total
}
API Reference (if applicable)
[Function/Method Name]

Description: [What it does]
Parameters:

param1 (type): [description]
param2 (type): [description]


Returns: [return type and description]

Contributing

Fork the repository
Create a feature branch (git checkout -b feature/amazing-feature)
Commit your changes (git commit -m 'Add some amazing feature')
Push to the branch (git push origin feature/amazing-feature)
Open a Pull Request

Testing
bash# Run unit tests
flutter test

# Run integration tests
flutter test integration_test/

# Run specific test file
flutter test test/game_logic_test.dart
Sources
Research & Statistics

National Assessment of Educational Progress (Grammar proficiency statistics)
Harvard Business Review (AGILE methodology research)
Microsoft Documentation (N-tier architecture patterns)

Technical Resources

Flutter Documentation - Framework documentation and best practices
Dart Language Guide - Programming language fundamentals
Supabase Documentation - Backend as a service implementation
Firebase Auth Documentation - Authentication patterns
Material Design Guidelines - UI/UX design principles

Development Tools & Libraries

Flutter SDK - Mobile app development framework
Supabase - Backend database and authentication
Google OAuth - Social media authentication
Facebook Login SDK - Social media authentication

Educational Consultants

High school humanities teachers (interviews for needs assessment)
Professor Annie Margaret, CU Boulder - Social media and mental health expert

Design Inspiration

Space exploration themes and imagery
Gamification principles from successful educational apps
Color psychology research for user engagement

Troubleshooting
[Common Issue 1]
[Solution or explanation]
[Common Issue 2]
[Solution or explanation]
Changelog
[Version] - [Date]

[Change 1]
[Change 2]

License
This project is licensed under the [License Name] License - see the LICENSE file for details.
Contact

Developer: Ayan Agarwal
Email: [your.email@example.com]
GitHub: [your-github-username]
Project Link: [https://github.com/username/space-words]

Acknowledgments

High school humanities teachers who participated in the needs assessment
Professor Annie Margaret (CU Boulder) for insights on user engagement and mental health
The Flutter and Supabase communities for excellent documentation and support
Beta testers who provided valuable feedback during development
Claude AI and ChatGPT to help write some parts of the code
Hussain Mustafa Youtube channel for help on the OpenAPI integration
Some assests that were used were taken from the internet; however, they are all public domain and were usually photoshoped and edited slightly

