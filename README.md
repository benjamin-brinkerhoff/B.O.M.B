# B.O.M.B — Book of Mormon & Bible Study

<p align="center">
  <b>A unified, cross-platform scripture study application designed for deep comparative analysis of the Book of Mormon and the Holy Bible.</b>
</p>

---

## Overview

**B.O.M.B** is built from the ground up as a high-performance, distraction-free study tool. It bridges the text of the **Book of Mormon**, the **Old Testament**, and the **New Testament**, enabling cross-referencing, parallel side-by-side reading, topical search, and personalized annotations across all major operating systems.

### Core Goals
- **Unified Scripture Library**: Seamless reading experience across both the Bible (KJV or modern public-domain translations) and the Book of Mormon.
- **Parallel & Comparative Reading**: Read corresponding passages simultaneously (e.g., Isaiah passages in 2 Nephi, or Christ's ministry in 3 Nephi alongside the Gospels).
- **True Cross-Platform Experience**: Built with a single codebase targeting **iOS**, **Android**, **Windows**, **macOS**, and **Linux** with responsive desktop & mobile interfaces.
- **Offline-First**: Fully functional without internet connectivity, storing scripture texts and personal notes locally.

---

## Supported Platforms

| Platform | Tier | Target Output | Status |
| :--- | :--- | :--- | :--- |
| **Android** | Primary | APK / AAB | Framework Ready |
| **iOS** | Primary | IPA / Xcode Runner | Framework Ready |
| **Windows** | Extended | Native x64 Executable (.exe) | Supported via Flutter Desktop |
| **macOS** | Extended | Universal Binary (.app / dmg) | Supported via Flutter Desktop |
| **Linux** | Extended | GTK+ Native Binary / Flatpak / Snap | Supported via Flutter Desktop |

---

## Architecture & Project Structure

The project follows a modular, feature-first clean architecture:

```text
lib/
├── main.dart                       # Entry point & desktop window setup
├── app.dart                        # MaterialApp, routing & global themes
├── core/
│   ├── constants/
│   │   └── app_constants.dart      # Global volume and scripture metadata
│   ├── models/
│   │   └── scripture_volume.dart   # Scripture, Volume, Book, and Chapter data models
│   └── theme/
│       └── app_theme.dart          # Light and Dark Material 3 typography & themes
└── features/
    ├── navigation/
    │   └── presentation/
    │       └── main_shell.dart     # Responsive layout (BottomNav on mobile, NavRail on desktop)
    ├── reader/
    │   └── presentation/
    │       └── reader_screen.dart  # Scripture reader & chapter navigation
    ├── study/
    │   └── presentation/
    │       └── parallel_study_screen.dart # Split-pane comparative reader
    ├── study_tools/
    │   └── presentation/
    │       └── study_tools_screen.dart    # Topical index, search & references
    └── settings/
        └── presentation/
            └── settings_screen.dart       # Typography, font sizing & preferences
```

---

## Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (version 3.19.0 or higher)
- [Dart SDK](https://dart.dev/get-dart) (included with Flutter)
- Platform-specific tooling:
  - **Android**: Android Studio / Android SDK command-line tools
  - **iOS / macOS**: macOS with Xcode 15+ and CocoaPods
  - **Windows**: Visual Studio 2022 with "Desktop development with C++"
  - **Linux**: `clang`, `cmake`, `ninja-build`, `pkg-config`, `libgtk-3-dev`

### Installation & Run

1. Clone the repository:
   ```bash
   git clone https://github.com/benjamin-brinkerhoff/B.O.M.B.git
   cd B.O.M.B
   ```

2. Fetch dependencies:
   ```bash
   flutter pub get
   ```

3. Run on your desired connected device or emulator:
   ```bash
   # Mobile
   flutter run -d android
   flutter run -d ios

   # Desktop
   flutter run -d windows
   flutter run -d macos
   flutter run -d linux
   ```

4. Building release binaries:
   ```bash
   # Android APK
   flutter build apk --release

   # iOS IPA
   flutter build ipa --release

   # Windows
   flutter build windows --release

   # macOS
   flutter build macos --release

   # Linux
   flutter build linux --release
   ```

---

## Continuous Integration

A GitHub Actions workflow is provided in `.github/workflows/flutter_ci.yml` that automatically lints, analyzes, and tests pull requests and commits to `main`.
