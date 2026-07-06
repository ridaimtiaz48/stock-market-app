# Monex — Stock Market App

A cross-platform mobile app built with Flutter for tracking stocks, market news, and portfolio insights, with Google/Apple sign-in support.



## Features

- **Authentication** — Sign up/login flow with email, plus Google and Apple sign-in options
- **Stock Details** — View detailed information for individual stocks
- **Market News** — Browse market news with a dedicated news feed and detail view
- **Pro Tier** — Upgrade flow for premium features 
- **Splash & Onboarding** — Welcome/splash screens for first-time app experience

## Screens

| Screen | Purpose |
|---|---|
| Splash Screen | App launch/loading screen |
| Welcome Screen | Onboarding entry point |
| Login/Signup Choice | Auth method selection |
| Login Details | Email/password login |
| Signup Screen | New user registration |
| Home Screen | Main dashboard |
| Stock Detail Screen | Individual stock data view |
| News Screen | Market news feed |
| News Detail Screen | Full article view |
| Upgrade to Pro Screen | Premium subscription flow |

## Tech Stack

`Flutter` · `Dart` · Google Sign-In · Apple Sign-In

## Architecture

- **Frontend:** Flutter widgets organized by screen under `lib/screens/`
- **Stock Data Service:** `lib/screens/stock_service.dart` handles fetching and processing stock market data from `[FILL IN: API name]`
- **Cross-platform support:** Configured for Android, iOS, Windows, macOS, Linux, and Web via Flutter's multi-platform build targets

## Project Structure

```
monex/
├── lib/
│   ├── main.dart
│   └── screens/
│       ├── splash_screen.dart
│       ├── welcome_screen.dart
│       ├── login_signup_choice.dart
│       ├── login_details_screen.dart
│       ├── signup_screen.dart
│       ├── home_screen.dart
│       ├── stock_detail_screen.dart
│       ├── stock_service.dart
│       ├── news_screen.dart
│       ├── news_detail_screen.dart
│       └── upgrade_pro_screen.dart
├── assets/
│   ├── monex_logo.png
│   ├── google_icon.png
│   └── apple_icon.png
├── android/
├── ios/
├── web/
├── windows/
├── macos/
├── linux/
└── pubspec.yaml
```

## Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed
- An editor (VS Code or Android Studio recommended, with Flutter/Dart plugins)

### Setup
```bash
# Clone the repo
git clone https://github.com/ridaimtiaz48/stock-market-app.git
cd stock-market-app

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### API Key Setup
`[FILL IN: e.g., "Create a .env file with STOCK_API_KEY=your_key_here" or wherever the API key is configured]`

## Screenshots

`[FILL IN: add 2-3 screenshots of the app here for visual impact — this matters a lot for mobile app repos]`
```markdown
<p float="left">
  <img src="assets/screenshots/home.png" width="200" />
  <img src="assets/screenshots/stock_detail.png" width="200" />
  <img src="assets/screenshots/news.png" width="200" />
</p>
```

## Future Improvements

- `[FILL IN: any features you plan to add — e.g., watchlists, price alerts, portfolio tracking, dark mode]`

## License

This project was developed for academic/personal purposes.
