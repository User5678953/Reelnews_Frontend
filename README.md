# Reel News App

## Live Link

[Live Demo](https://reelnews.netlify.app)

**Reel News App** is a cross-platform mobile application built with **Flutter**. It provides a convenient way to access and read news articles from various sources, launch them in browser, categorize them, and even archive articles for later reading.

## Features

- **Curated News:** A user is able to filter news byu specific source based on  "subscribing" to a news source via a toggle which saves to user pref.

- **Multi-platform:** The app is designed to run on both iOS and Android devices, thanks to Flutter's cross-platform capabilities.

- **Categories:** News articles are categorized by topic, making it easy for users to find articles of interest.

- **Archiving:** Users can archive articles they want to save for later reading.

- **Local Storage:** The app uses local storage to save archived articles and user preferences.

- **User Authentication:** Users can register and log in to their accounts to access personalized features.
  - **JWT token:** on Register Users recieve a unique token from the backend

- **Simple Navigation:** The app uses Flutter's navigation system to switch between different screens and features.

- **API Fetching:** The app uses Gnews API https://gnews.io/ to fetch news.

## Getting Started

Follow these steps to get the app up and running:

1. **Install Flutter:** Make sure you have Flutter installed on your development machine. You can find installation instructions [here](https://flutter.dev/docs/get-started/install).

2. **Clone the Repository:** Clone this repository to your local machine using `git clone`.

3. **Run the App:** Use the `flutter run` command to run the app on an emulator, connected device or right in the browser.

## Backend
- [here](https://reelnews-api-fe5e8d8c10e8.herokuapp.com/)
- - [Repo here](https://github.com/User5678953/ReelNews_Backend)

- **Django DFR is used for authentication:** T


//String apiKey = 'a579a4147a5089e75fd1164a4d7331e1';