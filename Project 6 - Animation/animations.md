###  animation() --> view modifier
- adds animations to the views <br>
  ```Swift
  .animation(.default, value: animationAmount)
  ```
- That asks SwiftUI to apply a default animation whenever the value of `animationAmount` changes.
- That implicit animation takes effect on all properties of the view that change, meaning that if we attach more animating modifiers to the view then they will all change together.
- For example, we could add a second new modifier, .blur(), which lets us add a Gaussian blur with a special radius.
  ```Swift
  .blur(radius: (animationAmount - 1) * 3)
  ```
- It should be placed at the end of the modifier chain to ensure all modifications are animated.
- The default animation is smooth, but you can customize it with options like .easeInOut, .spring(), etc.
  ```Swift
    struct ContentView: View {
      @State private var animationAmount = 1.0
      var body: some View {
          VStack {
              Button("Tap me") {
                  animationAmount+=1
              }
              .padding(50)
              .background(.red)
              .foregroundStyle(.white)
              .clipShape(.circle)
              .scaleEffect(animationAmount)
              .blur(radius: (animationAmount-1)*3)
              .animation(.default, value: animationAmount)
              
          }
          .padding()
      }
    }
  ```
  ----

  ## Customizing animations
  - When attached, SwiftUI's `.animation()` modifier automatically animates any view changes using the default system animation whenever the watched value changes.
