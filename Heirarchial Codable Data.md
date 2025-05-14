# Codable with Nested JSON – Quick Notes
- `Codable` protocol is used to decode and encode JSON.
- Works seamlessly for flat data: single instances, arrays, and dictionaries.
- Can also handle nested (hierarchical) JSON structures by creating corresponding nested Swift structs.

-----

## Example JSON

```json
{
    "name": "Taylor Swift",
    "address": {
        "street": "555, Taylor Swift Avenue",
        "city": "Nashville"
    }
}
```
## Corresponding Swift Structs
```swift
struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}
```
- Outer structure User contains a `name` and an `address`.
- Address is a nested structure containing `street` and `city`.
## JSON DECODING EXAMPLE
```swift
let data = Data(input.utf8)
let decoder = JSONDecoder()
if let user = try? decoder.decode(User.self, from: data) {
    print(user.address.street)
}
```
- JSON string is converted to `Data` using `utf8`.
- `JSONDecoder` is used to decode the data into a `User` instance.
- Access nested properties directly after decoding.

## Key Notes
- Separate structs must be defined for each level in the `JSON` hierarchy.
- Property names in Swift structs must match JSON keys (or use `CodingKeys` if different).
- No limit to nesting depth as long as the hierarchy matches.
- Codable decoding fails silently with `try?`, returning `nil` if structure mismatches.
