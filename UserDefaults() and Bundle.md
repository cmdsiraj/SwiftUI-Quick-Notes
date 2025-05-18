# UserDefaults()
- It allows to store small amount of ***User Data***
- Whatever is stored in the `UserDefaults` will be automaticaly loaded when the app is launched. So, if we store large amount of data, then the app launch will slow down.
    - There is no limit to the amount of data that can be stored in the `UserDefaults`. But it is better not to store no more than `512KB`.
- ```Swift
  UserDefaults.standard.set(tapCount, forKey: "Tap")

1. We need to use `UserDefaults.standard`. This is the built-in instance of UserDefaults that is attached to our app
2. There is a single `set()` method that accepts any kind of data – `integers`, `Booleans`, `strings`, and more.
3. We attach a string name to this data, in our case it’s the key “Tap”. This key is case-sensitive, just like regular Swift strings, and it’s important – we need to use the same key to read the data back out of `UserDefaults`.

- Reading back data:
  ```Swift
  @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")

- SwiftUI provides an `@AppStorage` property wrapper around `UserDefaults`.
- What it does is let us effectively ignore UserDefaults entirely, and just use @AppStorage rather than @State, like this:
  ```Swift
  struct ContentView: View {
    @AppStorage("tapCount") private var tapCount = 0

    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
        }
    }
  }

----


- With `@AppStorage`, we can store simple data types.
- When working with complex data, we need to use `@UserDefaults`.
- When working with complex data types, we need to use a protocol called `Codable`.
- `Codable` is a protocol that allows to ***archive and unarchive data*** (converting data to plain text and back again).
- When we use the `Codable` protocol, Swift will automatically generate some code for us that will archive and unarchive User instances for us as needed, but we still need to tell Swift when to archive and what to do with the data.
- This part is done by `JSONEncoder`. It takes data object and returns `JSON OBJECTS`. `Codable` can be used with other type of encoders but JSON Encoder is the most common one.
- By using the `encode()` method of `JSONEncoder`, we can archive our data object to `JSON object`. this might throw some errors, so we need to use with `try` or `try?`.
- Example:
  ```Swift
  struct User: Codable {
    let firstName: String
    let lastName: String
  }
  ```
  
  ```Swift
  @State private var user = User(firstName: "Taylor", lastName: "Swift")
  ```
  
  ```Swift
  Button("Save User") {
    let encoder = JSONEncoder()

    if let data = try? encoder.encode(user) {
        UserDefaults.standard.set(data, forKey: "UserData")
    }
  }
  

- To convert the data back from ***JSON Object*** to `Codable` object, we need to use `JSONDecoder`. (The process is almost same as decoding).

---------------

# Bundle Extension for Decoding JSON

## Purpose

- Centralizes the logic for loading and decoding JSON files from the app bundle.
- Keeps view code (e.g., `ContentView`) clean and focused.
- Enables reusable, maintainable decoding functionality.

---

## Bundle Extension Setup

### Create `Bundle-Decodable.swift`

- Add a method inside a `Bundle` extension.
- Method name: `decode(_ file: String)`
- Example return type: `[String: Astronaut]`

---

## Base Implementation

```swift
extension Bundle {
    func decode(_ file: String) -> [String: Astronaut] {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode([String: Astronaut].self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}
```
### How it works?
- **Locate file:** Uses `url(forResource:withExtension:)` to get the file path.
- **Load data:** Reads file content into a `Data` object.
- **Decode JSON:** Uses `JSONDecoder` to convert JSON into a Swift dictionary.
