//
//  User.swift
//  ListOfPeople
//
//

import Foundation

struct User: Decodable {
    let avatar: String
    let name: String
    let latitude: Double
    let longitude: Double
}
