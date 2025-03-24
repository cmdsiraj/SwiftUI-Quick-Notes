- We can't use `@State` with class.
  - __Reason:__ `@State` looks for a change in the variable. Since `structs` are value types, any modification results in a new instance being created, which updates the view. so `@State` can track it. but for a `class`, a new instane won't be created. so `@State` can't track it.
- For classes, `@Observable` can be used. It tells SwiftUI to watch each individual property inside the class for changes, and reload any view that relies on a property when it changes.
- Example:
  ```swift
  @Observable
  class User {
      var firstName = "Bilbo"
      var lastName = "Baggins"
  }
- `@Observable` is a ***macro***. It is Swift's way of quietly rewriting our code to add extra functionality.
- When we expand the ***macro*** (can be done by right clicking on it), we can see the following code:
  ```swift
  import Observation
  @Observable
  class User {
      @ObservationTracked
      var firstName = "Bilbo
      @ObservationTracked
      var lastName = "Baggins"
      @ObservationIgnored private let _$observationRegistrar = Observation.ObservationRegistrar()

      internal nonisolated func access<Member>(
          keyPath: KeyPath<User, Member>
      ) {
          _$observationRegistrar.access(self, keyPath: keyPath)
      }
      
      internal nonisolated func withMutation<Member, MutationResult>(
          keyPath: KeyPath<User, Member>,
          _ mutation: () throws -> MutationResult
      ) rethrows -> MutationResult {
          try _$observationRegistrar.withMutation(of: self, keyPath: keyPath, mutation)
      }
  }
  extension User: Observation.Observable {
  }

1. Our two properties are marked `@ObservationTracked`, which means Swift and SwiftUI are watching them for changes.
2. If you right-click on `@ObservationTracked` you can expand that ***macro*** too – yes, it's a ***macro*** inside a ***macro***. This ***macro*** has the job of tracking whenever any property is read or written, so that SwiftUI can update only views that absolutely need to be refreshed.
3. Our class is made to conform to the `Observable` protocol. This is important, because some parts of SwiftUI look for this to mean "this class can be watched for changes."

- When working with structs, the `@State` property wrapper keeps a value alive and also watches it for changes.
- On the other hand, when working with classes, `@State` is just there for ***keeping object alive*** – all the ***watching for changes and updating*** the view is taken care of by `@Observable`.
