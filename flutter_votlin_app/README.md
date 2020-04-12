# Stream builder branch (with use cases)

In this branch, we are using the [stream builder](https://www.youtube.com/watch?v=MkKEWHfy99Y), in combination with [rxdart behavior subjects](https://pub.dartlang.org/packages/rxdart)
With this combination, we can implement some kind of MVVM pattern.
We have defined a abstraction [here](lib/app/core/stream_builder) to reduce boilerplate.

Sometimes, the use cases are not really needed, because are like a proxy to repositories, but in this branch we have use cases.
Probably, this approach is valid for big apps that share multiple repositories and business logic in multiple screens.

## Limitations of Stream builder pattern
- We need add BehaviorSubjects from rxdart to make things easier.
- Unit testing looks difficult. Testing asynchronous code is always more diffcult than testing synchronous code.
- It looks more complex than scope model, but it is possible to put some code in base classes to reduce complexity.

## Limitations of single package approach
- If we are not strict with pull requests, project can be destroyed.