### Explicit Animations
- Explicit animations let you manually trigger animations when a state change occurs.
- Explicit animations use `withAnimation {}` to animate state changes directly.
- Unlike implicit animations, they are not attached to a specific view or binding.
- Unlike implicit animations, this approach gives you full control over when and how the animation happens.

- ```Swift
  struct ContentView: View {
    @State private var animationAmount = 0.0

    var body: some View {
        Button("Tap Me") {
            withAnimation(.spring(duration: 1, bounce: 0.5)) {
                animationAmount += 360
            }
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
    }
  }
  ```
  ***Key Takeaways***
  - `withAnimation {}` smoothly animates state changes instead of applying them instantly.
  - `rotation3DEffect()` creates a rotating effect along a specified axis.
  - Using `.spring(duration: 1, bounce: 0.5)`, you can make the movement feel more natural.
 


#### Extra Notes
- `.rotation3DEffect` is a view modifier that applies a 3D rotation effect to a view.
- you animate a state variable that controls its rotation (e.g., angle in .rotation3DEffect(.degrees(angle), axis: (x: 0, y: 1, z: 0))),
  SwiftUI interpolates between values, creating a smooth transition. (Example of ***[Animating Bindings](Animating%20Bindings.md)***)
- To animate it, you need to wrap the state change inside `withAnimation {}` (Explicit Binding) or attach an animation modifier (Implicit Binding) to the binding.
