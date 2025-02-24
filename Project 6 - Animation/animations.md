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
  - some possible values for the .animation() modifier in SwiftUI:
    * `.default` – Smooth, natural animation.
    * `.linear(duration:)` – Moves at a constant speed.
    * `.easeIn(duration:)` – Starts slow, then speeds up.
    * `.easeOut(duration:)` – Starts fast, then slows down.
    * `.easeInOut(duration:)` – Starts and ends slow, with speed in the middle.
    * `.spring(response:dampingFraction:blendDuration:)` – Bouncy, spring-like motion.
    * `.interpolatingSpring(stiffness:damping:)` – More control over spring physics.

```Swift
    struct ContentView: View {
      @State private var animationAmount = 1.0
  
      var body: some View {
          Button("Tap Me") {
              animationAmount += 1
          }
          .padding(50)
          .background(.red)
          .foregroundStyle(.white)
          .clipShape(.circle)
          .scaleEffect(animationAmount)
          .animation(.easeInOut(duration: 2), value: animationAmount)
      }
  }
```
- When we say `.easeInOut(duration: 2)` we’re actually creating an instance of an Animation struct that has its own set of modifiers. So, we can attach modifiers directly to the animation to add a delay like this:
  ```Swift
    .animation(
      .easeInOut(duration: 2)
          .delay(1),
      value: animationAmount
    )
  ```
- We can repeat animations and make them bounce using autoreverses: true:
  ```Swift
    .animation(
      .easeInOut(duration: 1)
          .repeatCount(3, autoreverses: true),
      value: animationAmount
    )
  ```
- For continuous animations, there is a repeatForever() modifier that can be used like this:
  ```Swift
    .animation(
    .easeInOut(duration: 1)
        .repeatForever(autoreverses: true),
    value: animationAmount
    )
  ```


