## Grid Types

- `LazyVGrid`: Vertical scrolling grid.
- `LazyHGrid`: Horizontal scrolling grid.
- "Lazy" means views are created on demand for better performance.

---

## Step 1: Define Layout

### Fixed Columns (3 columns, each 80 pts wide)

```swift
let layout = [
    GridItem(.fixed(80)),
    GridItem(.fixed(80)),
    GridItem(.fixed(80))
]
```
### Adaptive
- Adapts number of columns based on screen size.
- Commonly used for responsive grid designs.

#### Adaptive Columns (minimum width 80pts)
```swift
let layout = [
    GridItem(.adaptive(minimum: 80))
]
```

#### Adaptive Columns (maximum width)
```swift
let layout = [
    GridItem(.adaptive(minimum: 80, maximum: 120))
]
```
## Step 2: Use in ScrollView
### Vertical Grid
```swift
ScrollView {
    LazyVGrid(columns: layout) {
        ForEach(0..<1000) {
            Text("Item \($0)")
        }
    }
}
```
### Horizontal Grid
```swift
ScrollView(.horizontal) {
    LazyHGrid(rows: layout) {
        ForEach(0..<1000) {
            Text("Item \($0)")
        }
    }
}
```

## Overview
- Grids need layout + scroll view.
- `LazyVGrid` → uses columns.
- `LazyHGrid` → uses rows.
- Prefer adaptive layout for responsive designs.
