//
//  Summary.swift
//  CombineSwiftUI
//
//  Created by Oksana Poliakova on 13.02.2023.
//

import Foundation
import Combine
import UIKit

// Imperative programming (Swift, UIKit)

func getValue() {
    var b = 5
    var c = 1
    let a = b + c // 6

    b = 10
    c = 5
    // a = 6
    // until I request the result the value of var a will stay 6
    // for example, until I click on the button, the recalculation will not be
}

// Reactive programming (RxSwift, Combine)
// based on Observer pattern (pull -> push)

// Instead of properties and methods, objects have reactions that automatically recalculate the value, and other reactions depend on changes in these values.
func getReactiveValue() {
    var b = 5
    var c = 1
    let a = b + c // 6

    b = 10
    c = 5
    // a = 15
    // value a will be automatically recalculated based on the new values.
}

// MARK: - RXSwift

// Observables -> Operators -> Observers

// MARK: - Combine

/*
    - Publishers (type which send a data)
    - Subscribers (get a data from publishers)
    - Operators (function between publishers and subscribers: they are getting a data, doing something and publishing new data)
 */

protocol Publisher {
    associatedtype Output
    associatedtype Failure: Error
    
    // object we pass must be subscribed to protocol Subscriber
    // Output and Input must be of the same type
    // Failure must match
    // Input and Output can be any type, Failure is restricted and can be only as protocol Error
    func receive<S>(subscriber: S) where S: Subscriber,
                                         Self.Failure == S.Failure,
                                         Self.Output == S.Input
}

protocol Subscriber {
    associatedtype Input
    associatedtype Failure: Error
}

// MARK: - Example of using

// extension for name
extension Notification.Name {
    static let event = Notification.Name("signal")
}

// object's description for sending
struct People {
    let name: String
}

// label for subscribing
let nameLabel = UILabel()

func subscribe() {
    // create a publisher with map (transformation to some type)
    // we check if the object is People, we use his property "name" and in this case we're getting a string from "name"
    let namePublisher = NotificationCenter.Publisher(center: .default, name: .event).map { ($0.object as? People)?.name }

    // create a subscriber, keyPath - properties of the object, we subscribe to the text changing
    let nameSubscriber = Subscribers.Assign(object: nameLabel, keyPath: \.text)

    // subscribe to Publisher
    namePublisher.subscribe(nameSubscriber)
}

func getResult() {
    // create the object for sending to label
    let people = People(name: "John")
    
    // send a signal with People object
    NotificationCenter.default.post(name: .event, object: people)
    
    // getting the result
    print(String(describing: nameLabel.text))
}
