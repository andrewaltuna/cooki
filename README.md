# Cooki

A smart shopping assistant that combines AI and IoT technology to enhance the grocery shopping experience.

## Overview

Cooki transforms traditional grocery shopping by leveraging:

- **Bluetooth Beacon Technology**: Precise in-store navigation and product location tracking
- **AI-Powered Assistance**: Integration with Gemini for intelligent shopping recommendations
- **Health-Aware Shopping**: Proactive identification of dietary restrictions and product alternatives
- **Real-time Product Information**: Instant access to detailed product data and certifications

## Technical Features

### Location Services
- BLE Beacon integration for accurate indoor positioning
- Real-time section and product proximity alerts
- Turn-by-turn navigation to product locations

### Shopping Management
- Smart shopping list organization by store sections
- Budget tracking and price monitoring
- Alternative product suggestions based on preferences
- Real-time product availability updates

### Health & Sustainability
- Product certification verification
- Dietary restriction compliance checks
- Eco-friendly product recommendations
- Manufacturer sustainability tracking

## Technical Stack

- **Framework**: Flutter (SDK ≥3.4.1)
- **State Management**: 
  - Flutter Bloc
  - Flutter Hooks
  - Equatable
- **Navigation**: Go Router
- **Backend Integration**: GraphQL
- **IoT**: Flutter Beacon
- **Authentication**: Firebase Auth
- **UI Components**: Custom Material Design implementation

## Getting Started

1. Ensure you have Flutter ≥3.4.1 installed
2. Clone the repository
3. Install dependencies:

```bash
flutter pub get
```

environment:
  sdk: '>=3.4.1 <4.0.0'

dependencies:
  flutter:
    sdk: flutter

  # Firebase
  firebase_core: ^3.1.0
  firebase_auth: ^5.1.0

  # Beacon
  flutter_beacon: ^0.5.1

  # Navigation
  go_router: ^14.2.0

  # State
  flutter_bloc: ^8.1.6
  flutter_hooks: ^0.20.5
  equatable: ^2.0.5

  # Permissions
  permission_handler: ^11.3.1
  app_settings: ^5.1.1

  # UI
  fluttertoast: ^8.2.6
  flutter_markdown: ^0.7.3

  # Assets
  ionicons: ^0.2.2
  flutter_svg: ^2.0.10+1

  # API
  graphql_flutter: ^5.2.0-beta.7

  # Utils
  collection: ^1.18.0

  # Other
  flutter_launcher_icons: ^0.13.1
  shimmer: ^3.0.0
  cached_network_image: ^3.4.0
  expandable_page_view: ^1.0.17

```bash
flutter run
```

## Required Permissions

### Android
- Bluetooth
- Bluetooth Admin
- Bluetooth Scan
- Fine Location

### iOS
- Bluetooth
- Location When In Use

