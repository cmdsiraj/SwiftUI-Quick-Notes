### textInputAutocapitalization() (Text input configuration method)
  - Used to controel the Auto Capitalization of Text entered into ***TextField***
  - `textInputAutocapitalization(.never)` disables the auto capitalization.
  - Available Options:
      - `.never` → No auto-capitalization.
      - `.sentences` → Capitalizes the first letter of each sentence.
      - `.words` → Capitalizes the first letter of each word.
      - `.allCharacters` → Capitalizes all characters.

### fatalError() (function)
  - lets us respond to unresolvable problems really clearly.
  - When we call `fatalError()` it will – unconditionally and always – cause our app to crash.

### onSubmit() (view method)
  - Adds an action to be performed when a submit event occurs, such as pressing the return key in a TextField or SecureField.
  - Takes a function as arguments which doesn't has any arguments and doesn't return anything.

### .onAppear(perform:)
  - view modifier for running a closure when a view is shown.

    
----
Loading a resouce (start.txt) into our app. (when we compile our app, it creates a bundel which contains our binary code, assets, files and other things which are used by our app)
```Swift
func startGame() {
    // 1. Find the URL for start.txt in our app bundle
    if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
        // 2. Load start.txt into a string
        if let startWords = try? String(contentsOf: startWordsURL) {
            // 3. Split the string up into an array of strings, splitting on line breaks
            let allWords = startWords.components(separatedBy: "\n")

            // 4. Pick one random word, or use "silkworm" as a sensible default
            rootWord = allWords.randomElement() ?? "silkworm"

            // If we are here everything has worked, so we can exit
            return
        }
    }

    // If were are *here* then there was a problem – trigger a crash and report the error
    fatalError("Could not load start.txt from bundle.")
}
```
