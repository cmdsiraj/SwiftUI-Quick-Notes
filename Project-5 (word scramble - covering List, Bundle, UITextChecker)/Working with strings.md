### **components(seperatedBy:)**

  - Converts string to array of strings by breaking up wherever another string is found.
  - Below Examples produces a array `["a", "b", "c"]`.
  ```Swift
      let input = "a b c"
      let letters = input.components(seperatedBy: " ")
  ```

### **randomElement()**
  - Returns one random item from an Array.
    ```Swift
      let letter = letters.randomElement()
    ```
  - Now, although we can see that the letters array will contain three items, Swift doesn’t know that – perhaps we tried to split up an empty string, for example. As a result, the `randomElement()` method returns an optional string, which we must either unwrap or use with nil coalescing.

**trimmingCharacters(in:)**
  - Asks Swift to remove certain kinds of characters from the start and end of a string. This uses a new type called `CharacterSet`, but most of the time we want one particular behavior: removing whitespace and new lines – this refers to spaces, tabs, and line breaks, all at once.
    ```Swift
      let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
    ```


### UITextChecker

- This class comes from `UIKit`. It's writtern in Apple's old language `Objective-C`
- Checking a string for misspelled words takes four steps in total.
  1. We create a word to check and an instance of `UITextChecker` that we can use to check that string:
     ```Swift
     let word = "Swift"
     let checker = UITextChecker()
     ```
  2. We need to tell the checker how much of our string we want to check.<br>
     Swift uses a very clever and advance way of working with strings. this allows it to use complex characters like emojis in exactly the same way that it uses English alphabets. However, Objective-C does not use this method of storing letters, which means we need to ask Swift to create an Objective-C string range using the entire length of all our characters, like this:
     ```Swift
       let range = NSRange(location: 0, length: word.utf16.count)
     ```
     ***UTF-16*** is what’s called a character encoding – a way of storing letters in a string. We use it here so that ***Objective-C*** can understand how Swift’s strings are stored.
  3. We can ask our text checker to report where it found any misspellings in our word, passing in the range to check, a position to start within the range (so we can do things like “Find Next”), whether it should wrap around once it reaches the end, and what language to use for the dictionary:
     ```Swift
       let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
     ```
     That sends back another Objective-C string range, telling us where the misspelling was found.
  4. ***Objective-C*** didn’t have any concept of optionals, so instead relied on special values to represent missing data.
     In this instance, if the Objective-C range comes back as empty – i.e., if there was no spelling mistake because the string was spelled correctly – then we get back the special value NSNotFound.
     ```Swift
       let allGood = misspelledRange.location == NSNotFound
     ```
