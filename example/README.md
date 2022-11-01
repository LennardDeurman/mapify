# example

Mapify Example

## Getting Started

This project showcases the functionality of the mapify package

The project seperates its clean architecture flow by defining packages in the packages directory

- example_api (Call to api, and direct API parsing models)
- example_storage (Call to storage, such as shared preferences or local db)
- example_core (Will contain the models and contracts)
- example_data (Implementation of the contracts / combining layer)

The example_data will contain the mapping and handle this process. 

Mapify will use the build_runner to generate the mapper classes (.g.dart)

By default, these files are not checked in, so on initial setup running the build_runnrt is required

To run the build_runner and generate the mapping, inside example_data run:

flutter pub run build_runner build --delete-conflicting-outputs