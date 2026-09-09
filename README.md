# B.O.M.B — Book of Mormon & Bible Study

<p align="center">
  <b>A unified, cross-platform scripture study application designed for deep comparative analysis of the Book of Mormon and the Holy Bible.</b>
</p>

---

## Overview

**B.O.M.B** is built from the ground up as a high-performance, distraction-free scripture study tool. It bridges the text of the **Book of Mormon**, the **Old Testament**, and the **New Testament**, enabling quick hierarchical navigation, cross-volume search, multi-color highlighting, personal note-taking, and customizable reading typography across all major operating systems.

---

## Core Features

### 1. Rapid 3-Tier Navigation
- **Volume Selection:** Fast switching between **The Book of Mormon**, **The Old Testament**, and **The New Testament**.
- **Multiple Bible Translations:** First-class support for the **King James Version (KJV)** as the primary translation, with options for the **American Standard Version (ASV)**, **World English Bible (WEB)**, and **Bible in Basic English (BBE)**.
- **Hierarchical Drill-Down:** Tap the app bar or browse tool to quickly select:
  1. **Volume** (Book of Mormon / Old Testament / New Testament)
  2. **Book** (e.g., *Matthew*, *1 Nephi*, *Genesis*, *Alma*)
  3. **Chapter** (clean numeric grid to jump straight to any chapter)

### 2. Comprehensive Scripture & Note Search
- Global search engine querying both the Book of Mormon and the Bible simultaneously.
- **Search Filters:** Filter queries across *All Scriptures*, *Book of Mormon*, *Old Testament*, *New Testament*, or exclusively *My Notes*.
- **Note Indexing:** Personal study notes are indexed and searchable alongside canonical verses.
- Direct jump from any search result into the scripture reader.

### 3. Verse Markup & Note-Taking
- Tap any verse to open the **Verse Markup Sheet**:
  - **Highlighting:** 5 curated pastel highlight palettes (*Yellow*, *Green*, *Blue*, *Coral*, *Purple*) plus an eraser to remove highlights.
  - **Study Notes:** Add, edit, or delete personal commentary and cross-references directly attached to verses.
  - **Copy & Share:** Fast verse copying with formatted scripture references.
- **My Notes & Highlights Manager:** A dedicated study hub listing all saved notes and highlighted verses with direct navigation back to the text.

### 4. Reading Styles & Custom Typography
- **Display Themes:** System Default, Light, and Dark mode.
- **Typeface Selection:**
  - *Times New Roman / Editorial Serif* (traditional, elegant scripture typography)
  - *Arial / Clean Sans-Serif* (modern high-legibility sans)
  - *Georgia / Soft Serif* (warm, comfortable digital reading)
- **Dynamic Font Sizing:** Live slider ranging from 13pt to 28pt with a real-time typography preview window.

---

## Supported Platforms

| Platform | Tier | Target Output | Status |
| :--- | :--- | :--- | :--- |
| **Android** | Primary | APK / AAB | Implemented |
| **iOS** | Primary | IPA / Xcode Runner | Implemented |
| **Windows** | Extended | Native x64 Executable (.exe) | Supported via Flutter Desktop |
| **macOS** | Extended | Universal Binary (.app / dmg) | Supported via Flutter Desktop |
| **Linux** | Extended | GTK+ Native Binary / Flatpak / Snap | Supported via Flutter Desktop |

---

## Project Structure

```text
lib/
├── main.dart                                   # Entry point & binding initialization
├── app.dart                                    # Root MaterialApp, theme mode & AppScope
├── core/
│   ├── constants/
│   │   └── app_constants.dart                  # Global volume and scripture metadata
│   ├── data/
│   │   ├── scripture_canon.dart                # Complete Book of Mormon & Bible book definitions
│   │   └── scripture_repository.dart           # Offline verse provider & searchable database
│   ├── models/
│   │   └── scripture_models.dart               # Volume, Book, Verse, Annotation & Search models
│   ├── state/
│   │   ├── app_scope.dart                      # InheritedNotifier for dependency injection
│   │   └── app_state.dart                      # State: navigation, reading styles, markup, search
│   └── theme/
│       └── app_theme.dart                      # Material 3 light/dark reader palettes
└── features/
    ├── navigation/presentation/
    │   ├── main_shell.dart                     # Adaptive navigation (BottomNav on mobile, NavRail on desktop)
    │   └── scripture_picker_dialog.dart        # 3-step Volume -> Book -> Chapter picker
    ├── reader/presentation/
    │   ├── reader_screen.dart                  # Chapter reader, inline highlights & note badges
    │   └── verse_markup_sheet.dart             # Highlighting & note-taking bottom sheet
    ├── search/presentation/
    │   └── search_screen.dart                  # Multi-volume & personal notes search engine
    ├── notes/presentation/
    │   └── notes_screen.dart                   # Notes & highlights browser hub
    ├── study/presentation/
    │   └── parallel_study_screen.dart          # Side-by-side comparative reading view
    └── settings/presentation/
        └── settings_screen.dart                # Theme, font family, font size & translation controls
```

---

## Getting Started

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

3. Run on your target device:
   ```bash
   # Mobile (iOS & Android)
   flutter run -d android
   flutter run -d ios

   # Desktop (Windows, macOS, Linux)
   flutter run -d windows
   flutter run -d macos
   flutter run -d linux
   ```
