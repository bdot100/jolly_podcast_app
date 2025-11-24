# Jolly Podcast App

A modern Flutter podcast application built with clean architecture principles, featuring authentication, podcast browsing, audio playback, and a persistent mini-player.

## 📱 Features

- **User Authentication**: Secure login with JWT token management
- **Podcast Discovery**: Browse trending episodes and editor's picks
- **Audio Playback**: Full-featured player with play/pause, seek, and track controls
- **Persistent Mini-Player**: Continue listening while navigating through the app
- **Theme Support**: Light, Dark, and System theme modes
- **Favorites**: Save and search your favorite podcasts
- **Responsive UI**: Beautiful, modern interface with smooth animations

## 🏗️ Project Structure

The project follows a clean, modular architecture:

```
lib/
├── controllers/          # State management (GetX Controllers)
│   ├── auth_controller.dart
│   ├── favorites_controller.dart
│   ├── player_controller.dart
│   ├── podcast_controller.dart
│   └── theme_controller.dart
├── models/              # Data models
│   ├── podcast_model.dart
│   └── user_model.dart
├── services/            # API and business logic
│   └── api_service.dart
├── utils/               # Constants and themes
│   ├── constants.dart
│   └── themes.dart
├── views/               # UI components
│   ├── auth/
│   │   └── login_view.dart
│   ├── favorites/
│   │   └── favorites_view.dart
│   ├── home/
│   │   ├── home_view.dart
│   │   └── podcast_list_view.dart
│   ├── player/
│   │   └── player_view.dart
│   ├── profile/
│   │   └── profile_view.dart
│   └── widgets/
│       ├── mini_player.dart
│       ├── podcast_card.dart
│       └── podcast_list_item.dart
└── main.dart
```

## 🎯 Architecture Highlights

### State Management
- **Framework**: GetX
- **Reactive Programming**: Observables (`.obs`) for automatic UI updates
- **Dependency Injection**: `Get.put()` and `Get.find()` for controller management
- **Global State**: Centralized audio player state accessible across the app

### API Integration
- **HTTP Client**: `http` package for RESTful API calls
- **Authentication**: Bearer token-based authentication
- **Endpoints**:
  - `/api/auth/login` - User authentication
  - `/api/episodes/trending` - Trending podcasts
  - `/api/episodes/editor-pick` - Featured podcast
  - `/api/podcasts/handpicked` - Curated podcasts

### Reusable Components
- **PodcastCard**: Horizontal card for trending episodes
- **PodcastListItem**: Detailed card for editor's picks and favorites
- **MiniPlayer**: Persistent bottom player with playback controls
- **Theme-aware widgets**: All components adapt to light/dark themes

### Code Quality
- **Separation of Concerns**: Clear separation between UI, business logic, and data
- **Single Responsibility**: Each controller manages a specific feature
- **DRY Principle**: Reusable widgets and shared utilities
- **Type Safety**: Proper null-safety implementation
- **Error Handling**: Try-catch blocks with user-friendly error messages

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / Xcode (for mobile development)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd jolly_podcast_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Test Credentials
- **Phone**: `08114227399`
- **Password**: `Development@101`

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.6              # State management
  http: ^1.1.0             # HTTP client
  get_storage: ^2.1.1      # Local storage
  google_fonts: ^6.1.0     # Custom fonts
  audioplayers: ^5.2.1     # Audio playback
```

## 🎨 State Management Approach

**Chosen Framework**: GetX

**Rationale**:
- **Simplicity**: Minimal boilerplate compared to Bloc or Provider
- **Performance**: Efficient reactive updates with `.obs` observables
- **Built-in Features**: Navigation, dependency injection, and state management in one package
- **Developer Experience**: Clean syntax and easy debugging

**Implementation**:
- Controllers extend `GetxController` for lifecycle management
- Observables (`.obs`) trigger automatic UI rebuilds
- `Obx()` widgets listen to state changes
- Global state for audio player ensures playback continuity

## 🔧 Key Technical Decisions

### Persistent Mini-Player
**Implementation**: 
- Created `PlayerController` as a global singleton
- Audio state managed centrally using `audioplayers` package
- `MiniPlayer` widget observes `PlayerController` state
- Positioned above bottom navigation for consistent visibility

**Benefits**:
- Seamless audio playback across screens
- Single source of truth for player state
- No duplicate audio instances

### Theme Management
**Implementation**:
- `ThemeController` with `GetStorage` for persistence
- Three modes: Light, Dark, System
- Dynamic color schemes for all components

### API Response Handling
**Pattern**:
```dart
// Nested JSON structure: data -> data -> data
final body = jsonDecode(response.body);
final List<dynamic> items = body['data']['data']['data'];
```

## 🎯 Assumptions Made

1. **Mini-Player Implementation**: Added a persistent mini-player to enhance UX by allowing users to navigate the app while podcasts continue playing. This wasn't explicitly in the requirements but is a standard feature in modern podcast apps.

2. **Navigation Mapping**: Temporarily mapped "Categories" to Favorites and "Your Library" to Profile, as these features are not yet fully implemented.

3. **Author Field**: Added author support to the Podcast model based on the Editor's Pick API response structure.

## 🚧 Future Improvements

Given more time, I would implement:

1. **Additional Screens**:
   - Dedicated Categories page with genre filtering
   - Your Library with listening history and downloads
   - Podcast details page with episode list
   - Search functionality across all podcasts

2. **Enhanced Features**:
   - Playlist management (queue system)
   - Download episodes for offline listening
   - Playback speed control
   - Sleep timer
   - Share podcasts to social media

3. **Performance Optimizations**:
   - Image caching for thumbnails
   - Pagination for large podcast lists
   - Background audio playback
   - Audio streaming optimization

4. **Testing**:
   - Unit tests for controllers and services
   - Widget tests for UI components
   - Integration tests for critical flows

5. **Accessibility**:
   - Screen reader support
   - Keyboard navigation
   - High contrast mode

## 📝 Code Quality Checklist

✅ **Clean Architecture**: Modular structure with clear separation of concerns  
✅ **State Management**: GetX with reactive programming  
✅ **API Integration**: Proper HTTP handling with error management  
✅ **Reusable Components**: Shared widgets across the app  
✅ **Code Readability**: Meaningful names and consistent formatting  
✅ **Best Practices**: Null safety, error handling, and resource management  

## 📄 License

This project is created for evaluation purposes.

## 👤 Author

**Okunade Bidemi Samson**

- 📧 Email: [bidemiokunade@gmail.com](mailto:bidemiokunade@gmail.com)
- 💻 GitHub: [github.com/bdot100](https://github.com/bdot100)
- 💼 LinkedIn: [linkedin.com/in/bidemi-okunade-415a38241](https://www.linkedin.com/in/bidemi-okunade-415a38241)
- 🐦 X (Twitter): [@bidemiokunade](https://x.com/bidemiokunade?s=21&t=_JAAgb5wlL3AzyVSZu891A)
