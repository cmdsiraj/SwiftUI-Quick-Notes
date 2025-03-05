### Gestures in SwiftUI
SwiftUI allows attaching gestures to views, enabling interaction and animation.
#### Drag Gesture
- `DragGesture()`: Detects dragging and provides translation values.
- `onChanged { }`: Updates state during drag.
- `onEnded { }`: Resets or modifies state after drag ends.
- Example: Dragging a card
  ```Swift
  @State private var dragAmount = CGSize.zero

  LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
      .frame(width: 300, height: 200)
      .clipShape(.rect(cornerRadius: 10))
      .offset(dragAmount)
      .gesture(
          DragGesture()
              .onChanged { dragAmount = $0.translation }
              .onEnded { _ in dragAmount = .zero }
      )
  ```
- `offset(CGSize)`: Moves view without affecting layout. (If you need to actually reposition a view within the layout (affecting surrounding views), you’d use `.position()` or `.frame()` instead.)
- View moves with drag and resets on release.
#### Animations
**Implicit Animations**
- Applies to all state changes affecting the view.
```Swift
.animation(.bouncy, value: dragAmount)
```
- `.bouncy`: Built-in animation with spring-like effect.
**Explicit Animations**
- Animates only specific actions inside `withAnimation()`.
  ```Swift
  .onEnded { _ in
    withAnimation(.bouncy) {
        dragAmount = .zero
    }
  }
  ```
- Immediate movement during drag, animated return on release.

##### Key Takeaways
- `DragGesture()` allows movement detection.
- `offset(CGSize)` adjusts position dynamically.
- Implicit animations apply to state changes automatically.
- `withAnimation()` enables controlled animations.
- Adding delay to animations creates fluid motion effects.
