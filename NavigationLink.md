# NavigationStack and NavigationLink

## NavigationStack Overview
- `NavigationStack` shows a navigation bar and enables pushing views onto a view stack.
- Used for hierarchical navigation, e.g., Settings > Wi-Fi or Messages > Person.
- Different from `sheet()`:
  - `NavigationStack` = deeper navigation into related content.
  - `sheet()` = unrelated content like settings or modals.
#### Example:
   ```swift
    struct ContentView: View {
      var body: some View {
        NavigationStack {
          Text("Tap Me")
          .navigationTitle("SwiftUI")
        }
      }
    }
``` 
## NavigationLink
- `NavigationLink` is used inside a `NavigationStack` to push to a new view.
- Can be used with simple text or complex custom views.
- Pushes destination when the label is tapped.
#### Example:
```swift
NavigationStack {
    NavigationLink("Tap Me") {
        Text("Detail View")
    }
    .navigationTitle("SwiftUI")
}
```
- "Tap Me" behaves like a button.
- Tapping pushes a new view with "Detail View".
- Title turns into a back button.
#### Custom Lable Example
```swift
NavigationStack {
    NavigationLink {
        Text("Detail View")
    } label: {
        VStack {
            Text("This is the label")
            Text("So is this")
            Image(systemName: "face.smiling")
        }
        .font(.largeTitle)
    }
}
```
- Tappable label can be customized using any views.
  
## NavigationLink vs. sheet()
**Use NavigationLink:**
- To show details or go deeper into related views.
- Commonly used in lists for drill-down navigation.
**Use sheet():**
- To present unrelated content (e.g., compose, settings).
```swift
NavigationStack {
    List(0..<100) { row in
        NavigationLink("Row \(row)") {
            Text("Detail \(row)")
        }
    }
    .navigationTitle("SwiftUI")
}
```
