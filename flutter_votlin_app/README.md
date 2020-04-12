# Stream builder branch (without use cases)

In this branch, we are using the [stream builder](https://www.youtube.com/watch?v=MkKEWHfy99Y), in combination with [rxdart behavior subjects](https://pub.dartlang.org/packages/rxdart)
With this combination, we can implement some kind of MVVM pattern.
We have defined a abstraction [here](lib/app/core/stream_builder) to reduce boilerplate.

Sometimes, the use cases are not really needed, because are like a proxy to repositories, so in this branch we have eliminated the use cases.
The threading is now managed in our stream builder abstraction.

## Limitations of Stream builder pattern
- We need add BehaviorSubjects from rxdart to make things easier.
- Unit testing looks difficult. Testing asynchronous code is always more diffcult than testing synchronous code.
- It looks more complex than scope model, but it is possible to put some code in base classes to reduce complexity.

## Limitations of single package approach
- If we are not strict with pull requests, project can be destroyed.