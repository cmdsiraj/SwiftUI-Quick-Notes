SwiftUI allows us to create custom transitions using `.modifier` and custom `ViewModifier` implementations.
**Key Concepts**
- `.modifier` transition lets us apply any view modifier as a transition.
- `rotationEffect()` rotates a view around the Z-axis, and we can control its anchor point using UnitPoint (e.g., .topLeading, .center).
- `.clipped()` ensures content outside the original bounds is not drawn.

### Creating a Custom Pivot Transition
1. **Define a Custom ViewModifier for Rotation**
   ```Swift
       struct CornerRotateModifier: ViewModifier {
        let amount: Double
        let anchor: UnitPoint
    
        func body(content: Content) -> some View {
            content
                .rotationEffect(.degrees(amount), anchor: anchor)
                .clipped()
        }
      }
   ```
   - Rotates a view by `amount` degrees.
   - Uses `clipped()` to keep the view within bounds.
2. **Wrap in an AnyTransition Extension**
   ```Swift
       extension AnyTransition {
        static var pivot: AnyTransition {
            .modifier(
                active: CornerRotateModifier(amount: -90, anchor: .topLeading),
                identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
            )
        }
      }
   ```
   - Defines a reusable `pivot` transition.
   - Moves from `-90` degrees to `0` at the top-left corner.
3. **Apply the Transition in a View**
   ```Swift
       struct ContentView: View {
        @State private var isShowingRed = false
    
        var body: some View {
            ZStack {
                Rectangle()
                    .fill(.blue)
                    .frame(width: 200, height: 200)
    
                if isShowingRed {
                    Rectangle()
                        .fill(.red)
                        .frame(width: 200, height: 200)
                        .transition(.pivot)
                }
            }
            .onTapGesture {
                withAnimation {
                    isShowingRed.toggle()
                }
            }
        }
      }
   ```
   - On tap, toggles `isShowingRed` with an animated pivot transition.

---------

**What are view Modifiers?**
  - A View Modifier in SwiftUI is a function that applies changes to a view. Modifiers do not change the original view; instead, they return a new modified view.
  - Each modifier returns a new modified view, making them chainable.
  - Custom view modifier.
**What are Custom View Modifiers?**
  - We can create our own view modifiers by conforming to the `ViewModifier` protocol.
    ```Swift
        struct HighlightedText: ViewModifier {
        func body(content: Content) -> some View {
            content
                .font(.headline)
                .padding()
                .background(.yellow)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
      }
    ```
    - Using the custom view modifier.
    ```Swift
      Text("Custom Modifier Example")
      .modifier(HighlightedText())  // Apply our custom modifier
    ```
**Extensions in SwiftUI**
  - Extensions allow us to add new functionality to existing types without modifying their original definition.
    Adding a Custom Modifier via Extension:
    ```Swift
        extension View {
        func highlighted() -> some View {
            self.modifier(HighlightedText())
        }
      }
    ```
    Now we can apply it like this:
    ```Swift
    Text("Hello, SwiftUI!")
    .highlighted()  // Uses our custom modifier via extension
    ```

----------
**Key Points**
✔ View Modifiers modify views without changing the original view.<br>
✔ Custom View Modifiers allow reusable styles for multiple views.<br>
✔ Extensions help make custom modifiers easy to use.<br>
✔ AnyTransition can be extended to create custom view transitions.<br>
✔ `.modifier(active:identity:)` lets us animate a view from one state to another.<br>
