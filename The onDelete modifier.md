- SwiftUI gives us the `onDelete()` modifier for us to use to control how objects should be deleted from a collection.
- We create a list of rows that are shown using `ForEach`, then attach `onDelete()` to that `ForEach` so the user can remove rows they don’t want.
- The `onDelete()` modifier only exists on `ForEach`, so if we want users to delete items from a list we must put the items inside a `ForEach`.
- In order to make `onDelete()` work, we need to implement a method that will receive a single parameter of type `IndexSet`. This is a bit like a set of integers, except it’s sorted, and it’s just telling us the positions of all the items in the `ForEach` that should be removed.
- Swift `arrays` have a special method called `remove(atOffsets:)` that accepts an index set. So, we can pass the indexset directly to the array from which we want to delete the objects.

```swift
struct ContentView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1

    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }

    var body: some View {
        VStack {
            List {
                ForEach(numbers, id: \.self) {
                    Text("Row \($0)")
                }
                .onDelete(perform: removeRows)
            }
        }
    }
}
```


- we can add an Edit/Done button to the navigation bar, that lets users delete several rows more easily.

First, wrap your `VStack` in a `NavigationStack`, then add this modifier to the `VStack`:
```swift
.toolbar {
    EditButton()
}
