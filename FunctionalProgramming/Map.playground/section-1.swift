// Playground - noun: a place where people can play

import Foundation

/***
something simple at first - list of first names, want an array of uppercased first names.
 ***/

let names = [ "Jimmy", "Jane", "Tarzan", "Golem", "Fred" ]

let uppercaseNames = map( names, { (name:String) -> String in return name.uppercaseString } )
println(uppercaseNames)

/***
now something a bit more complex, like mapping structures
 ***/

struct User {
    var name:String
    var failedPasswords:Int
    var locked:Bool
    init(name:String,failedLoginAttempts:Int) {
        self.name = name
        self.failedPasswords = failedLoginAttempts
        if failedLoginAttempts > 2 {
            self.locked = true
        }
        else {
            self.locked = false
        }
    }
    func toString() -> String {
        return "name:\(name), failures:\(failedPasswords), locked:\(locked)"
    }
}

let users:[User] = [
    User(name: "gjungle", failedLoginAttempts: 0),
    User(name: "ursula", failedLoginAttempts: 3),
    User(name: "myboss", failedLoginAttempts:1 )
]

// now map() to generate a new users list with accounts unlocked
let unlockedUsers:[User] = map(users, {(user:User) -> User in
    let newUser:User = User(name: user.name, failedLoginAttempts: 0)
    return newUser
})

let u1:String = users[0].toString()
let u2:String = users[1].toString()

