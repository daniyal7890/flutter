# Event Booking App

A simple event booking application developed using Flutter and Dart. The app allows users to browse available events, view event details, book events, manage their bookings, and view the total booking cost.

## Features

- Browse available events
- View event name, date, image, and price
- Open detailed information for each event
- Book events
- View booked events
- Remove events from bookings
- Display booking count using a badge
- Automatically calculate total booking cost
- Hero animations between event screens
- Smooth navigation between screens

## Technologies Used

- Flutter
- Dart
- Material Design
- Flutter Navigator
- StatefulWidget
- ListView
- Asset Images
- Hero Animations

## Application Screens

### Events Screen
Displays the available events with their images, dates, prices, and booking options.

### Event Details Screen
Displays detailed information about the selected event and allows the user to book it.

### Your Bookings Screen
Displays all booked events, allows users to remove bookings, and calculates the total booking cost.

## Sample Events

The application currently includes:

- Movie Premiere
- Vintage Car Expo
- Photography Workshop

## Project Structure

The main application logic is located in:

`lib/main.dart`

Event images are stored in:

`assets/`

## How to Run

1. Clone or download this repository.
2. Open the project in Android Studio or VS Code.
3. Make sure Flutter is installed and configured.
4. Run:

```bash
flutter pub get
