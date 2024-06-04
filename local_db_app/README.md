## Flutter Floor PoC - Movie App with Genres

This is a Proof-of-Concept (PoC) application built with Flutter to demonstrate using Floor for local data persistence. The app simulates a movie database where movies can have multiple genres.

### Getting Started

1. Clone the repository.
2. Ensure you have [Flutter installed](https://docs.flutter.dev/get-started/install).
3. Run `flutter pub get` to install dependencies.

### Running the App

1. Open the project in your preferred IDE.
2. Run the app on a physical device or emulator using `flutter run`.

### Understanding Floor Usage

This app showcases the following Floor functionalities:

- Defining entities for Movie, Genre, and the many-to-many relationship between them using `MovieToGenre`.
- Creating a database view (`MovieWithGenres`) to efficiently retrieve movies with their associated genre names.
- Inserting movie data along with genre relationships.
- Preloading the database with sample data on app launch.

**Preloading the Database**

The app preloads the database with sample movie and genre data during Floor initialization. This data is read from separate JSON files located within the project. This demonstrates how to populate the database with initial data on app launch.

**Note:** The database schema visualization is available in `documentation/database.jpg`:
![Database schema](https://github.com/adbrepo/curso_flutter/blob/main/local_db_app/documentation/database.jpg?raw=true)

### Additional Notes

- This PoC focuses on core functionalities. Error handling and UI implementation are not included for brevity.
- Consider implementing features like individual genre retrieval, movie updates, and deletion based on your needs.

### License

This project is licensed under the [MIT License](https://opensource.org/license/mit). See the LICENSE file for details.
