# Random User App

A Flutter application that demonstrates working with REST APIs, pagination, filtering, sorting, search functionality, and state management.

## Features

- Fetch and display a list of users from the RandomUser API
- Infinite scrolling pagination
- Sorting users alphabetically by name (A-Z, Z-A)
- Filter users by gender
- Search users by name
- Pull-to-refresh functionality
- Detailed user profile view
- Responsive layout
- Light and dark theme support

## Architecture Overview

This project follows a clean architecture approach with GetX for state management. The project structure is organized as follows:

```
lib/
├── app/
│   ├── core/
│   │   ├── error/       
│   │   └── network/    
│   ├── routes/
├── features/
│   └──home/
│   │   ├──data/
│   │   ├──domain
│   │   └──presentation/
│   └──user_details/
│
└── main.dart             
```

## State Management Choice

This project uses GetX for state management because:

- It provides a simple and intuitive way to manage application state
- It includes built-in dependency injection
- It offers easy navigation and route management
- It has minimal boilerplate code
- It provides reactive programming capabilities


## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the application
