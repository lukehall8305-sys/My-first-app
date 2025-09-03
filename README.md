# Dog Boarding Booking App (iOS)

## Overview
An iOS application for managing reservations across **18 dog boarding kennels**. The app prevents double-booking, offers real-time availability tracking, and provides staff with an intuitive interface to add, edit, search, and cancel bookings.

## Features (MVP)
* Add new booking (auto-assign kennel, overlap prevention)
* Daily dashboard of kennel occupancy
* Search bookings by customer name / date
* Edit & cancel existing bookings

## Tech Stack
* Swift 5 + SwiftUI
* Firebase Firestore – real-time NoSQL database
* Combine – reactive bindings

## Project Structure
```
DogBoardingApp/
├── Models/
│   ├── Kennel.swift
│   ├── Booking.swift
│   └── Customer.swift
├── Services/
│   └── FirestoreService.swift
├── ViewModels/
│   └── BookingViewModel.swift
├── Views/
│   ├── ContentView.swift
│   ├── BookingListView.swift
│   ├── NewBookingView.swift
│   └── CalendarView.swift
└── DogBoardingApp.swift
```

## Running the App
1. Install Xcode 15+
2. Clone repository: `git clone <repo>`
3. Open `DogBoardingApp.xcodeproj`
4. Add a Firebase iOS app in the Firebase console and download `GoogleService-Info.plist` into the project root.
5. Build & run on an iOS 17+ simulator or device.

## Future Enhancements
* Customer self-service portal
* Calendar sync (Google/Outlook)
* Push notifications for booking reminders