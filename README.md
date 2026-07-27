# 📱 SDA Companion

An all-in-one offline Seventh-day Adventist companion app built with Flutter.

## ✨ Features

- **📚 Sabbath School Lessons** - Pre-cached quarterly lessons for offline studying
- **📖 Offline Bible (KJV)** - Complete King James Version with local SQLite database
- **🎵 SDA Hymnal** - Browse all 695 hymns from the official SDA hymnal

## 🚀 Quick Start

```bash
# Clone the repo
git clone https://github.com/Briankipp88/churchapp.git
cd churchapp

# Install dependencies
flutter pub get

# Run the app
flutter run
```

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry & navigation
├── models/
│   ├── hymn.dart
│   └── verse.dart
├── services/
│   ├── bible_service.dart       # SQLite queries
│   └── hymnal_service.dart      # JSON loader
└── screens/
    ├── lessons_screen.dart
    ├── bible_screen.dart
    └── hymnal_screen.dart

assets/
├── bible/kjv.sqlite
├── hymnal/sda_hymns.json
└── lessons/current_quarter.json
```

## 📦 Dependencies

- **sqflite** - Local SQLite database
- **path** - File path utilities
- **Flutter** - UI framework

## 🎨 Theme

- Classic Navy color scheme (#003366)
- Material Design 3 with light & dark modes
- Bottom navigation with 3 core tabs

## 📄 License

Creative Commons Zero v1.0 Universal
