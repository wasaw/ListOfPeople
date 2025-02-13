//
//  User.swift
//  ListOfPeople
//
//

import Foundation

class User: Identifiable, Decodable {
//    MARK: - Properties
    let id = UUID()
    let avatar: String
    let name: String
    var latitude: Double
    var longitude: Double
    
//    MARK: - Lifecycle
    init(avatar: String, name: String, latitude: Double, longitude: Double) {
        self.avatar = avatar
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
//    MARK: - Helpers
    
    func updateCoordanates() {
        self.latitude = self.latitude + Double.random(in: -10...10)
        self.longitude = self.longitude + Double.random(in: -10...10)
    }
}
