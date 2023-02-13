//
//  Theory.swift
//  CombineSwiftUI
//
//  Created by Oksana Poliakova on 12.02.2023.
//

import Foundation

// MARK: - Generics

// MARK: - Example 1

// T - I can use any types (can be Int or String). It's a template, flexible generic data type.

func age<T>(value: T) -> String {
    return String("Age is \(value)")
}

class SomeGenericClass<T> {
    var someProperty: T
    
    init(someProperty: T) {
        self.someProperty = someProperty
    }
}

func useGeneric() {
    let someGenericWithString = SomeGenericClass(someProperty: "String")
    let someGenericWithBool = SomeGenericClass(someProperty: true)
    let someGenericWithInt = SomeGenericClass(someProperty: 5)
}

func displayData<T>(data: T) {
    print(data)
}

// MARK: - Example 2

func substraction<T: Numeric>(first: T, second: T) -> T {
    return first - second
}

class OneMoreGenericClass<T, U> {
    var property1: T
    var property2: U
    
    init(property1: T, property2: U) {
        self.property1 = property1
        self.property2 = property2
    }
}

func useGeneric2() {
    let useTestGeneric = OneMoreGenericClass(property1: "Joe", property2: "Smith")
    let useTestGeneric2 = OneMoreGenericClass(property1: 100, property2: true)
}

// MARK: - Example 3

func checkOldest<T: SignedInteger>(age1: T, age2: T) -> String {
    if age1 > age2 {
        return "First is older"
    } else if age1 == age2 {
        return "Age is similar"
    } else {
        return "Second is older"
    }
}

// MARK: - Example 4 associatedtype & typealias

// If we need a generic for protocol we can use an associatedtype

protocol GameScore {
    associatedtype Score // Can be all types: String, Int, Array etc.
    func calculateWinner(firstTeam: Score, secondTeam: Score) -> String
}

struct FootballGame: GameScore {
    // When implementing a protocol with an associated type, we must define a typealias with a specific type, or in a function, we must define the data type in the parameters.
    typealias Score = Int
    
    func calculateWinner(firstTeam: Score, secondTeam: Score) -> String {
        if firstTeam > secondTeam {
            return "First team has won"
        } else if firstTeam == secondTeam {
            return "Score is the same"
        } else {
            return "Second team has won"
        }
    }
}

// MARK: - Example 5 associatedtype & restrictions

protocol Teams {
    associatedtype Team: Collection // collection has restriction for collections: Dictionary, Range, Set
    var team1: Team { get set }
    var team2: Team { get set }
    func compareTeamSizes() -> String
}

struct WeekendGame: Teams {
    // Can be used without typealias, when we set values, for example, strings array
    var team1 = ["Player1", "Player2", "Player3"]
    var team2 = ["Player1", "Player2"]
    
    func compareTeamSizes() -> String {
        if team1.count > team2.count {
            return "The first team has more players"
        } else if team1.count == team2.count {
            return "Both teams are the same size"
        } else {
            return "The second team has more players"
        }
    }
    
    
}
