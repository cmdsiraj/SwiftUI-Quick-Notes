# ScrollView
- Use `ScrollView` for scrolling arbitrary views.
- Supports `.vertical`, `.horizontal`, or both.
- Scroll indicators show content size.
  ```swift
  ScrollView {
      VStack(spacing: 10) {
          ForEach(0..<100) {
              Text("Item \($0)")
                  .font(.title)
          }
      }
  }
- To make whole area draggable:
  ```swift
  ScrollView {
    VStack(spacing: 10) {
        ForEach(0..<100) {
            Text("Item \($0)")
                .font(.title)
          }
      }
      .frame(maxWidth: .infinity)
  }

# View Creating behaviour
- `ScrollView` creates all views immediately, even off-screen.
  ```swift
      struct CustomText: View {
        let text: String
    
        var body: some View {
            Text(text)
        }
    
        init(_ text: String) {
            print("Creating a new CustomText")
            self.text = text
        }
    }
  
  ```swift
      ForEach(0..<100) {
        CustomText("Item \($0)")
            .font(.title)
    }
- Output: Logs 100 messages on load.

# Lazy Stacks: Efficient Rendering
- Use `LazyVStack` / `LazyHStack` to load views on-demand.
  
  ```swift
      ScrollView {
        LazyVStack(spacing: 10) {
            ForEach(0..<100) {
                CustomText("Item \($0)")
                    .font(.title)
            }
        }
        .frame(maxWidth: .infinity)
    }
- Lazy stacks take **full available space**, unlike regular stacks.

#  Horizontal ScrollView
- Specify `.horizontal` and use a horizontal stack:
  
  ```swift
    ScrollView(.horizontal) {
      LazyHStack(spacing: 10) {
          ForEach(0..<100) {
              CustomText("Item \($0)")
                  .font(.title)
          }
      }
  }
--------
