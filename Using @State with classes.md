## SwiftUI: `@State`, Structs & Classes

### 1. `@State` with Structs
- `@State` tracks changes and updates the UI.
- Structs are **value types** – changing a property creates a new instance.
- Example:
  ```swift
  struct User {
      var firstName = "Bilbo"
      var lastName = "Baggins"
  }

  struct ContentView: View {
      @State private var user = User()
      var body: some View {
          VStack {
              Text("Your name is \(user.firstName) \(user.lastName).")
              TextField("First name", text: $user.firstName)
              TextField("Last name", text: $user.lastName)
          }
      }
  }

### 2. Why Structs Can’t Share Data
- Each view gets a **separate copy** of the struct.
- Changes are local to that view, not shared across views.

### 3. Using Classes to Share Data
- **Reference type** – multiple views can share the same instance.
- **`@State` doesn't work** with classes because:
  - `@State` detects **new instances**, but class properties change inside the same instance.
  - UI **won't update** when a class property changes.

### 4. Fixing with @Observable
- `@Observable` makes SwiftUI track class property changes.
- Example:
  ```swift
  @Observable
  class User {
      var firstName = "Bilbo"
      var lastName = "Baggins"
  }

### 5. Why Structs Need `mutating` but Classes Don’t
- **Structs**: Changing a property creates a **new struct**, so functions modifying properties need `mutating`.
  (everytime we change a value with in the structure, a new instance (a copy) of the new structure is created. so we get error when we change values in a structure directly. thats why structures use the `mutating` methods to update its variables) 
- Example:
  ```swift
  struct User {
      var firstName = "Bilbo"
      mutating func updateName(newFirst: String) {
          firstName = newFirst  // Needs `mutating`
      }
  }
- **Classes**: Properties can change inside the same instance, no `mutating` needed.


