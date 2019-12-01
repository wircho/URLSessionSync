# URLSessionSync (a.k.a. URLSession+Sync)

## Installation

On Xcode go to **File > Swift Packages > Add Package Dependencies** and enter this repository's URL.

## Usage

Suppose you have an URL string like the one below, displaying the JSON `{"latitude": 45.5070669, "longitude": -73.5565524}`. Alternatively this could be a `URL` or a `URLRequest`. 

```swift
let request = "data:text/plain;charset=utf-8;base64,eyJsYXRpdHVkZSI6IDQ1LjUwNzA2NjksICJsb25naXR1ZGUiOiAtNzMuNTU2NTUyNH0="
```
### Get the data synchronously:

```swift
let data = try URLSession.shared.sync(request).data
```

### Get the data as a string:

```swift
let string = try URLSession.shared.sync(request).string
```

### Decode the data to a custom `Decodable` type:

```swift
struct Coordinates: Decodable {
  let latitude: Double
  let longitude: Double
}
   
let coordinates = try URLSession.shared.sync(request).decoding(Coordinates.self)
```
