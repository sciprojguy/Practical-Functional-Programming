// Playground - noun: a place where people can play

import Foundation

/** samples of functions and closures **/

// function takes a single string parameter,
// returns Bool
func coffeeTest( word:String) -> Bool {
    return word.lowercaseString == "coffee"
}

if coffeeTest("coffee") {
    println("yes, it's coffee")
}

if coffeeTest("CoffEE") {
    println("yes, it's coffee")
}

if coffeeTest("0x0c0ffee") {
    println("yes, it's coffee")
}

// closure that does the same thing
let coffeeTest2 = {(word:String) -> Bool in
    return word.lowercaseString == "coffee"
}

if coffeeTest2("coffee") {
    println("yes, it's coffee")
}

if coffeeTest2("CoffEE") {
    println("yes, it's coffee")
}

if coffeeTest2("0x0c0ffee") {
    println("yes, it's coffee")
}

// function that generates a closure
func drinkTest( name:String ) -> (drinkName:String) -> Bool {
    return {(drink:String) -> Bool in
        return drink.lowercaseString == name.lowercaseString
    }
}

let coffeeTest3 = drinkTest("coffee")

if coffeeTest3(drinkName:"coffee") {
    println("yes, it's coffee")
}

if coffeeTest3(drinkName:"CoffEE") {
    println("yes, it's coffee")
}

if coffeeTest3(drinkName:"0x0c0ffee") {
    println("yes, it's coffee")
}

let chaiTest = drinkTest("chai tea")

if chaiTest(drinkName: "chai tea") {
    println("yes, it's chai tea")
}

if chaiTest(drinkName: "tai chi") {
    println("yes, it's chai tea")
}

// same thing but using a custom closure type
// for neatness

typealias DrinkTestClosure = ( drinkName : String) -> Bool

let herbalTeaTest:DrinkTestClosure = {(d:String) -> Bool in
        return d.lowercaseString == "herbal tea"}

if herbalTeaTest(drinkName:"herbal tea") {
    println("yes, it is herbal tea")
}

if herbalTeaTest(drinkName:"Herbal Tea") {
    println("yes, it is herbal tea")
}

if herbalTeaTest(drinkName:"herbal tease") {
    println("yes, it is herbal tea")
}

