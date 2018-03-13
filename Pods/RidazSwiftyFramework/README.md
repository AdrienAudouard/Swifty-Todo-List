# Ridaz Swifty Framework

Many Swift 4 classes and extensions that simplify our lives.

## Array

### Remove 

Remove the first element that matches the condition in the handler and return it

```
let list = ["1", "2", "3"]

list.remove {$0 == "2"} -> 2 and list = ["1", "3"]
```

## Bool

### Not

Reverse the value of a Bool. Useful when the bool is optionnal because we can not use "!".

```
let b: Bool? false
b?.not -> True
```

## Collection

### After

Return the element after an element

```
let list = ["1", "2", "3"]

list.after("2") -> 3
list.after("3") -> nil
```

### Before

Return the element before an element

```
let list = ["1", "2", "3"]

list.before("2") -> 1
list.before("1") -> nil
```

## Optionnal 

### Then 

Execute a closure if the optionnal is not nil.

<pre>
	let test: String? = "Test"

	test.then {print($0)} -> <i>Test</i>
</pre>

## Reachability

### isInternetAvailable()

Return if true if internet is available and false if internet is not available

```
Reachability.isInternetAvailable() -> True or False
```

## UIColor

### UIColor(hexString: String)

Create a UIColor from his hex value.

```
let c: UIColor = UIColor(hexString: "#000000")
```

## UIImage

### imageWithImage(scaledToSize newSize:CGSize)

Scale the image to a new size 

```
let newImage = image.imageWithImage(scaledToSize :CGSize(width: 50, height: 50))
```