# ✈️ AirGo

A Flutter app to search and view flights with clean architecture and animations.

---

## 🚀 Features

* 🔍 Search flights
* 📋 View flight results with smooth animations
* 📄 Flight detail screen
* ❤️ Favorite flights
* 📴 Offline/Mock data support
* 🌱 State management with Riverpod

---

## 📦 Tech Stack

* Flutter
* Riverpod
* Clean Architecture principles
* Local mock flight data

---

## 📁 Folder Structure (Clean Architecture-ish)

> 🧹 Note: This is my first time exploring Clean Architecture — I'm more familiar with MVVM, so this is me stepping outside my comfort zone. If anything feels over-engineered… that's part of the experience 😄

```
lib/
├── features/
│   ├── data/               # Handles data layer
│   │   ├── datasources/    # API or local data sources
│   │   ├── models/         # Data models for flights
│   │   ├── repositories/   # Data repository implementations
│   │   └── services/       # Helper classes or logic services
│
│   ├── domain/             # Business logic layer
│   │   ├── entities/       # Core entities used across app
│   │   ├── repositories/   # Repository contracts (abstract)
│   │   └── usecases/       # Application-specific logic
│
│   └── presentation/       # UI layer
│       ├── providers/      # Riverpod state management
│       ├── screens/        # App screens
│       └── widgets/        # Reusable UI components
└── main.dart               # Entry point of the app
```

---

## 💪 Getting Started

```bash
git clone https://github.com/olamideid/airgo.git
cd airgo
flutter pub get
flutter run
```

---

## 📸 Screenshots

> *Coming soon...*

---

## 👨‍💻 Author

**[@olamideid](https://github.com/olamideid)**
