## List View
  - It provides a scrollable table of data.
  - It is identical to ***Form***, except it is used to represent data rather than requesting user input. Infact, ***Form*** is a specialized form of ***List***.
  - List Example:
      ```Swift
      List {
        Text("Hello World")
        Text("Hello World")
        Text("Hello World")
      }
      ```
  - We can use ***ForEach*** to display the content in the ***List View*** dynamically.
      ```Swift
        List {
          ForEach(0..<5) {
            Text("Dynamic row \($0)")
          }
        }
      ```
      ```Swift
        List {
          Text("Static row 1")
          Text("Static row 2")
  
          ForEach(0..<5) {
            Text("Dynamic row \($0)")
          }
  
          Text("Static row 3")
          Text("Static row 4")
        }
    ```
    ```Swift
        List {
          Section("Section 1") {
            Text("Static row 1")
            Text("Static row 2")
        }

        Section("Section 2") {
            ForEach(0..<5) {
                Text("Dynamic row \($0)")
            }
        }

      Section("Section 3") {
          Text("Static row 3")
          Text("Static row 4")
      }
    }
    ``` 
- We can adjust how the list looks using the `listStyle()` modifier, like this:
  ```Swift
  .listStyle(.grouped)
  ```
- Unlike ***Form***, a ***List*** can generate it's contents dynamically with the use of ***ForEach***.
  So if your entire list is made of dynamic rows, you can do this:
  ```Swift
    List(0..<5) {
      Text("Dynamic row \($0)")
    }
  ```
  ------------------------

**The id Parameter**
- When working with an array of data, ***SwiftUI*** still needs to know how to identify each row uniquely, so if one gets removed it can simply remove that one rather than having to redraw the whole list. This is where the `id` parameter comes in, and it works identically in both **List** and **ForEach** – it lets us tell SwiftUI exactly what makes each item in the array unique.
- When working with this kind of list data, we use id: \.self like this:
  ```Swift
    struct ContentView: View {
      let people = ["Finn", "Leia", "Luke", "Rey"]
  
      var body: some View {
          List(people, id: \.self) {
              Text($0)
          }
      }
    }
  ```
  ```Swift
    List {
      Text("Static Row")
  
      ForEach(people, id: \.self) {
          Text($0)
      }
  
      Text("Static Row")
    }
  ```
    
