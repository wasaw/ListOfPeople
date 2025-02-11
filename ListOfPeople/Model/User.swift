//
//  User.swift
//  ListOfPeople
//
//

import Foundation

struct User: Identifiable, Decodable {
    let id = UUID()
    let avatar: String
    let name: String
    let latitude: Double
    let longitude: Double
}
