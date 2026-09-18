# YesDhobi - Customer App

A modern, responsive on-demand laundry and dry-cleaning mobile application built with Flutter. YesDhobi provides customers with a seamless experience for scheduling laundry pickups, tracking orders in real-time, and managing delivery addresses.

---

## 🚀 Features

- **Onboarding & Authentication:**
  - Modern onboarding walkthrough
  - Phone-based Authentication (Login, Register, OTP Verification)

- **Service Exploration:**
  - Dynamic home screen with featured services, banner offers, and quick actions
  - Comprehensive laundry categories: Wash & Fold, Steam Ironing, Dry Cleaning, Premium Care, etc.

- **Booking Flow:**
  - **Item Selection:** Interactive item picker with real-time price calculation
  - **Schedule Pickup & Delivery:** Flexible date and time-slot selection
  - **Address Management:** Add, edit, and select pickup/delivery locations
  - **Order Summary:** Detailed pricing, applied discounts, taxes, and payment breakdown
  - **Order Confirmation:** Instant order booking with confirmation screen

- **Order Management & Tracking:**
  - Real-time order status tracking with timeline progression
  - Detailed order history for active and completed orders
  - Direct customer support and help center integration

---

## 🛠️ Tech Stack & Architecture

- **Framework:** [Flutter](https://flutter.dev/) (v3.13+) / Dart
- **Design System:** Material Design with custom theming and typography ([Google Fonts](https://pub.dev/packages/google_fonts))
- **Icons:** Cupertino & Material Icons
- **Project Structure:**
  ```text
  lib/
  ├── main.dart             # App entry point & routing configuration
  ├── models/               # Data models (Orders, Services, Items, Address)
  ├── screens/              # UI Screens (Auth, Home, Scheduling, Tracking, etc.)
  ├── state/                # State management and app data controllers
  ├── theme/                # Custom colors, themes, and typography
  └── widgets/              # Reusable UI components and cards
  ```

---

## 🏁 Getting Started

### Prerequisites

Ensure you have the following installed on your development machine:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.13.1 or higher)
- [Dart SDK](https://dart.dev/get-dart)
- Android Studio / Xcode (for Android and iOS emulators)
- VS Code or Android Studio with Flutter & Dart extensions

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/testyesdhobi-maker/yesdhobi_customer.git
   cd yesdhobi_customer
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the application:**
   ```bash
   flutter run
   ```

### Building the Project

- **Android APK:**
  ```bash
  flutter build apk --release
  ```
- **Android App Bundle (AAB):**
  ```bash
  flutter build appbundle --release
  ```
- **iOS:**
  ```bash
  flutter build ios --release
  ```

---

## 📄 License

This project is proprietary and confidential. All rights reserved.
