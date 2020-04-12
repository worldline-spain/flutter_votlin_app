# Provider

In this branch, we are using the [provider package](https://pub.dev/packages/provider), in combination with [rxdart behavior subjects](https://pub.dartlang.org/packages/rxdart)
With this combination, we can implement some kind of MVVM pattern.
We have defined a abstraction [here](lib/app/core/viewmodel) to reduce boilerplate.

## Limitations of Provider approach
- We need add BehaviorSubjects from rxdart to make things easier.
- We have strong dependency on Provider package