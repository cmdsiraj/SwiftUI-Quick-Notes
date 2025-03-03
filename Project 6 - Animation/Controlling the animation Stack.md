**1. Modifier order matters:**
  - SwiftUI applies modifiers in sequence, wrapping views accordingly.
  - Example
    ```Swift
    Button("Tap Me") { }
    .background(.blue)  // Colors only the original size
    .frame(width: 200, height: 200)  // Expands but background remains unchanged
    ```
**2. Implicit Animations with `.animation()`:**
  - Attaching `.animation()` to a view animates state changes.
  - Example
    ```Swift
    @State private var enabled = false
    Button("Tap Me") {
        enabled.toggle()
    }
    .frame(width: 200, height: 200)
    .background(enabled ? .blue : .red)
    .animation(.default, value: enabled)  // Background color change animates
    ```
**3. Animation order matters:**
  - Only changes before `.animation()` get animated.
  - Example
    ```Swift
    .clipShape(.rect(cornerRadius: enabled ? 60 : 0))
    .animation(.default, value: enabled)  // Animates shape change
    ```
**4. Multiple Animations for Different Effects:**
  - Each `.animation()` applies only to the changes before it.
  - Example:
    ```Swift
      Button("Tap Me") {
        enabled.toggle()
      }
      .frame(width: 200, height: 200)
      .background(enabled ? .blue : .red)
      .animation(.default, value: enabled)  // Background change animates smoothly
      .clipShape(.rect(cornerRadius: enabled ? 60 : 0))
      .animation(.spring(duration: 1, bounce: 0.6), value: enabled)  // Shape change animates with spring effect
    ```
**5. Disabling Specific Animations:**
  - Pass `nil` to prevent an animation for a specific property.
  - Example:
    ```Swift
    .background(enabled ? .blue : .red)
    .animation(nil, value: enabled)  // Color change happens instantly
    .clipShape(.rect(cornerRadius: enabled ? 60 : 0))
    .animation(.spring(duration: 1, bounce: 0.6), value: enabled)  // Shape still animates  
    ```
**Conclusion**
  - Modifier order affects animations.
  - `.animation()` only applies to preceding changes.
  - Multiple `.animation()` calls allow fine control.
  - `animation(nil, value:)` disables specific animations.
