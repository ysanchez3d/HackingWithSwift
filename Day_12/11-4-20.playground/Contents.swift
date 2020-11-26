import UIKit

//Optionals
    //optionals can be made out of any type

var age: Int? = nil

//Unwrapping optionals
    //using If/let

if let unwrapped = age {
    print("Unwrapped has a value")
} else {
    print("unwrapped was nil")
}

//Unwrapping using guard/let
    //main difference is that the unwrapped optional remains usable after the guard code.
    //guard/let lets you deal with problems at the start of your functions and exit immediately if theres an issue
func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didnt provide a name!")
        return
    }
    
    print("Hello \(name)!")
}

//Force unwrapping
age = Int("5")!

//implicitly unwrapped optionals
    //exist because sometimes a variable will start life as nil, but will always have a value before you need to use it, therefore you wont have to use if/let all the time

let num: Int! = nil

//Nil coalescing
let user1: String? = nil
let user = user1 ?? "use_this_if_user_is_nil"

//Optional chaining
    //when the chain doesnt contienue if something is nil

//Optional try

//Failable initializers
struct Person {
    var id: String

    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}

//Typecasting
class Animal { }
class Fish: Animal { }

class Dog: Animal {
    func makeNoise() {
        print("Woof!")
    }
}

let pets = [Fish(), Dog(), Fish(), Dog()]

for pet in pets {
    if let dog = pet as? Dog {
        dog.makeNoise()
    }
}


