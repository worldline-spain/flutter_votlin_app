# Platform channel branch (single package)
In this branch, we want to experiment with platform channel, used for communicate flutter code with android/ios specific code.
The objective of this branch is remove all the business logic and datasource implemented in dart and implement it in android/ios.

To do this, we have added a new flavor: platform flavor.
To run this flavor, execute `flutter run lib/main-platform.dart`

## Current state of this branch
Just moved the 'schedule.json' file to android project

## Methods implemented in platform channel
- getTalks() -> returns a json string with the content of 'schedule.json'

## Limitations of platform channel
- Not sure about how to pass complex objects between flutter and android/ios.