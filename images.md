- When we create an Image view in SwiftUI, it will automatically size itself according to the dimensions of its contents. So, if the picture is `1000x500`, the Image view will also be `1000x500`.
- `.clipped()`: Clips the image to frame size.
  
  > `Image` has `.frame()` but it won't directly. we need to use `clip` to change the image size to frame size. but `clip` will cut the image which is out of thia box (frame).
  ```swift
  Image(.example)
    .frame(width: 300, height: 300)
    .clipped()

- If you want the image contents to be resized too, we need to use the resizable() modifier like this:
  ```swift
  Image(.example)
    .resizable()
    .frame(width: 300, height: 300)

- To rezise image itself proportionately, we can use `scaledToFit()` and `scaledToFill()` modifiers.
- #### `scaledToFit()`:
  The entire image will fit inside the container even if that means leaving some parts of the view empty.
  ```swift
  Image(.example)
    .resizable()
    .scaledToFit()
    .frame(width: 300, height: 300)
  
- #### `scaledToFill()`:
  The second means the view will have no empty parts even if that means some of our image lies outside the container.
  ```swift
  Image(.example)
    .resizable()
    .scaledToFill()
    .frame(width: 300, height: 300)
- Instead of hardcoding the size, we can set image size dynamically relative to its parents container using `containerRelativeFrame()`.
  ```swift
  Image(.example)
    .resizable()
    .scaledToFit()
    .containerRelativeFrame(.horizontal) { size, axis in
        size * 0.8
    }

Let's break that code down:
1. We're saying we want to give this image a frame relative to the horizontal size of its parent. We aren't specifying a vertical size; more on that in a moment.
2. SwiftUI then runs a closure where we're given a size and an axis. For us the axis will be .horizontal because that's the one we're using, but this matters more when you create relative horizontal and vertical sizes. The size value will be the size of our container, which for this image is the full screen.
3. We need to return the size we want for this axis, so we're sending back 80% of the container's width.
