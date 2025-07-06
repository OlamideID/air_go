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

## 🎯 Sample Flight Data

To help you explore the app, here are specific flight searches you can try with our mock dataset:

### ✈️ **Domestic Flights**

**Lagos (LOS) → Abuja (ABV)**
- **Departure:** July 6, 2025
- **Return:** July 13, 2025 (for round trip)
- **Classes:** Economy (₦450), Premium Economy (₦580), Business (₦680)
- **Trip Types:** One Way, Round Trip
- **Airlines:** SkyConnect Airways
- **Options:** Direct flights & flights with stops

### 🌍 **International Flights**

**Lagos (LOS) → London (LHR)**
- **Departure:** July 7, 2025
- **Return:** July 15, 2025 (for round trip)
- **Classes:** Economy (₦820-₦950), Premium Economy (₦1,100), Business (₦1,450), First Class (₦3,200)
- **Trip Types:** One Way, Round Trip
- **Airlines:** Royal Wings
- **Stops:** Direct, via Paris, via Amsterdam, via Istanbul + Rome

**Lagos (LOS) → Dubai (DXB)**
- **Departure:** July 8, 2025
- **Return:** July 16, 2025 (for round trip)
- **Classes:** Economy (₦750-₦950), Business (₦2,200), First Class (₦3,500)
- **Trip Types:** One Way, Round Trip
- **Airlines:** SkyConnect Airways
- **Options:** Direct flights & flights with stops via Cairo/Istanbul

**New York (JFK) → Lagos (LOS)**
- **Departure:** July 10, 2025
- **Return:** July 20, 2025 (for round trip)
- **Classes:** Economy (₦1,180-₦1,450), Premium Economy (₦1,650), Business (₦2,800), First Class (₦2,200)
- **Trip Types:** One Way, Round Trip
- **Airlines:** Global Connect
- **Stops:** Direct, via Frankfurt, via London, via Paris + Casablanca

### 🌍 **African Routes**

**Lagos (LOS) → Nairobi (NBO)**
- **Departure:** July 9, 2025
- **Return:** July 18, 2025 (for round trip)
- **Classes:** Economy (₦620-₦850), Premium Economy (₦920), Business (₦1,350)
- **Trip Types:** One Way, Round Trip, Multi-City
- **Airlines:** NovaAir
- **Stops:** Direct, via Kigali, via Addis Ababa, via N'Djamena + Khartoum

**Abuja (ABV) → Johannesburg (JNB)**
- **Departure:** July 9, 2025
- **Return:** July 17, 2025 (for round trip)
- **Classes:** Economy (₦620-₦920), Premium Economy (₦800-₦920), Business (₦1,400)
- **Trip Types:** One Way, Round Trip, Multi-City
- **Airlines:** Jet Africa
- **Stops:** Direct, via Nairobi, via Addis Ababa, via Cairo + Nairobi

**Lagos (LOS) → Cape Town (CPT)**
- **Departure:** July 12, 2025
- **Classes:** Economy (₦980-₦1,350)
- **Trip Types:** One Way
- **Airlines:** AfriSky
- **Stops:** Direct, via Johannesburg, via Luanda + Windhoek

### 🌍 **Regional African**

**Lagos (LOS) → Accra (ACC)**
- **Departure:** July 11, 2025
- **Classes:** Economy (₦240-₦280)
- **Trip Types:** One Way
- **Airlines:** Atlantic Airways
- **Options:** Direct & via Cotonou

**Abuja (ABV) → Cairo (CAI)**
- **Departure:** July 13, 2025
- **Classes:** Economy (₦580-₦720)
- **Trip Types:** One Way
- **Airlines:** Desert Wings
- **Stops:** Direct, via Khartoum, via N'Djamena + Tripoli

### 🎫 **Available Travel Classes**
- **Economy** - Budget-friendly options
- **Premium Economy** - Enhanced comfort
- **Business** - Premium service and amenities
- **First Class** - Ultimate luxury experience

### 🛫 **Trip Types**
- **One Way** - Single direction flights
- **Round Trip** - Return flights included (return dates vary by route)
- **Multi-City** - Multiple destinations

### 💡 **How to Test**
1. **Search by Route:** Use any origin-destination pair listed above
2. **Filter by Date:** Use the specific dates mentioned for each route
3. **Try Different Classes:** Each route has multiple travel class options
4. **Test Trip Types:** Switch between one-way, round-trip, and multi-city
5. **Compare Options:** Many routes have multiple flights with different stops and prices

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

## 🔧 Building APK

To generate the APK file:

```bash
# For debug APK (faster build)
flutter build apk --debug

# For release APK (optimized)
flutter build apk --release
```

The APK will be located at:
- Debug: `build/app/outputs/flutter-apk/app-debug.apk`
- Release: `build/app/outputs/flutter-apk/app-release.apk`

---

## 📧 Submission

**GitHub Repository:** [https://github.com/olamideid/airgo](https://github.com/olamideid/airgo)

**APK File:** Send the generated APK file to `itsupport@ridefiapp` along with this GitHub link.

---

## 🤔 Assumptions Made

During development, I made the following assumptions:

### **Data & API**
- **Mock Data:** Since no live API was provided, I created comprehensive mock flight data covering domestic and international routes
- **Flight Prices:** Assumed prices in Nigerian Naira (₦) based on realistic market rates
- **Airport Codes:** Used standard IATA codes for all airports
- **Flight Duration:** Calculated realistic flight times based on actual routes

### **User Experience**
- **Search Behavior:** Assumed users would want to see results immediately without complex filters initially
- **Favorite Flights:** Assumed users would want to save flights for later comparison
- **Date Selection:** Each mock flight has a predefined departure and return date
- **Multi-passenger:** Assumed passengers would want seat assignments when booking multiple seats

### **Technical Decisions**
- **State Management:** Chose Riverpod for its simplicity and powerful features
- **Architecture:** Implemented Clean Architecture (my first time!) to demonstrate architectural knowledge
- **Offline Support:** Assumed the app should work without internet connectivity using local mock data
- **Platform:** Focused on mobile-first design, optimized for both iOS and Android

### **Business Logic**
- **Travel Classes:** Assumed standard airline class structure (Economy, Premium Economy, Business, First)
- **Trip Types:** Assumed support for One Way, Round Trip, and Multi-City options
- **Booking Flow:** Assumed a simplified booking process for demonstration purposes


### **UI/UX Design**
- **Color Scheme:** Chose a blue-based theme commonly associated with travel apps
- **Animation:** Assumed smooth transitions would enhance user experience
- **Responsive Design:** Assumed the app should work well on various screen sizes
- **Loading States:** Assumed users need clear feedback during data loading

### **Performance**
- **Local Storage:** Assumed favorites should persist between app sessions
- **Image Handling:** Assumed airline logos would be provided as assets
- **Memory Management:** Assumed efficient list handling for large flight results

---

## 📱 Device Requirements

- **Flutter Version:** 3.0+
- **Dart Version:** 3.0+
- **Android:** API level 21+ (Android 5.0+)
- **iOS:** 11.0+

---

## 🔍 Testing the App

1. **Start with sample routes** listed in the "Sample Flight Data" section
2. **Try different combinations** of dates, classes, and trip types
3. **Test offline functionality** by turning off internet
4. **Explore favorites** by tapping the heart icon on flights
5. **Check seat assignments** when booking multiple passengers
---

## 📸 Screenshots

> *Coming soon...*

---

## 👨‍💻 Author

**[@olamideid](https://github.com/olamideid)**