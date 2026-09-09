# B.O.M.B — Book of Mormon & Bible Study

<p align="center">
  <b>A unified, cross-platform scripture study application designed for deep comparative analysis of the Book of Mormon and the Holy Bible.</b>
</p>

---

## Overview

**B.O.M.B** is built from the ground up as a high-performance, distraction-free scripture study tool. It bridges the text of the **Book of Mormon**, the **Old Testament**, and the **New Testament**, enabling quick hierarchical navigation, cross-volume search, multi-color highlighting, personal note-taking, custom tag-based cross-referencing, Church-standard footnote cross-references, and an on-device dictionary across all major operating systems.

---

## Core Features



### 1. Home Dashboard & Study Analytics
- **Reading Streak Tracker:** Tracks current consecutive daily reading streak (e.g. 🔥 7 Days) with visual 7-day weekly activity circles and best streak record.
- **Study Time Tracking:** Records live time spent studying scripture today and all-time.
- **Reading Statistics:** Displays total chapters read, verses studied, and saved annotations.
- **Continue Reading Card:** 1-tap shortcut to immediately resume reading from where you left off.
- **Book Selection Carousel:** Browse and jump straight into any book across the Book of Mormon, New Testament, and Old Testament right from the home screen.
- **Verse of the Day:** Curated daily scripture with instant context reading.

### 2. Full Offline Scripture Text Engine
- **Complete Public Domain Canons Included:**
  - **The Book of Mormon:** Full 15 books, 239 chapters, **6,604 verses** from public-domain 2013-referenced text.
  - **The New Testament (KJV):** Full 27 books, 260 chapters, **7,957 verses**.
  - **The Old Testament (KJV):** Full 39 books, 929 chapters, **23,145 verses**.
- **Total:** **37,706 verses** bundled offline inside the application.
- **Lazy-Loaded In-Memory Caching:** Asynchronously parses and indexes volumes (`assets/scriptures/book_of_mormon.json`, `assets/scriptures/new_testament.json`, `assets/scriptures/old_testament.json`) on demand with instant $O(1)$ chapter retrieval.
- **Zero Internet Required:** Entire scripture study, reader navigation, and global search run 100% offline.

### 3. Rapid 3-Tier Navigation
- **Volume Selection:** Fast switching between **The Book of Mormon**, **The Old Testament**, and **The New Testament**.
- **Multiple Bible Translations:** First-class support for the **King James Version (KJV)** as the primary translation, with options for the **American Standard Version (ASV)**, **World English Bible (WEB)**, and **Bible in Basic English (BBE)**.
- **Hierarchical Drill-Down:** Tap the app bar or browse tool to quickly select:
  1. **Volume** (Book of Mormon / Old Testament / New Testament)
  2. **Book** (e.g., *Matthew*, *1 Nephi*, *Genesis*, *Alma*)
  3. **Chapter** (clean numeric grid to jump straight to any chapter)

### 4. Church-Standard Footnote Cross-References (Blue Links)
- **Blue Interactive Words:** Words with official Latter-day Saint style footnotes appear in royal blue with superscript footnote markers (e.g., `goodly¹ᵃ`, `mysteries¹ᵇ`, `commanded⁷ᵃ`).
- **Footnote Popup Sheet:** Tapping a blue word opens an interactive modal containing:
  - **Linguistic Meaning & Definitions:** Hebrew (*HEB*) and Greek (*GR*) roots or theological commentary.
  - **Topical Guide (TG) Links:** Shows doctrinal topics (e.g., *TG Faith*, *TG Mysteries of Godliness*, *TG Temple*).
  - **Scripture Cross-References:** Previews related passages across the Old Testament, New Testament, and Book of Mormon with one-tap jump buttons.
  - **Define Button:** Immediate shortcut to the full on-device dictionary definition.

### 5. Verse Tagging & Personal Cross-Referencing
- **Custom Tagging:** Attach multiple topic tags (e.g., `#Faith`, `#Commandments`, `#Prayer`, `#Covenants`) to any verse.
- **Personal Cross-Reference Links:** Link scriptures together (e.g., connect *1 Nephi 3:7* with *Philippians 4:13* or *James 1:5*).
- **Tags & Cross-Reference Explorer:** Centralized tab in the Notes screen to browse all tagged scriptures grouped by topic, view linked verse connections, and navigate immediately.

### 6. On-Device Scripture Dictionary Lookup
- Offline dictionary engine covering archaic King James English, Hebrew/Greek roots, and doctrinal terminology (e.g., *goodly*, *mysteries*, *afflictions*, *strait*, *succor*, *charity*, *grace*, *atonement*, *firmament*, *wisdom*).
- Search any word on-device to view pronunciation, part of speech, full definition, etymology, and canonical scripture occurrences.

### 7. Comprehensive Scripture, Note & Tag Search
- Global search engine querying both the Book of Mormon and the Bible simultaneously.
- **Search Filters:** Filter queries across *All Scriptures*, *Book of Mormon*, *Old Testament*, *New Testament*, or exclusively *My Notes & Tags*.
- **Unified Indexing:** Personal study notes and custom tags are indexed and searchable alongside canonical verses.
- Direct jump from any search result into the scripture reader.

### 8. Verse Markup & Note-Taking
- Tap any verse to open the **Verse Markup Sheet**:
  - **Highlights:** 5 pastel highlight tones (*Yellow*, *Green*, *Blue*, *Coral*, *Purple*) plus an eraser to remove highlights.
  - **Study Notes:** Add, edit, or delete personal commentary attached directly to verses.
  - **Copy Action:** Formats and copies verse text with book, chapter, and verse references to the clipboard.

### 9. Reading Styles & Custom Typography
- **Display Themes:** System Default, Light, and Dark mode.
- **Typeface Selection:**
  - *Times New Roman / Editorial Serif* (traditional, elegant scripture typography)
  - *Arial / Clean Sans-Serif* (modern high-legibility sans)
  - *Georgia / Soft Serif* (warm digital reading)
- **Font Scaling:** Live slider from 13 pt to 28 pt with a real-time typography preview window.

---


---

## Automated Builds & CI/CD

This repository includes an automated GitHub Actions workflow (`.github/workflows/build_mobile.yml`) that builds:
1. **Android APK**: Signed release APK (`B.O.M.B-release.apk`) ready for direct sideloading or distribution on Android devices.
2. **Unsigned iOS IPA**: Packaged unsigned IPA (`B.O.M.B-unsigned.ipa`) suitable for sideloading tools (AltStore, Sideloadly, TrollStore) or re-signing with personal developer certificates.

### How to Download Builds
1. Navigate to the **[Actions tab](https://github.com/benjamin-brinkerhoff/B.O.M.B/actions)** on GitHub.
2. Click on the latest run under **Build Mobile (Android APK & Unsigned iOS IPA)**.
3. Scroll down to the **Artifacts** section to download:
   - `B.O.M.B-Android-APK`
   - `B.O.M.B-iOS-Unsigned-IPA`
4. You can also manually trigger builds anytime by clicking **Run workflow** in the Actions tab.

## Supported Platforms

| Platform | Tier | Target Output | Status |
| :--- | :--- | :--- | :--- |
| **Android** | Primary | APK / AAB | Implemented |
| **iOS** | Primary | IPA / Xcode Runner | Implemented |
| **Windows** | Extended | Native x64 Executable (.exe) | Supported via Flutter Desktop |
| **macOS** | Extended | Universal Binary (.app / dmg) | Supported via Flutter Desktop |
| **Linux** | Extended | GTK+ Native Binary / Flatpak / Snap | Supported via Flutter Desktop |

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
