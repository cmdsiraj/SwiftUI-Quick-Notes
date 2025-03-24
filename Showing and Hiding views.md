- There are several ways to show and hide views. one of the most basic ways is using ***sheets***: a new view is presented on top of our existing one.
- We define the conditions under which a ***sheet*** should be shown, and when those conditions become true or false the sheet will either be presented or dismissed respectively. Just like ***alerts***.
- Working with sheetes require four steps. but before this, we need to keep our second view ready. it is just like a normal view. no need to add anything extra to use it in our sheets.
  1. we need some state to track whether the sheet is showing. This can be a simple Boolean, so add this property to `ContentView` now:
     ```swift
     @State private var showingSheet = false
  2. We need to toggle that when our button is tapped. so that the second view can be shown.
  3. We need to attach our sheet somewhere to our view hierarchy. If you remember, we show `alerts` using `isPresented` with a two-way binding to our state property, and we use something almost identical here: `sheet(isPresented:)`.
     `sheet()` is a modifier just like `alert()`, so please add this modifier to our button now:
     ```swift
     .sheet(isPresented: $showingSheet) {
          // contents of the sheet
      }
  4. We need to decide what should actually be in the sheet. In our case, we already know exactly what we want: we want to create and show an instance of `SecondView`. In code that means writing `SecondView()`.
     Below is the complete code:
     
     ```Swift
     struct SecondView: View {
        var body: some View {
            Text("Second View")
        }
      }

    ```swift
    struct ContentView: View {
      @State private var showingSheet = false
  
      var body: some View {
          Button("Show Sheet") {
              showingSheet.toggle()
          }
          .sheet(isPresented: $showingSheet) {
              SecondView()
          }
      }
    }

- We can also pass parameters to our second view.
  
  ```swift
  struct SecondView: View {
      let name: String
  
      var body: some View {
          Text("Hello, \(name)!")
      }
  }
  
```swift
  .sheet(isPresented: $showingSheet) {
      SecondView(name: "@twostraws")
  }
```

______________

- We can dismiss our new view programatically using another property wrapper. This new one is called `@Environment`, and it allows us to create properties that store values provided to us externally.
- We need to ask the environment to dismiss our view, because it might have been presented in any number of different ways.
- To try it out add this property to ***SecondView***, which creates a property called dismiss based on a value from the ***environment***:
    ```swift
    @Environment(\.dismiss) var dismiss
    
Now replace the text view in ***SecondView*** with this button:

```swift
    Button("Dismiss") {
        dismiss()
    }
```
