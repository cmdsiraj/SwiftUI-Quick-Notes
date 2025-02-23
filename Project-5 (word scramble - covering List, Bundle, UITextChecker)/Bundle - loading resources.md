## Loading resources from your app bundle

- When we use ***Image*** view, our Swift app knows from where to load the image from. it even automatically adjusts the artwork so it loads the correct picture for the current screen resolution.

- For other data, such as text files, we need to do more work. This also applies if you have specific data formats such as XML or JSON – it takes the same work regardless of what file types you’re loading.

- When Xcode builds your iOS app, it creates something called a “bundle”. it allows the system to store all the files for a single app in one place – the binary code (the actual compiled Swift stuff we wrote), all the artwork, plus any extra files we need all in one place.

- To look in a bundle for a file you placed there, SwiftUI uses a new data type called ***URL***. URLs here are a bit more powerful than just storing web addresses – they can also store the locations of files, which is why they are useful here.
- If we want to read the URL for a file in our main app bundle, we use Bundle.main.url(). If the file exists it will be sent back to us, otherwise we’ll get back nil, so this is an optional URL. That means we need to unwrap it like this:
  ```Swift
    if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
      // we found the file in our bundle!
    }
  ```
- Once we have a URL, we can load it into a string with a special initializer: `String(contentsOf:)`. We give this a file URL, and it will send back a string containing the contents of that file if it can be loaded. If it can’t be loaded it throws an error, so you need to call this using `try` or `try?` like this:
  ```Swift
    if let fileContents = try? String(contentsOf: fileURL) {
      // we loaded the file into a string!
    }
  ```
